resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_classiclink = false
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = false
}

resource "aws_subnet" "private_subnet" {
  count = var.subnet_count
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  cidr_block = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.az, count.index)
  tags = {
    Name = "${var.subnet_name}-${count.index}-private"
  }
}
resource "aws_subnet" "public_subnet" {
  count = var.subnet_count_public
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block = var.public_subnet_cidr
  availability_zone = "us-west-1a"
  tags = {
    Name = "${var.subnet_name}-${count.index}-public"
  }
}
resource "aws_internet_gateway" "net_gateway" {
  vpc_id = aws_vpc.vpc.id
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.net_gateway.id
  }
}
resource "aws_route_table_association" "public_route_table_association" {
  count = var.subnet_count_public
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet[count.index].id
}