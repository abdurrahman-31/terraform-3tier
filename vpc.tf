provider "aws" {
  region = "ap-south-1"

}

resource "aws_vpc" "ashiq_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ashiq_vpc"
  }
}

resource "aws_subnet" "ashiq_public_subnet" {
  vpc_id     = aws_vpc.ashiq_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "ashiq_public_subnet"
  }
}

resource "aws_subnet" "ashiq_private_subnet" {
  vpc_id     = aws_vpc.ashiq_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "ashiq_private_subnet"
  }
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "ashiq_ig" {
  vpc_id = aws_vpc.ashiq_vpc.id

  tags = {
    Name = "ashiq_ig"
  }
}

resource "aws_route_table" "ashiq_rt" {
  vpc_id = aws_vpc.ashiq_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ashiq_ig.id
  }

  tags = {
    Name = "ashiq_rt"
  }
}

resource "aws_route_table_association" "ashiq_rta" {
  subnet_id      = aws_subnet.ashiq_public_subnet.id
  route_table_id = aws_route_table.ashiq_rt.id
}
