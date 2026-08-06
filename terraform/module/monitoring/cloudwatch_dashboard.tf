data "aws_region" "current" {}

resource "aws_cloudwatch_dashboard" "this" {

  dashboard_name = local.dashboard_name

  dashboard_body = jsonencode({

    widgets = [

      #
      # ALB RESPONSE TIME
      #

      {
        type   = "metric"
        width  = 12
        height = 6
        x      = 0
        y      = 0

        properties = merge(local.widget_defaults, {

          title = "ALB Response Time"

          stat = "Average"

          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "LoadBalancer",
              var.alb_arn_suffix,
              "TargetGroup",
              var.target_group_arn_suffix
            ]
          ]
        })
      },

      #
      # HEALTHY HOSTS
      #

      {
        type   = "metric"
        width  = 12
        height = 6
        x      = 12
        y      = 0

        properties = merge(local.widget_defaults, {

          title = "Healthy Hosts"

          stat = "Average"

          metrics = [
            [
              "AWS/ApplicationELB",
              "HealthyHostCount",
              "LoadBalancer",
              var.alb_arn_suffix,
              "TargetGroup",
              var.target_group_arn_suffix
            ]
          ]
        })
      },

      #
      # TARGET 5XX
      #

      {
        type   = "metric"
        width  = 12
        height = 6
        x      = 0
        y      = 6

        properties = merge(local.widget_defaults, {

          title = "Target 5XX"

          stat = "Sum"

          metrics = [
            [
              "AWS/ApplicationELB",
              "HTTPCode_Target_5XX_Count",
              "LoadBalancer",
              var.alb_arn_suffix,
              "TargetGroup",
              var.target_group_arn_suffix
            ]
          ]
        })
      },

      #
      # ASG
      #

      {
        type   = "metric"
        width  = 12
        height = 6
        x      = 12
        y      = 6

        properties = merge(local.widget_defaults, {

          title = "ASG In Service"

          stat = "Average"

          metrics = [
            [
              "AWS/AutoScaling",
              "GroupInServiceInstances",
              "AutoScalingGroupName",
              var.asg_name
            ]
          ]
        })
      },

      #
      # RDS CPU
      #

      {
        type   = "metric"
        width  = 12
        height = 6
        x      = 0
        y      = 12

        properties = merge(local.widget_defaults, {

          title = "RDS CPU"

          stat = "Average"

          metrics = [
            [
              "AWS/RDS",
              "CPUUtilization",
              "DBInstanceIdentifier",
              var.db_instance_identifier
            ]
          ]
        })
      },

      #
      # RDS CONNECTIONS
      #

      {
        type   = "metric"
        width  = 12
        height = 6
        x      = 12
        y      = 12

        properties = merge(local.widget_defaults, {

          title = "Database Connections"

          stat = "Average"

          metrics = [
            [
              "AWS/RDS",
              "DatabaseConnections",
              "DBInstanceIdentifier",
              var.db_instance_identifier
            ]
          ]
        })
      }

    ]

  })

}