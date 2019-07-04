output "az" {
  value = aws_subnet.private_subnet.*.availability_zone
}

output "subnet_id" {
  value = aws_subnet.private_subnet.*.id
}