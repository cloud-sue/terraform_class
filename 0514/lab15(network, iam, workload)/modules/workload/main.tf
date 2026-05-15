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

  # 기존에는 정책이 붙기 전에 연결될까봐 의존성 걸어놓은건데
  # module간의 의존성으로 변경되었기 때문에 이미 생성된 후라서 필요 없음
  # depends_on = [var.iamattachment]

  tags = {
    Name = "${local.namespace}-instance-${local.instance.name}"
  }
}
