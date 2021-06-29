#DEFINICION DEL VPC#

resource "aws_vpc" "vpc_obligatorio" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"

  tags = {
    Name = "vpc_obligatorio"
  }
}

#DEFINICION DE INTERNET GATEWAY PARA EL VPC#

resource "aws_internet_gateway" "ig_obligatorio" {
  vpc_id = aws_vpc.vpc_obligatorio.id
  tags = {
    Name = "ig_obligatorio"
  }
}

#ROUTE TABLE Y ASOCIATION CON LAS SUBNETS#

resource "aws_route_table" "rt_obligatorio" {
  vpc_id = aws_vpc.vpc_obligatorio.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_obligatorio.id
  } 
    tags = {
  Name = "rt_obligatorio"

  }
}  


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_public1.id
  route_table_id = aws_route_table.rt_obligatorio.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_public2.id
  route_table_id = aws_route_table.rt_obligatorio.id
}