# Create  Security Group for the Application Load Balancer
# terraform aws create security group

resource "aws_security_group" "ALB-aws_security_group" {
  name        = "Application Load Balancer security group"
  description = "Allow HTTP/HTTPS inbound traffic on the port 80/443"
  vpc_id      = aws_vpc.main-test.id

  ingress {
    description      = "HTTP Access on port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }


    ingress {
    description      = "HTTPS Access on port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB security group"
  }
}



# Create  Security Group for the Bastion Host or Jum box
# terraform aws create security group

resource "aws_security_group" "SSH_security_group" {
  name        = "SSH access"
  description = "Allow SSH inbound traffic on the port 22"
  vpc_id      = aws_vpc.main-test.id

  ingress {
    description      = "SSH Access on port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${var.SSH-location}"]
  
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH security group"
  }
}



# Create  Security Group for the Webservser 
# terraform aws create security group

resource "aws_security_group" "Websever_security_group" {
  name        = "Websever security group"
  description = "Allow  inbound traffic from ALB on the port 80/443"
  vpc_id      = aws_vpc.main-test.id

  ingress {
    description      = "HTTP Access on port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [ "${aws_security_group.ALB-aws_security_group.id}" ]
  
  }


  ingress {
    description      = "HTTPS Access on port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
   security_groups = [ "${aws_security_group.ALB-aws_security_group.id}" ]
  
  }

  ingress {
    description      = "SSH Access on port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
   security_groups = [ "${aws_security_group.ALB-aws_security_group.id}" ]
  
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Webserver security group"
  }
}
 

# Create  Security Group for the Database
# terraform aws create security group

resource "aws_security_group" "database_security_group" {
  name        = "database security group"
  description = "Allow MYSQL/Aurora inbound traffic on the port 3306"
  vpc_id      = aws_vpc.main-test.id

  ingress {
    description      = "MYSQL/Aurora Access on port 3306"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [ "${aws_security_group.Websever_security_group.id}" ]
  
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database security group"
  }
}

 



