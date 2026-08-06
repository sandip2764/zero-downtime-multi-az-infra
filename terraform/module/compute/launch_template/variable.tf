# launch template

variable "name_prefix" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "lt_security_group" {
  type = list(string)
}

variable "user_data" {
  type = string
  default = ""
}

# IAM 

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "db_secret_arn" {
  description = "Secrets Manager ARN for database credentials"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default = {}
}