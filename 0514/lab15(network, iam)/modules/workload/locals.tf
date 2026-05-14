locals {
  namespace = var.namespace

  vpc = {
    id = var.vpc_id
  }

  subnet = {
    id = var.subnet_id
  }

  instance = {
    ami                         = data.aws_ami.amazon_linux.id
    instance_type               = "t3.micro"
    name                        = "web"
    associate_public_ip_address = true
    subnet_id                   = local.subnet.id

    allow_access = {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}
