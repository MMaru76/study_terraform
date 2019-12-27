# ../main.tf を見てる
/////////////////////////////////////////////////////////
variable "instance_type" {}
/////////////////////////////////////////////////////////

# インスタンスに関する情報を指定する所
/////////////////////////////////////////////////////////
resource "aws_instance" "default" {
  # 外部定義で指定か､AMIを事前指定
  ami                     = "ami-0c3fd0f5d33134a76"
  # ami                     = data.aws_ami.tabiya10_recent_amazon_linux_2.image_id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.default.id]
  user_data               = file("./source/user_data.sh")

  # タグ指定
  tags = {
    Server = "tabiya-tag"
    Name = "test-sample"
  }
}
/////////////////////////////////////////////////////////


# セキュリティグループの設定
/////////////////////////////////////////////////////////
resource "aws_security_group" "default" {

  name = "tabiya-ec2-tag"

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
/////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////
output "public_dns" {
  value = aws_instance.default.public_dns
}
/////////////////////////////////////////////////////////

# # 外部定義 インスタンスタイプ指定
# variable "tabiya01_instance_type" {
#   default = "t2.micro"
# }

# 最新のEC2を取ってくる
/////////////////////////////////////////////////////////
# data "aws_ami" "tabiya10_recent_amazon_linux_2" {

#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name    = "name"
#     values  = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
#   }

#   filter {
#     name    = "state"
#     values  = ["available"]
#   }
# }
/////////////////////////////////////////////////////////
