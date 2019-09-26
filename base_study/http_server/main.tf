variable "instance_type" {}

provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_instance" "maruya" {
  ami                     = "ami-0ff21806645c5e492"
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.oreodefault.id]
  # user_data               = file("../user_data.sh")

  user_data = <<EOF
    #!/bin/bash
    yum -y install -y httpd
    systemctl start httpd.service
  EOF

  tags = {
    Name = "ExampleTag_web"
  }
}

resource "aws_security_group" "oreodefault" {
  name = "ec2sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_dns_oreo" {
  value = aws_instance.maruya.public_dns
}