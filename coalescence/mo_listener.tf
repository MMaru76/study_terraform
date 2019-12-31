
resource "aws_lb_listener" "tabiya00-http" {
  load_balancer_arn = aws_lb.tabiya00_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTP』です"
      status_code  = "200"
    }
  }
}


resource "aws_lb_listener" "tabiya00-https" {
  load_balancer_arn = aws_lb.tabiya00_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.tabiya_acm.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTPS』です"
      status_code  = "200"
    }
  }
}

# resource "aws_lb_listener" "redirect_http_to_https" {
#   load_balancer_arn = aws_lb.example.arn
#   port              = "8080"
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }
