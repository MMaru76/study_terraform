//-------------------------------------------------------
variable "name" {}
variable "vpc_id" {}
variable "port" {}
variable "cidr_blocks" {
  type = list(string)
}
//-------------------------------------------------------

//-------------------------------------------------------
resource "aws_security_group" "tabiya31_vpc_security_group" {
  name   = var.name
  vpc_id = var.vpc_id

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya1-vpc-sg"
  }
}
//-------------------------------------------------------

//-------------------------------------------------------
resource "aws_security_group_rule" "tabiya32_sg_rule_ingress" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.tabiya31_vpc_security_group.id
}
//-------------------------------------------------------

//-------------------------------------------------------
resource "aws_security_group_rule" "tabiya33_sg_rule_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tabiya31_vpc_security_group.id
}
//-------------------------------------------------------

//-------------------------------------------------------
output "security_group_id" {
  value = aws_security_group.tabiya31_vpc_security_group.id
}
//-------------------------------------------------------

# SGの作成
//-------------------------------------------------------
# resource "aws_security_group" "tabiya31_vpc_security_group" {
#   name   = "tabiya_vpc_sg"
#   vpc_id = aws_vpc.tabiya00_vpc.id

#   tags = {
#     VPC = "tabiya-vpc-tag"
#     Name = "tabiya1-vpc-sg"
#   }
# }
//-------------------------------------------------------

# ingress ルール決め
//-------------------------------------------------------
# resource "aws_security_group_rule" "tabiya31_sg_rule_ingress" {
#   type              = "ingress"
#   from_port         = "80"
#   to_port           = "80"
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.tabiya31_vpc_security_group.id
# }
//-------------------------------------------------------

# egress ルール決め
//-------------------------------------------------------
# resource "aws_security_group_rule" "tabiya32_sg_rule_egress" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.tabiya31_vpc_security_group.id
# }
//-------------------------------------------------------
