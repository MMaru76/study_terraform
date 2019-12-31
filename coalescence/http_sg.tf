module "tabiya01_http_sg" {
  source      = "./security_group"
  name        = "tabiya-http-sg"
  vpc_id      = aws_vpc.tabiya00_vpc.id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "tabiya02_https_sg" {
  source      = "./security_group"
  name        = "tabiya-https_sg"
  vpc_id      = aws_vpc.tabiya00_vpc.id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "tabiya03_http_redirect_sg" {
  source      = "./security_group"
  name        = "tabiya-http_redirect_sg"
  vpc_id      = aws_vpc.tabiya00_vpc.id
  port        = 8080
  cidr_blocks = ["0.0.0.0/0"]
}