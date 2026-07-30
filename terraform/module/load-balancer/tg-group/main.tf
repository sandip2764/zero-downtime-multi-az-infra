resource "aws_lb_target_group" "this" {
  name     = "${var.project_name}-tg"
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path     = var.health_check_path
    timeout  = var.health_check_timeout
    interval = var.health_check_interval
  }

  tags = var.tags
}
