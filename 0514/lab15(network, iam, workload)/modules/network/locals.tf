locals {
  namespace = var.namespace
  region    = var.region

  vpc = {
    cidr_block           = "10.0.0.0/16"
    name                 = "main"
    enable_dns_hostnames = true
    enable_dns_support   = true

  }

  subnet = {
    cidr_block              = "10.0.1.0/24"
    name                    = "pub1"
    availability_zone       = "${local.region}a"
    map_public_ip_on_launch = true
  }
}
