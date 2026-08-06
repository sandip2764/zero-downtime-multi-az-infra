# launch template ------

output "launch_template_id" {
  value = aws_launch_template.app_lt.id
}

output "launch_template_latest_version" {
  value = aws_launch_template.app_lt.latest_version
}

# iam module 

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "instance_profile_arn" {
  value = aws_iam_instance_profile.ec2_profile.arn
}

output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "ec2_role_arn" {
  value = aws_iam_role.ec2_role.arn
}