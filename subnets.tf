#CREACION DE LAS SUBNETS TANTO LAS PUBLICAS COMO LAS INTERNAS#


resource "aws_subnet" "subnet_public1" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = "172.16.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "subnet_public1"
  }
}

resource "aws_subnet" "subnet_public2" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = "172.16.20.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "subnet_public2"
  }
}

resource "aws_subnet" "subnet_internal1" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = "172.16.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.region_az1a

  tags = {
    Name = "subnet_internal1"
  }
}

resource "aws_subnet" "subnet_internal2" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = "172.16.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.region_az1b

  tags = {
    Name = "subnet_internal2"
  }
}








