# region 

variable "region" {
  type = string
  default = "us-east-1"
}


variable "project_name" {
  type = string
  default = "multi-az-zero-downtime"
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "aws_public_subnet_cidrs_az" {
  type = map(object({
    cidr = string
    az = string
  }))

  default = {
    public-a = {
        cidr = "10.0.1.0/24"
        az = "us-east-1a"
    }

    public-b = {
        cidr = "10.0.2.0/24"
        az = "us-east-1b"
    }
  }
}

variable "aws_private_subnet_cidrs_az" {
  type = map(object({
    cidr = string
    az = string
  }))
  
  default = {
    private-a = {
        cidr = "10.0.3.0/24"
        az = "us-east-1a"
    }

    private-b = {
        cidr = "10.0.4.0/24"
        az = "us-east-1b"
    }
  }
}

variable "allowed_ports" {
  default = {
    ssh = 22,
    http = 80,
    https = 443
  }
}

# launch template

variable "name_prefix" {
  type = string
  default = "multi-az-lt-"
}

variable "ami_id" {
  type = string
  default = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type" {
  type = string
  default = "t3.small"
}

# RDS ----------------------------------------------------------------------

variable "storage" {
  default = 30
}

variable "storage_type" {
  default = "gp2"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "8.4.8"
}

variable "username" {
  default = "admin"
}


variable "password" {
  default = "Sandip1234"
}

variable "database_name" {
  default = "karfect"
}

variable "public_access" {
  default = false
}

variable "skip_final_snapshot" {
  default = true
}

# end point for alert

variable "email_endpoint" {
  default = "konjno29@gmail.com"
  type = string
}

variable "docker_image_tag" {
  type        = string
  description = "Docker image tag to deploy"
}