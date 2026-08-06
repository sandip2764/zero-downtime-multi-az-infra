output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}

output "sns_topic_name" {
  value = aws_sns_topic.alerts.name
}

# alb

output "alb_alarm_names" {

  value = {

    for k, v in aws_cloudwatch_metric_alarm.alb :

    k => v.alarm_name

  }

}

# asg

output "asg_alarm_names" {
  value = {
    for k, v in aws_cloudwatch_metric_alarm.asg :
    k => v.alarm_name
  }
}

# rds

output "rds_alarm_names" {

  value = {

    for k, v in aws_cloudwatch_metric_alarm.rds :

    k => v.alarm_name

  }

}

# dashboard

output "dashboard_name" {

  value = aws_cloudwatch_dashboard.this.dashboard_name

}

