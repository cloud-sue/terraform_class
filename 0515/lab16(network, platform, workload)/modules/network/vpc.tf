resource "aws_vpc" "this" {
  cidr_block           = local.vpc.cidr_block
  enable_dns_hostnames = local.vpc.enable_dns_hostnames
  enable_dns_support   = local.vpc.enable_dns_support

  tags = {
    Name = "${var.namespace}-vpc-${local.vpc.name}"
  }
}


resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.namespace}-igw"
  }
}