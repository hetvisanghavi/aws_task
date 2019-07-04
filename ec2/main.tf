resource "aws_instance" "ec2" {
  count = var.ec2_count
  ami = lookup(var.amis,var.region)
  instance_type = var.instance_type
  subnet_id = element(var.subnet_id, count.index)
  availability_zone = element(var.az, count.index)

  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}
resource "aws_network_interface" "eni" {
  count = var.ec2_count
  subnet_id = element(var.subnet_id, count.index)
  tags = {
    Name = "${var.eni_name}-${count.index}"
  }
}
resource "aws_network_interface_attachment" "eni_attachment" {
  count = var.ec2_count
  device_index = 1
  instance_id = aws_instance.ec2[count.index].id
  network_interface_id = aws_network_interface.eni[count.index].id
}
resource "aws_eip" "eip" {
  count = var.ec2_count
  vpc = true
  network_interface = aws_network_interface.eni[count.index].id
  tags = {
    name = "${var.eip_name}-${count.index}"
  }
}