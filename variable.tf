variable "vpc-cidr" {
default =  "10.0.0.0/16"
description = "vpc cidr block"
type = string 
  
}

variable "public-subnet-1a-cidr" {
default =  "10.0.0.0/24"
description = "public-subnet 1a cidr block"
type = string 
  
}

variable "public-subnet-1b-cidr" {
default =  "10.0.1.0/24"
description = "public-subnet 1b cidr block"
type = string 
  
}

variable "private-subnet-1a-cidr" {
default =  "10.0.2.0/24"
description = "App-subnet 1a cidr block"
type = string 
  
}

variable "private-subnet-1b-cidr" {
default =  "10.0.3.0/24"
description = "App-subnet 1b cidr block"
type = string 
  
}

variable "database-subnet-1a-cidr" {
default =  "10.0.4.0/24"
description = "database-subnet 1a cidr block"
type = string 
  
}


variable "database-subnet-1b-cidr" {
default =  "10.0.5.0/24"
description = "database-subnet 1b cidr block"
type = string 
  
}


variable "SSH-location" {
default =  "0.0.0.0/0"
description = "Ip address that can SSH into the application "
type = string 
  
}

