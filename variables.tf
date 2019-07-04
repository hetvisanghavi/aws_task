
#AWS_INSTANCE variable

variable "ec2_count" {}
variable "amis" {
  type = "map"
}
variable "instance_type" {}
variable "az" {
  type = "list"
}
variable "instance_name" {}
variable "eni_name" {}
variable "region" {}
variable "eip_name" {}

#ELB variable

variable "elb_name" {}

#ROUTE53 variable

variable "aws_route53_name" {}
variable "instance" {}
variable "env" {}

#VPC variable

variable "vpc_cidr" {}
variable "private_subnet_cidr" {
  type = "list"
}
variable "subnet_count" {}
variable "subnet_name" {}
variable "public_subnet_cidr" {}
variable "subnet_count_public" {}
