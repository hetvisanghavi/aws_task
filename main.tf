provider "aws" {
  region =var.region
}
module "ec2" {
  source = "./ec2"
  amis = var.amis
  az = var.az
  ec2_count = var.ec2_count
  eip_name = var.eip_name
  eni_name = var.eni_name
  instance_name = var.instance_name
  instance_type = var.instance_type
  region = var.region
  subnet_id = module.vpc.subnet_id
}

module "elb" {
  source = "./elb"
  az = var.az
  elb_name = var.elb_name
}

module "route53" {
  source = "./route53"
  aws_route53_name = var.aws_route53_name
  eip = module.ec2.eip
  env = var.env
  instance = var.instance
  region = var.region

}
module "vpc" {
  source = "./vpc"
  az = var.az
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
  subnet_count = var.subnet_count
  vpc_cidr = var.vpc_cidr
  subnet_name = var.subnet_name
  subnet_count_public = var.subnet_count_public
}