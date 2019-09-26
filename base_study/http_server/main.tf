variable "instance_type" {}

provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_instance" "ec2_instance_resource" {
  ami                     = "ami-0ff21806645c5e492"
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.default_resource.id]
  # user_data               = file("../user_data.sh")

  user_data = <<EOF
    #!/bin/bash
    yum -y install -y httpd
    systemctl start httpd.service
  EOF

  tags = {
    Name = "Tag_web_name"
  }
}

resource "aws_security_group" "default_resource" {
  name = "ec2_sg_name"
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

output "public_dns_output" {
  value = aws_instance.ec2_instance_resource.public_dns
}