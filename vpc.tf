#terraform aws create vpc

resource "aws_vpc" "main-test" {
  cidr_block           = "${var.vpc-cidr}"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Demo_vpc"
  }
}
# terraform aws create internet gateway 

resource "aws_internet_gateway" "IWG" {
  vpc_id = aws_vpc.main-test.id

  tags = {
    Name = "Demo_IGW"
  }
}


# create public subnet 1a

resource "aws_subnet" "public-subnet-1a" {
  vpc_id     = aws_vpc.main-test.id
  cidr_block = "${var.public-subnet-1a-cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet 1a"
  }
}


# create public subnet 1b

resource "aws_subnet" "public-subnet-1b" {
  vpc_id     = aws_vpc.main-test.id
  cidr_block = "${var.public-subnet-1b-cidr}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet 1b"
  }
}

# terraform aws create route table and add public route

resource "aws_route_table" "RTB" {
  vpc_id = aws_vpc.main-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IWG.id
  }


  tags = {
    Name = "Pub_RT"
  }
}

# terraform aws associate subnet with route table

resource "aws_route_table_association" "public-subnet-1a" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.RTB.id
}

resource "aws_route_table_association" "public-subnet-1b" {
  subnet_id      = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.RTB.id
}


# create private subnet 1a

resource "aws_subnet" "private-subnet-1a" {
  vpc_id     = aws_vpc.main-test.id
  cidr_block = "${var.private-subnet-1a-cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "App subnet 1a"
  }
}

# create private subnet 1b

resource "aws_subnet" "private-subnet-1b" {
  vpc_id     = aws_vpc.main-test.id
  cidr_block = "${var.private-subnet-1b-cidr}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "App subnet 1b"
  }
}


# create database subnet 1a

resource "aws_subnet" "database-subnet-1a" {
  vpc_id     = aws_vpc.main-test.id
  cidr_block = "${var.database-subnet-1a-cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "database subnet 1a"
  }
}

# create database subnet 1b

resource "aws_subnet" "database-subnet-1b" {
  vpc_id     = aws_vpc.main-test.id
  cidr_block =  "${var.database-subnet-1b-cidr}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "database subnet 1b"
  }
}


