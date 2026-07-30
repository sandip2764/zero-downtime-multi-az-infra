variable "load_balancer_arn" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "ssl_policy" {
  type = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "default_action_type" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "certificate_arn" {
  type = string
}