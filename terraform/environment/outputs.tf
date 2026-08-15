# networking

output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.aws_public_subnet_ids
}

output "private_subnet_ids" {
  value = module.networking.aws_private_subnet_ids
}

output "internet_gateway_id" {
  value = module.networking.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.networking.nat_gateway_id
}

# sg-group

output "aws_security_group" {
  value = module.lb_security_group.aws_security_group_id
}

# lt

output "launch_template_id" {
  value = module.launch_template.launch_template_id
}

output "launch_template_version" {
  value = module.launch_template.launch_template_latest_version
}

# lb

output "alb_arn" {
  value = module.load-balancer.alb_arn
}

output "alb_dns_name" {
  value = module.load-balancer.alb_dns_name
}

output "alb_zone_id" {
  value = module.load-balancer.alb_zone_id
}

# tg 

output "target_group_arn" {
  value = module.tg-group.target_group_arn
}

# rds 
output "endpoint" {
  value = module.rds.rds_endpoint
}

# db secret arn

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}

