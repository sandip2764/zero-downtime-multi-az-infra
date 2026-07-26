# netwoking 

module "networking" {
  source = "../module/networking/"

  cidr_block = var.cidr_block
  project_name = var.project_name
  aws_public_subnet_cidrs_az = var.aws_public_subnet_cidrs_az
  aws_private_subnet_cidrs_az = var.aws_private_subnet_cidrs_az
}