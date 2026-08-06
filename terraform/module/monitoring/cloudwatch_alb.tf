resource "aws_cloudwatch_metric_alarm" "alb" {

  for_each = local.alb_alarms

  alarm_name = "${var.project_name}-${each.key}"

  namespace = "AWS/ApplicationELB"

  metric_name = each.value.metric_name

  statistic = each.value.statistic

  comparison_operator = each.value.comparison_operator

  threshold = each.value.threshold

  evaluation_periods = local.alarm_defaults.evaluation_periods

  period = local.alarm_defaults.period

  alarm_description = each.value.description

  actions_enabled = local.alarm_defaults.actions_enabled

  dimensions = merge(

    {
      LoadBalancer = var.alb_arn_suffix
    },

    each.value.target_group ? {

      TargetGroup = var.target_group_arn_suffix

    } : {}

  )

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = {
    Name = "${var.project_name}-${each.key}"
  }

}