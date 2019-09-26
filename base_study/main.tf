module "web_server_module" {
  source        = "./http_server"
  instance_type = "t2.micro"
}

output "public_dns_web_output" {
  # ./http_server/main.tf:40行目の出力を変数として取得して出力
  value = module.web_server_module.public_dns_output
}