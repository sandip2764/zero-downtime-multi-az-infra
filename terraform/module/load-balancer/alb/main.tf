resource "aws_lb" "this" {
  name               = "${var.project_name}-lb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type

  security_groups = var.security_group_ids
  subnets         = var.subnets

  tags = var.tags
}
