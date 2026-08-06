locals {

  alarm_defaults = {

    evaluation_periods = 2

    period = 300

    actions_enabled = true

  }
  
  # alb

  alb_alarms = {

    response_time = {

      metric_name = "TargetResponseTime"

      statistic = "Average"

      threshold = 2

      comparison_operator = "GreaterThanThreshold"

      description = "ALB response time is high"

      target_group = true

    }

    target_5xx = {

      metric_name = "HTTPCode_Target_5XX_Count"

      statistic = "Sum"

      threshold = 5

      comparison_operator = "GreaterThanThreshold"

      description = "Application is returning 5XX"

      target_group = true

    }

    elb_5xx = {

      metric_name = "HTTPCode_ELB_5XX_Count"

      statistic = "Sum"

      threshold = 2

      comparison_operator = "GreaterThanThreshold"

      description = "ALB generated 5XX"

      target_group = false

    }

    healthy_hosts = {

      metric_name = "HealthyHostCount"

      statistic = "Average"

      threshold = 2

      comparison_operator = "LessThanThreshold"

      description = "Healthy hosts below threshold"

      target_group = true

    }

  }

  # asg

   asg_alarms = {

    in_service = {

      metric_name = "GroupInServiceInstances"

      statistic = "Average"

      threshold = var.desired_capacity

      comparison_operator = "LessThanThreshold"

      description = "Running instances below desired capacity"

    }

    pending = {

      metric_name = "GroupPendingInstances"

      statistic = "Maximum"

      threshold = var.asg_alarm_config.pending_instances

      comparison_operator = "GreaterThanThreshold"

      description = "Too many pending instances"

    }

  }

  # rds 

  rds_alarms = {

    cpu = {

      metric_name = "CPUUtilization"

      statistic = "Average"

      comparison_operator = "GreaterThanThreshold"

      threshold = var.rds_alarm_config.cpu_utilization

      description = "RDS CPU Utilization is high"

    }

    connections = {

      metric_name = "DatabaseConnections"

      statistic = "Average"

      comparison_operator = "GreaterThanThreshold"

      threshold = var.rds_alarm_config.database_connections

      description = "Database connections are high"

    }

    storage = {

      metric_name = "FreeStorageSpace"

      statistic = "Average"

      comparison_operator = "LessThanThreshold"

      threshold = var.rds_alarm_config.free_storage_space

      description = "Low database storage"

    }

    memory = {

      metric_name = "FreeableMemory"

      statistic = "Average"

      comparison_operator = "LessThanThreshold"

      threshold = var.rds_alarm_config.freeable_memory

      description = "Low database memory"

    }

  }

  
}

# dashboard 

locals {

  dashboard_name = coalesce(
    var.dashboard_name,
    "${var.project_name}"
  )

  widget_defaults = {
    region = data.aws_region.current.name
    period = 300
    view   = "timeSeries"
  }

}