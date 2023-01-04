# Alloacate Elatstic Ip address (EIP1)
 # terraform aws allocate elastic ip

 resource "aws_eip" "EIP1-for-nat-gateway1" {
  vpc      = true

  tags = {
    Name = "EIP1"
  }
} 



# Alloacate Elatstic Ip address (EIP2)
 # terraform aws allocate elastic ip

 resource "aws_eip" "EIP1-for-nat-gateway2" {
  vpc      = true

  tags = {
    Name = "EIP2"
  }
} 



 # create nategway 1 in public subnet 1
 # terraform aws create nat gateway

 resource "aws_nat_gateway" "nategway-1a" {
  allocation_id = aws_eip.EIP1-for-nat-gateway1.id
  subnet_id     = aws_subnet.public-subnet-1a.id

  tags = {
    Name = "nategw public subnet 1"
  }

}


 # create nategway 2 in public subnet 2
 # terraform aws create nat gateway

 resource "aws_nat_gateway" "nategway-2" {
  allocation_id = aws_eip.EIP1-for-nat-gateway2.id
  subnet_id     = aws_subnet.public-subnet-1b.id

  tags = {
    Name = "nategw public subnet 2"
  }

}

 # Create  Private Route table 1 And Route Via Gateway 1
 # terraform aws create route table

resource "aws_route_table" "private-Route-1" {
  vpc_id = aws_vpc.main-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nategway-1a.id
  }


  tags = {
    Name = "Private RT1"
  }
}

 # Associate Private subnet1 with "Private Route 1"
  # terraform aws associate subnet with route table

resource "aws_route_table_association" "Route-subnet-App-1" {
  subnet_id      = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.private-Route-1.id

}

 # Associate Private subnet1 with "Private Route 1"
  # terraform aws associate subnet with route table

resource "aws_route_table_association" "Route-database-1" {
  subnet_id      = aws_subnet.database-subnet-1a.id
  route_table_id = aws_route_table.private-Route-1.id
}


 # Create  Private Route table 2 And Route Via Gateway 2
 # terraform aws create route table

resource "aws_route_table" "private-Route-2" {
  vpc_id = aws_vpc.main-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nategway-2.id
  }


  tags = {
    Name = "Private RT2"
  }
}


 # Associate Private subnet1 with "Private Route 1"
  # terraform aws associate subnet with route table

resource "aws_route_table_association" "Route-subnet-App-2" {
  subnet_id      = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.private-Route-2.id

}

 # Associate Private subnet1 with "Private Route 1"
  # terraform aws associate subnet with route table

resource "aws_route_table_association" "Route-database-2" {
  subnet_id      = aws_subnet.database-subnet-1b.id
  route_table_id = aws_route_table.private-Route-2.id
}




