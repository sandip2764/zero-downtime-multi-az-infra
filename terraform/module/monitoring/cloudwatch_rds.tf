resource "aws_cloudwatch_metric_alarm" "rds" {

  for_each = local.rds_alarms

  alarm_name = "${var.project_name}-rds-${each.key}"

  namespace = "AWS/RDS"

  metric_name = each.value.metric_name

  statistic = each.value.statistic

  comparison_operator = each.value.comparison_operator

  threshold = each.value.threshold

  evaluation_periods = local.alarm_defaults.evaluation_periods

  period = local.alarm_defaults.period

  alarm_description = each.value.description

  dimensions = {

    DBInstanceIdentifier = var.db_instance_identifier

  }

  alarm_actions = [

    aws_sns_topic.alerts.arn

  ]

  ok_actions = [

    aws_sns_topic.alerts.arn

  ]

  tags = {
    Name = "${var.project_name}-rds-${each.key}"
  }

}