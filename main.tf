terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "buckets3tamko"
    key    = "tfstate/buckets3tamko.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}

//Create vpc

resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc-cidr
}
// Create security group

resource "aws_security_group" "demo-vpc-sg" {
  name   = "demo-vpc-sg"
  vpc_id = aws_vpc.demo_vpc.id

  ingress {

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

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



resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "ec2-01"
  }
} 