# # key_pair
resource "aws_key_pair" "this_key_pair" {
  key_name   = "terra_key_ec2"
  public_key = file("terra_key_ec2.pub")
}

# netwoking 

module "networking" {
  source = "../module/networking/"

  cidr_block                  = var.cidr_block
  project_name                = var.project_name
  aws_public_subnet_cidrs_az  = var.aws_public_subnet_cidrs_az
  aws_private_subnet_cidrs_az = var.aws_private_subnet_cidrs_az
}

# application security group 

module "lb_security_group" {
  source = "../module/security/"

  name_prefix = "alb_sg-"

  description = "for application load balancer!"

  vpc_id = module.networking.vpc_id

  ingress_source_ip = "0.0.0.0/0"

  allowed_ports = var.allowed_ports

}


# launch template

module "launch_template" {
  source = "../module/compute/launch_template"

  project_name  = var.project_name
  db_secret_arn = aws_secretsmanager_secret.db.arn

  name_prefix       = var.name_prefix
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = aws_key_pair.this_key_pair.key_name
  lt_security_group = [module.lb_security_group.aws_security_group_id]

  user_data = base64encode(
    templatefile(
      "${path.module}/templates/user_data.sh",
      {
        cloudwatch_config = file("${path.root}/templates/cloudwatch-agent.json")
        region            = var.region
        ecr_repository    = data.terraform_remote_state.bootstrap.outputs.ecr_repository_url
        docker_image      = "${data.terraform_remote_state.bootstrap.outputs.ecr_repository_url}:${var.docker_image_tag}"
      }
    )
  )
}

# load balancer

module "load-balancer" {
  source = "../module/load-balancer/alb/"

  project_name = "${var.project_name}-lb"

  security_group_ids = [module.lb_security_group.aws_security_group_id]

  subnets = values(module.networking.aws_public_subnet_ids)

  load_balancer_type = "application"

  tags = {
    Name = "${var.project_name}-lb"
  }
}

# http listner 

module "http_listner" {
  source = "../module/load-balancer/listner/http"

  load_balancer_arn = module.load-balancer.alb_arn
  port              = 80
  protocol          = "HTTP"

  default_action_type = "redirect"

  redirect_port        = 443
  redirect_protocol    = "HTTPS"
  redirect_status_code = "HTTP_301"
}

# https listner

module "https_listner" {
  source = "../module/load-balancer/listner/https"

  port     = 443
  protocol = "HTTPS"

  load_balancer_arn   = module.load-balancer.alb_arn
  target_group_arn    = module.tg-group.target_group_arn
  certificate_arn     = aws_acm_certificate.app_cert.arn
  default_action_type = "forward"
}

# target group 

module "tg-group" {
  source = "../module/load-balancer/tg-group/"


  project_name = "${var.project_name}-tg"
  vpc_id       = module.networking.vpc_id

  target_group_port     = 80
  target_group_protocol = "HTTP"

  health_check_path     = "/"
  health_check_timeout  = 30
  health_check_interval = 120

  tags = {
    Name = "${var.project_name}-tg"
  }

}

# asg

module "asg" {
  source = "../module/compute/asg"

  desired_capacity = 2
  min_size         = 1
  max_size         = 4

  private_subnet_ids = values(module.networking.aws_private_subnet_ids)

  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_latest_version

  target_group_arn = module.tg-group.target_group_arn

  tags = {
    Name = "${var.project_name}-asg"
  }
}

# rds security group 

module "db_security_group" {
  source = "../module/security/"

  name_prefix = "rds_sg-"

  description = "for db instance!"

  vpc_id = module.networking.vpc_id

  ingress_source_ip = "10.0.0.0/16"
  allowed_ports     = var.allowed_ports

}

# rds 

module "rds" {
  source = "../module/database/"

  subnet_ids = values(module.networking.aws_private_subnet_ids)

  identifier     = "${var.project_name}-db"
  instance_class = var.instance_class

  storage      = var.storage
  storage_type = var.storage_type

  username = var.username
  password = var.password

  publicly_accessible = var.public_access

  engine         = var.engine
  engine_version = var.engine_version

  security_group = [module.db_security_group.aws_security_group_id]

  skip_final_snapshot = var.skip_final_snapshot
}

# secret manager for db instance 

resource "aws_secretsmanager_secret" "db" {
  name = "db_secret_manager"
}

resource "aws_secretsmanager_secret_version" "db" {

  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    host     = module.rds.host
    username = module.rds.username
    password = module.rds.password
    database = var.database_name
    port     = module.rds.port
  })


}

# monitoring 

module "monitoring" {
  source = "../module/monitoring"

  project_name = var.project_name

  desired_capacity       = module.asg.asg_desired_capacity
  asg_name               = module.asg.asg_name
  db_instance_identifier = module.rds.db_instance_identifier

  alb_arn_suffix          = module.load-balancer.alb_arn_suffix
  target_group_arn_suffix = module.tg-group.target_group_arn_suffix

  email_endpoint = var.email_endpoint
}

