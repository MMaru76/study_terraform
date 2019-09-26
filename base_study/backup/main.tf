# 最新 Amazon Linux 2 AMI の取得設定

data "aws_ami" "recent_amazon_linux_oreo" {
  ## 不明
  most_recent = true
  owners      = ["amazon"]

  ## 不明
  filter {
    name      = "name"
    values    = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  ## 不明
  filter {
    name      = "state"
    values    = ["available"]
  }
}

# =================================================================

# プロバイダの設定(リージョン)

provider "aws" {
    region = "ap-northeast-1"
}

# =================================================================

# インスタンスタイプの設定

## 変数

# variable "oreo_example_instance_type" {
#   default = "t2.micro"
# }

## ローカル変数

locals {
  local_example_instance_type = "t2.micro"
}

# =================================================================

# セキュリティグループ設定

resource "aws_security_group" "example_ec2_sg" {
  name = "oreo_example_ec2_sg"

  ## インバウンド
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ## アウトバウンド
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# =================================================================

# config

resource "aws_instance" "ec2_instance_example" {
  # ami           = "ami-0ff21806645c5e492"
  ### 変数にて最新のAmazonLinux2を取得
  ami                     = data.aws_ami.recent_amazon_linux_oreo.image_id
  # instance_type = var.local_example_instance_type
  ### 変数にてインスタンスタイプを取得
  instance_type           = local.local_example_instance_type
  ### 変数にてセキュリティグループを取得
  vpc_security_group_ids  = [aws_security_group.example_ec2_sg.id]
  user_data               = file("./user_data.sh")

  tags = {
    Name = "ExampleTags"
  }

  ## 直書きコマンド実行方法
  # user_data = <<EOF
  #   #!/bin/bash
  #   yum -y install -y httpd
  #   systemctl start httpd.service
  # EOF
}

output "instance_example_name_output_id" {
  value = aws_instance.ec2_instance_example.id
}

output "instance_example_public_dns_name_output" {
  value = aws_instance.ec2_instance_example.public_dns
}