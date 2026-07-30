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
