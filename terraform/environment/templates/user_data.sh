#!/bin/bash
set -eux

exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "Waiting for network..."

until curl -4 -fsS https://google.com >/dev/null 2>&1; do
    echo "Network not ready. Retrying in 10 seconds..."
    sleep 10
done

echo "Network is ready."

# Update packages
until apt-get update -y; do
    echo "apt update failed. Retrying in 10 seconds..."
    sleep 10
done

# Install packages
apt-get install -y docker.io curl unzip wget

# Enable Docker
systemctl enable docker
systemctl start docker

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip

unzip -o awscliv2.zip

./aws/install

# Install CloudWatch Agent
wget https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

dpkg -i -E amazon-cloudwatch-agent.deb

# CloudWatch  config 
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/

cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'EOF'
${cloudwatch_config}
EOF

systemctl enable amazon-cloudwatch-agent
systemctl restart amazon-cloudwatch-agent

# Wait for Docker
until docker info >/dev/null 2>&1; do
    sleep 2
done

# Login ECR
aws ecr get-login-password \
  --region ${region} \
  | docker login \
  --username AWS \
  --password-stdin ${ecr_repository}

# Pull image
docker pull ${docker_image}

# Remove old container
docker rm -f karfect-app || true

# Run container
docker run -d \
  --name karfect-app \
  -p 80:80 \
  -v /var/log/karfect:/var/www/html/storage/logs \
  --restart unless-stopped \
  ${docker_image}