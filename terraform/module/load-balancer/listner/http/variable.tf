variable "load_balancer_arn" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "default_action_type" {
  type = string
}

variable "redirect_port" {
  type = number
}

variable "redirect_protocol" {
  type = string
}

variable "redirect_status_code" {
  type = string
}