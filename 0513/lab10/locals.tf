locals {
  project = "tf-user-lab10"

  vpc_id = data.aws_vpc.default.id

  iamrole = {
    name = "instance"

    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
    policy_arn         = data.aws_iam_policy.aws_ssm_core_policy.arn
  }

  instance = {
    ami                         = data.aws_ami.amazon_linux.id
    instance_type               = var.instance_type
    name                        = "ssm_test"
    associate_public_ip_address = true
    subnet_id                   = data.aws_subnets.default.ids[0]

    allow_access = {
      port        = var.service_port
      cidr_blocks = var.cir_blocks
    }
  }
}