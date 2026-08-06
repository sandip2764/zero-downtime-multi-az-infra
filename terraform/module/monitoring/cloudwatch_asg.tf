resource "aws_cloudwatch_metric_alarm" "asg" {

  for_each = local.asg_alarms

  alarm_name = "${var.project_name}-asg-${each.key}"

  namespace = "AWS/AutoScaling"

  metric_name = each.value.metric_name

  statistic = each.value.statistic

  comparison_operator = each.value.comparison_operator

  threshold = each.value.threshold

  period = local.alarm_defaults.period

  evaluation_periods = local.alarm_defaults.evaluation_periods

  alarm_description = each.value.description

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = {
      Name = "${var.project_name}-asg-${each.key}"
    }
  
}