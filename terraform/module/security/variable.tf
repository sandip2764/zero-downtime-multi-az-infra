variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "description" {
  type = string
}

variable "allowed_ports" {
  type = map(number)
}

variable "ingress_source_ip" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}
