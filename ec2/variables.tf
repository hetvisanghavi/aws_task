variable "ec2_count" {}
variable "amis" {
  type = "map"
}
variable "instance_type" {}
variable "subnet_id" {
  type = "list"
}
variable "az" {
  type = "list"
}
variable "instance_name" {}
variable "eni_name" {}
variable "region" {}
variable "eip_name" {}