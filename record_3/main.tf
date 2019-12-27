module "web_server" {
  source        = "./httpd_server"
  instance_type = "t2.micro"
}

# インスタンスIDを出力
# output "instance_id" {
#   value = aws_instance.default.id
# }

output "public_dns" {
  value = module.web_server.public_dns
}


# 外部定義 リージョン指定
provider "aws" {
  region = "ap-northeast-1"
}