resource "aws_vpc" "packer" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Packer VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.packer.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Packer Subnet"
  }
}
