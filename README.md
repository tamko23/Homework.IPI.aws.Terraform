# TP Terraform AWS

Déploiement d'infrastructures AWS avec Terraform.

## Table des matières

- [Prérequis](#Prérequis)
- [Configuration](#configuration)
- [Déploiement](#Déploiement)
- [Conclusion](#Conclusion)

### Prérequis

Pour suivre ce TP, vous aurez besoin d'installer 
- [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installé .
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)  installé .
- Un [Compte AWS](https://aws.amazon.com/fr/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all) et les identifiants associés cela vous permet de créer des ressources.
- Création du S3 bucket sur aws.

  
## Création du répertoire  

Dans cette section nous allons créer un répertoire pour mettre nos futur fichier

    MKDIR Nomdufichier

Ensuite

    cd Nomdufichier/


## Configuration
### Création des fichiers

Dans cette section nous allons créer les fichiers de configuration

- main.tf
- variables.tf
- terraform.tfvars

### Configuration du fichier main.tf

    touch main.tf

ensuite écrire le code ci dessous

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

    resource "aws_vpc" "demo_vpc" {
             cidr_block = var.vpc-cidr
    }

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
      
### Configuration du fichier variables.tf
    touch variables.tf
ensuite écrire le code ci dessous

    variable "access_key" {
          description = "Access key to AWS console"
    }

    variable "secret_key" {
          description = "Secret key to AWS console"
    }

    variable "instance_name" {
          description = "Name of the instance to be created"
          default     = "awsbuilder-demo"
    }

    variable "instance_type" {
          default = "t2.micro"
    }

    variable "ami_id" {
          description = "The AMI to use"
          default     = "ami-09d56f8956ab235b3"
    }

    variable "vpc-cidr" {
           default = "10.10.0.0/16"
    }


### Configuration du fichier terraform.tfvars
    touch terraform.tfvars
ensuite écrire le code ci dessous
###
    access_key = "Access Key of IAM User"
    secret_key = "Secret Key of IAM User"


## Déploiement

### Initialiser le répertoire
    terraform init
Cette commande permet d'initialisé les fichiers.
### Formater et valider la configuration
    terraform fmt
Cette commande permet de mettre en forme le code dans les différents fichiers.
###
    terraform validate
Cette commande permet de valider le code des différents fichiers.
###
    terraform plan
Cette commande permet de voir toutes les ressources que vous avez créées.
### Créer une infrastructure

    terraform apply
Cette commande permet de crée l'infrastructure
## Conclusion
 Votre infrastructure est crée . 
### Détruire l'infrastructure
     terraform destroy
Cette commande permet de supprimer toutes les ressources que vous avez créées.
### Auteur 

- Tamba KOMANO - Tamko23
