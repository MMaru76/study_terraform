# tabiya00 = VPC 本体
# tabiya0x = パブリックサブネット 関連
# tabiya1x = プライベートサブネット 関連
# tabiya2x = NAT 関連
# tabiya3x = SG

//=======================================================
//== VPCの本体
//=======================================================
//-------------------------------------------------------
resource "aws_vpc" "tabiya00_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tabiya-vpc-tag"
  }
}
//-------------------------------------------------------


//=======================================================
//== Public Subnet 関連
//=======================================================

## PublicSubnet マルチAZ
//-------------------------------------------------------
resource "aws_subnet" "tabiya01_vpc_public" {
  vpc_id                  = aws_vpc.tabiya00_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya1-vpc-public"
  }
}

resource "aws_subnet" "tabiya01_1_vpc_public" {
  vpc_id                  = aws_vpc.tabiya00_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya2-vpc-public"
  }
}
//-------------------------------------------------------

## IGの設定
//-------------------------------------------------------
resource "aws_internet_gateway" "tabiya02_vpc_internet_gateway" {
  vpc_id = aws_vpc.tabiya00_vpc.id

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya3-vpc-public"
  }
}
//-------------------------------------------------------

## routeテーブルの設定(アタッチの事だと思っている)
//-------------------------------------------------------
resource "aws_route_table" "tabiya03_vpc_route_table" {
  vpc_id = aws_vpc.tabiya00_vpc.id

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya4-vpc-public"
  }
}
//-------------------------------------------------------

## IGとrouteテーブルの指定
//-------------------------------------------------------
resource "aws_route" "tabiya04_vpc_route" {
  route_table_id         = aws_route_table.tabiya03_vpc_route_table.id
  gateway_id             = aws_internet_gateway.tabiya02_vpc_internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
//-------------------------------------------------------

## publicサブネットをアタッチ
//-------------------------------------------------------
resource "aws_route_table_association" "tabiya05_vpc_association" {
  subnet_id      = aws_subnet.tabiya01_vpc_public.id
  route_table_id = aws_route_table.tabiya03_vpc_route_table.id
}

resource "aws_route_table_association" "tabiya05_1_vpc_association" {
  subnet_id      = aws_subnet.tabiya01_1_vpc_public.id
  route_table_id = aws_route_table.tabiya03_vpc_route_table.id
}
//-------------------------------------------------------



//=======================================================
//==  Private Subnet 関連
//=======================================================

## PrivateSubnet マルチAZ
//-------------------------------------------------------
resource "aws_subnet" "tabiya11_vpc_private" {
  vpc_id                  = aws_vpc.tabiya00_vpc.id
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya1-vpc-private"
  }
}

resource "aws_subnet" "tabiya11_1_vpc_private" {
  vpc_id                  = aws_vpc.tabiya00_vpc.id
  cidr_block              = "10.0.12.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya2-vpc-private"
  }
}
//-------------------------------------------------------

## routeテーブルの設定(アタッチの事だと思っている)
//-------------------------------------------------------
resource "aws_route_table" "tabiya12_route_table" {
  vpc_id = aws_vpc.tabiya00_vpc.id

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya3-vpc-private"
  }
}

resource "aws_route_table" "tabiya12_1_route_table" {
  vpc_id = aws_vpc.tabiya00_vpc.id

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya4-vpc-private"
  }
}
//-------------------------------------------------------

## privateサブネットをアタッチ
//-------------------------------------------------------
resource "aws_route_table_association" "tabiya13_vpc_association" {
  subnet_id      = aws_subnet.tabiya11_vpc_private.id
  route_table_id = aws_route_table.tabiya12_route_table.id
}

resource "aws_route_table_association" "tabiya13_1_vpc_association" {
  subnet_id      = aws_subnet.tabiya11_1_vpc_private.id
  route_table_id = aws_route_table.tabiya12_1_route_table.id
}
//-------------------------------------------------------



//=======================================================
//==  NAT関連
//=======================================================

## PrivateSubnet EIP 冗長化
//-------------------------------------------------------
resource "aws_eip" "tabiya21_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.tabiya02_vpc_internet_gateway]

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya1-vpc-eip"
  }
}

resource "aws_eip" "tabiya21_1_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.tabiya02_vpc_internet_gateway]

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya2-vpc-eip"
  }
}
//-------------------------------------------------------

## PrivateSubnet NAT 冗長化
//-------------------------------------------------------
resource "aws_nat_gateway" "tabiya22_nat_gateway" {
  allocation_id = aws_eip.tabiya21_eip.id
  subnet_id     = aws_subnet.tabiya01_vpc_public.id
  depends_on    = [aws_internet_gateway.tabiya02_vpc_internet_gateway]

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya3-vpc-nat"
  }
}

resource "aws_nat_gateway" "tabiya22_1_nat_gateway" {
  allocation_id = aws_eip.tabiya21_1_eip.id
  subnet_id     = aws_subnet.tabiya01_vpc_public.id
  depends_on    = [aws_internet_gateway.tabiya02_vpc_internet_gateway]

  tags = {
    VPC = "tabiya-vpc-tag"
    Name = "tabiya4-vpc-nat"
  }
}
//-------------------------------------------------------

## PrivateSubnet route の冗長化
//-------------------------------------------------------
resource "aws_route" "tabiya23_vpc_route" {
  route_table_id         = aws_route_table.tabiya12_route_table.id
  nat_gateway_id         = aws_nat_gateway.tabiya22_nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "tabiya23_1_vpc_route" {
  route_table_id         = aws_route_table.tabiya12_1_route_table.id
  nat_gateway_id         = aws_nat_gateway.tabiya22_1_nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
//-------------------------------------------------------



//=======================================================
//== Security Group
//=======================================================

## SG のモジュール化
//-------------------------------------------------------
module "tabiya30_sg" {
  source      = "./security_group"
  name        = "tabiya31-module-sg"
  vpc_id      = aws_vpc.tabiya00_vpc.id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}
//-------------------------------------------------------



//=======================================================
//==  リージョン指定
//=======================================================
provider "aws" {
  # 東京を指定
  region = "ap-northeast-1"
}



//=======================================================
# 物置
//=======================================================


//-------------------------------------------------------
//-------------------------------------------------------
