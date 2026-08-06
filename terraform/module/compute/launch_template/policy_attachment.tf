# ecr read only

resource "aws_iam_role_policy_attachment" "ecr" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}

# cloudwatch agent

resource "aws_iam_role_policy_attachment" "cloudwatch" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}

# system manager

resource "aws_iam_role_policy_attachment" "ssm" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

# db secret

resource "aws_iam_role_policy_attachment" "secret" {

  role = aws_iam_role.ec2_role.name

  policy_arn = aws_iam_policy.secrets_read.arn

}