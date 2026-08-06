#!/bin/bash
set -eux

exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

########################################
# Update Packages
########################################

apt-get update -y

########################################
# Install Required Packages
########################################

apt-get install -y \
    docker.io \
    curl \
    unzip \
    wget

########################################
# Enable Docker
########################################

systemctl enable docker
systemctl start docker

########################################
# Install AWS CLI v2
########################################

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o awscliv2.zip

unzip -o awscliv2.zip

./aws/install

########################################
# Install CloudWatch Agent
########################################

wget https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

dpkg -i -E amazon-cloudwatch-agent.deb

########################################
# Copy CloudWatch Config
########################################

mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/

cat >/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'EOF'
${cloudwatch_config}
EOF

########################################
# Start CloudWatch Agent
########################################

systemctl enable amazon-cloudwatch-agent

systemctl restart amazon-cloudwatch-agent

########################################
# Wait Docker
########################################

until docker info >/dev/null 2>&1; do
    sleep 2
done

########################################
# Login ECR
########################################

aws ecr get-login-password \
    --region ${region} \
    | docker login \
    --username AWS \
    --password-stdin ${ecr_repository}

########################################
# Pull Image
########################################

docker pull ${docker_image}

########################################
# Remove Old Container
########################################

docker rm -f karfect-app || true

########################################
# Run New Container
########################################

docker run -d \
  --name karfect-app \
  -p 80:80 \
  -v /var/log/karfect:/var/www/html/storage/logs \
  --restart unless-stopped \
  ${docker_image}