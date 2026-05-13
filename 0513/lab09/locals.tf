locals {
  project = "tf-user-lab07"

  vpc_id = data.aws_vpc.default.id

  iamrole = {
    name = "instance"

    assume_role_policy = data.aws_iam_policy.ec2_assume_role_policy
    policy_arn         = data.aws_iam_policy.aws_ssm_core_policy
  }

  instance = {
    ami                         = data.aws_ami.amazon_linux
    instance_type               = "t3.micro"
    name                        = "ssm_test"
    associate_public_ip_address = true
    subnet_id                   = data.aws_subent.default.ids[0]

    allow_access = {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
