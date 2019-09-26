module "web_server" {
  source        = "./http_server"
  instance_type = "t2.micro"
}

output "public_dns_web" {
  value = module.web_server.public_dns_oreo
}