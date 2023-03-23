provider "aws" {
    region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "web" {
  ami                    = "ami-005f9685cb30f234b"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tfkey.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("script.sh")

  tags = {
    Name = "jenkins-instance"
  }
}
resource "aws_default_vpc" "defaultvpc" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_key_pair" "tfkey" {
  key_name   = "tfkey"
  public_key = tls_private_key.rsakey.public_key_openssh
}

resource "tls_private_key" "rsakey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_default_vpc.defaultvpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
