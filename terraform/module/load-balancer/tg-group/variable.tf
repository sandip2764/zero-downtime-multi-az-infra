variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "target_group_port" {
  type    = number
}

variable "target_group_protocol" {
  type    = string
}


variable "health_check_path" {
  type    = string
}

variable "health_check_timeout" {
  type    = number
}

variable "health_check_interval" {
  type    = number
}

variable "tags" {
  type    = map(string)
  default = {}
}