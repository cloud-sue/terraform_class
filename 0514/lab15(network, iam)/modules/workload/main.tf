resource "aws_security_group" "instance" {
  name = "${local.namespace}-sg-instance"
  vpc_id = local.vpc.id

  ingress {
    from_port   = local.instance.allow_access.port
    to_port     = local.instance.allow_access.port
    protocol    = "tcp"
    cidr_blocks = local.instance.allow_access.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.namespace}-sg-${local.instance.name}"
  }
}

resource "aws_instance" "instance" {
  ami                         = local.instance.ami
  instance_type               = local.instance.instance_type
  associate_public_ip_address = local.instance.associate_public_ip_address
  subnet_id                   = local.instance.subnet_id

  vpc_security_group_ids = [aws_security_group.instance.id]
  iam_instance_profile   = var.iamprofile_name

  depends_on = [var.iamattachment]

  tags = {
    Name = "${local.namespace}-instance-${local.instance.name}"
  }
}
