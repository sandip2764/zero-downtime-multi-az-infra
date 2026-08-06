# launch template

resource "aws_launch_template" "app_lt" {

  name_prefix = var.name_prefix

  image_id = var.ami_id

  instance_type = var.instance_type

  key_name = var.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  vpc_security_group_ids = var.lt_security_group

  user_data = var.user_data

}