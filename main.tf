
provider "aws" {
  region = "ap-south-1"  
}

#Create security group
resource "aws_security_group" "docker_sg" {
  name        = "docker_sg"
  description = "Open ports 22, 80, and 443"

 
  ingress {
    description = "Incoming SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
  ingress {
    description = "Incoming 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
  ingress {
    description = "Incoming 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "docker_sg"
  }
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_instance" "docker-instance" {
  ami           = "ami-0f5ee92e2d63afc18"  
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.docker_sg.id]
  
}
