resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    # root module(local) -> root module(main) -> vpc(variable) -> vpc(main)
    Name = "${var.namespace}-vpc-${var.name}"
  }
}