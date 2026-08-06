# snf and email 

variable "project_name" {
  type = string
}

variable "email_endpoint" {
  type = string
}

variable "common_tags" {
  type = map(string)
  default = {}
}

# alb 

variable "email_endpoint" {
  type = string
}

variable "alb_arn_suffix" {
  type = string
}

variable "target_group_arn_suffix" {
  type = string
}

# asg 

variable "asg_name" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "asg_alarm_config" {

  type = object({

    pending_instances = number

  })

  default = {

    pending_instances = 2

  }

}

# rds

variable "db_instance_identifier" {
  description = "RDS Instance Identifier"
  type        = string
}

variable "rds_alarm_config" {

  type = object({

    cpu_utilization      = number

    database_connections = number

    free_storage_space   = number

    freeable_memory      = number

  })

  default = {

    cpu_utilization      = 80

    database_connections = 80

    free_storage_space   = 5368709120

    freeable_memory      = 268435456

  }

}

# dashboard

variable "dashboard_name" {
  description = "CloudWatch Dashboard Name"
  type        = string
  default     = null
}