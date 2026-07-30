variable "project_name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "internal" {
  type    = bool
  default = false
}

variable "load_balancer_type" {
  type    = string
#   default = "application"
}

variable "tags" {
  type    = map(string)
  default = {}
}