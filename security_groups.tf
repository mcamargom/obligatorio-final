#SECURITY GROUP CON PUBLIC FACING#

resource "aws_security_group" "sg-public-obligatorio" {
  name        = "sg_public_obl"
  description = "Permitir trafico ssh y http entrante a los WebServers"
  vpc_id      = aws_vpc.vpc_obligatorio.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  egress {
    description      = "All out"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "permitir_ssh_y_http_webservers"
  }


ingress {
  description = "HTTP from VPC"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}
egress {
  description      = "All out"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

}


#SECURITY GROUP INTERNO#

resource "aws_security_group" "sg-internal-obligatorio" {
  name        = "sg_internal"
  description = "Permitir trafico http desde WebServers"
  vpc_id      = aws_vpc.vpc_obligatorio.id

  ingress {
    description     = "HTTP from VPC"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks      = ["172.16.0.0/16"]
    ipv6_cidr_blocks = ["::/0"]

  }

  egress {
    description      = "All out"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "permitir_http"
  }



  ingress {
  description     = "DB Port from VPC"
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  cidr_blocks      = ["172.16.0.0/16"]
  ipv6_cidr_blocks = ["::/0"]
}


}
