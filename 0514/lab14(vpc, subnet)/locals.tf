locals {
  org       = "tf-core"
  project   = "lab14"
  namespace = "${local.org}-${local.project}"

  region = "ap-northeast-2"

  vpc = {
    cidr_block = "10.0.0.0/16"
    name       = "main"
  }

  subnet = {
    cidr_block              = "10.0.1.0/24"
    name                    = "pub1"
    availability_zone       = "${local.region}a"
    map_public_ip_on_launch = true
  }
}