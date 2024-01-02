# Configuration principale de Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
# Configuration du backend pour stocker l'état Terraform dans un compartiment S3
  backend "s3" {
    bucket = "buckets3tamko"
    key    = "tfstate/buckets3tamko.tfstate"
    region = "us-east-1"
  }
}

# Fournisseur AWS avec la région et les clés d'accès
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}

# Ressource AWS VPC (Virtual Private Cloud)

resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc-cidr
}

# Ressource AWS Security Group pour le VPC

resource "aws_security_group" "demo-vpc-sg" {
  name   = "demo-vpc-sg"
  vpc_id = aws_vpc.demo_vpc.id

# Règles d'entrée (ingress) permettant le trafic SSH (port 22) depuis n'importe quelle adresse
  ingress {

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }
# Règles de sortie (egress) permettant tout le trafic sortant vers n'importe quelle adresse
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 # Balises (tags) pour le groupe de sécurité (utile pour l'organisation et l'identification)
  tags = {
    Name = "allow_tls"
  }
}

# Ressource AWS Instance (EC2)
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
 # Balises (tags) pour l'instance (utile pour l'organisation et l'identification)
  tags = {
    Name = "ec2-01"
  }
} 
