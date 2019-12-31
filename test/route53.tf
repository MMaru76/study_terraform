data "aws_route53_zone" "tabiya_host" {
  name = "tabiya.dev"
}

# resource "aws_route53_zone" "tabiya_host" {
#   name = "alb.tabiya.dev"
# }

resource "aws_route53_record" "tabiya_host_record" {
  zone_id = data.aws_route53_zone.tabiya_host.zone_id
  # name    = data.aws_route53_zone.tabiya_host.name
  name    = "alb.tabiya.dev"
  type    = "A"

  alias {
    name                   = aws_lb.tabiya_host.dns_name
    zone_id                = aws_lb.tabiya_host.zone_id
    evaluate_target_health = true
  }
}

output "domain_name" {
  value = aws_route53_record.tabiya_host.name
}

# resource "aws_acm_certificate" "tabiya_host" {
#   domain_name               = aws_route53_record.tabiya_host.name
#   subject_alternative_names = []
#   validation_method         = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_route53_record" "tabiya_host_certificate" {
#   name    = aws_acm_certificate.tabiya_host.domain_validation_options[0].resource_record_name
#   type    = aws_acm_certificate.tabiya_host.domain_validation_options[0].resource_record_type
#   records = [aws_acm_certificate.tabiya_host.domain_validation_options[0].resource_record_value]
#   zone_id = data.aws_route53_zone.tabiya_host.id
#   ttl     = 60
# }

# resource "aws_acm_certificate_validation" "tabiya_host" {
#   certificate_arn         = aws_acm_certificate.tabiya_host.arn
#   validation_record_fqdns = [aws_route53_record.tabiya_host_certificate.fqdn]
# }

provider "aws" {
  # 東京を指定
  region = "ap-northeast-1"
}


resource "aws_acm_certificate" "tabiya_acm" {
  domain_name               = aws_route53_record.example.name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
