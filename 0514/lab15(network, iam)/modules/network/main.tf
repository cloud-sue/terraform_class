resource "aws_vpc" "this" {
  cidr_block           = local.vpc.cidr_block
  enable_dns_hostnames = local.vpc.enable_dns_hostnames
  enable_dns_support   = local.vpc.enable_dns_support

  tags = {
    # root module(local) -> root module(main) -> vpc(variable) -> vpc(main)
    Name = "${var.namespace}-vpc-${local.vpc.name}"
  }
}

resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id
  cidr_block = local.subnet.cidr_block
  availability_zone = local.subnet.availability_zone
  map_public_ip_on_launch = local.subnet.map_public_ip_on_launch #public(true), private(false)

  tags = {
    Name = "${var.namespace}-subnet-${local.subnet.name}"
  }

}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.namespace}-igw"
  }  
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.namespace}-rtb-${local.subnet.name}"
  }
}

resource "aws_route_table_association" "this" {
  subnet_id = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}