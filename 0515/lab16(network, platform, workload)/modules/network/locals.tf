locals {
  namespace = var.namespace
  region    = var.region

  vpc = {
    name                 = "main"
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true

  }

  public_subnet = [
    {
      name                    = "pub-1"
      cidr_block              = "10.0.1.0/24"
      availability_zone       = "${local.region}a"
      map_public_ip_on_launch = true
    },
    {
      name                    = "pub-2"
      cidr_block              = "10.0.2.0/24"
      availability_zone       = "${local.region}b"
      map_public_ip_on_launch = true
    }
  ]

  
}
