resource "aws_instance" "example" {
  ami           = "ami-068a6cefc24c301d2"
  instance_type = "t2.micro"

  tags = {
    Name = "oreo"
  }

    user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}

provider "aws" {
    region = "ap-northeast-1"
}