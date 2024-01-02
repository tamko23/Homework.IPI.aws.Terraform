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