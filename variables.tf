# Variable pour spécifier la clé d'accès AWS
variable "access_key" {
  description = "Access key to AWS console"
}
# Variable pour spécifier la clé secrte AWS
variable "secret_key" {
  description = "Secret key to AWS console"
}

# Variable pour spécifier le type d'instance EC2.
variable "instance_type" {
  default = "t2.micro"
}

# Variable pour spécifier le type EC2 à lancer.
variable "ami_id" {
  description = "The AMI to use"
  default     = "ami-09d56f8956ab235b3"
}

# Variable pour spécifier le bloc CIDR pour le VPC.
variable "vpc-cidr" {
  default = "10.10.0.0/16"
}
