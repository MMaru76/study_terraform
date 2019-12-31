resource "aws_lb" "tabiya00_lb" {
  name                       = "tabiya01-lb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  # enable_deletion_protection = true

  subnets = [
    aws_subnet.tabiya01_vpc_public.id,
    aws_subnet.tabiya01_1_vpc_public.id,
  ]

  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    prefix  = "test-lb"
    enabled = true
  }

  security_groups = [
    module.tabiya01_http_sg.security_group_id,
    module.tabiya02_https_sg.security_group_id,
    module.tabiya03_http_redirect_sg.security_group_id,
  ]
}

output "alb_dns_name" {
  value = aws_lb.tabiya00_lb.dns_name
}


//=======================================================
//==  リージョン指定
//=======================================================
# provider "aws" {
#   # 東京を指定
#   region = "ap-northeast-1"
# }