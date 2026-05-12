# local에 지정해서 코드 간결하게 하기
resource "aws_iam_role" "instance" {
  name               = "${local.project}-iamrole-${local.iamrole.name}"
  assume_role_policy = local.iamrole.assume_role_policy

  tags = {
    Name = "${local.project}-iamrole-${local.iamrole.name}"
  }
}

resource "aws_iam_role_policy_attachment" "instance_ssm" {
  role       = aws_iam_role.instance.name
  policy_arn = local.iamrole.policy_arn
}

resource "aws_iam_instance_profile" "instance" {
  name = "${local.project}-iamprofile-${local.iamrole.name}"

  role = aws_iam_role.instance.name

  tags = {
    Name = "${local.project}-iamprofile-${local.iamrole.name}"
  }
}

resource "aws_security_group" "instance" {
  name = "${local.project}-sg-instance"

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
    Name = "${local.project}-sg-${local.instance.name}"
  }
}

resource "aws_instance" "instance" {
  ami                    = local.instance.ami
  instance_type          = local.instance.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id]
  iam_instance_profile   = aws_iam_instance_profile.instance.name
  depends_on             = [aws_iam_role_policy_attachment.instance_ssm]

  tags = {
    Name = "${local.project}-instance-${local.instance.name}"
  }
}
