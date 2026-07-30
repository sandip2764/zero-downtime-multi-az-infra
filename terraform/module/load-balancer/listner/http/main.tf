resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn

  port = var.port

  protocol = var.protocol

  default_action {
    type = "redirect"

    redirect {
      port = var.redirect_port

      protocol = var.redirect_protocol
      
      status_code = var.redirect_status_code
    }
  }
}