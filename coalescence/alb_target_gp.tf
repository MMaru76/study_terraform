resource "aws_lb_target_group" "tabiya_tg" {
  name                 = "tabiyatg00"
  target_type          = "ip"
  vpc_id               = aws_vpc.tabiya00_vpc.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 10
    unhealthy_threshold = 4
    timeout             = 10
    interval            = 60
    matcher             = 400
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.tabiya00_lb]
}


resource "aws_lb_listener_rule" "tabiya_tg_rule" {
  listener_arn = aws_lb_listener.tabiya00-https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tabiya_tg.arn
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}
