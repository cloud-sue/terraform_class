resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name = "${local.namespace}-eip-${local.natgw.name}"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = aws_subnet.pub1.id

  tags = {
    Name = "${local.namespace}-natgw-${local.natgw.name}"
  }
}