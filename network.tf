resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.packer.id

  tags = {
    Name = "Packer VPC IG"
  }
}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.packer.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "2nd Route Table"
  }
}

resource "aws_route_table_association" "gateway_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.second_rt.id
}

resource "aws_security_group" "packer-allowed" {
  vpc_id = aws_vpc.packer.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  // ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // winrm
  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "packer-allowed"
  }
}
