locals {
  org     = "tf-user"
  project = "lab13_gallery"

  namespace = "${local.org}-${local.project}"

  vpc_id = data.aws_vpc.default.id

  iamrole = {
    name = "instance"

    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
    policy_arn         = data.aws_iam_policy.aws_ssm_core_policy.arn
  }

  instance = {
    # ami                         = data.aws_ami.amazon_linux.id
    ami                         = "ami-038ddf7bdf6b77e57"
    instance_type               = "t3.small"
    name                        = "ssm_test"
    associate_public_ip_address = true
    subnet_id                   = data.aws_subnets.default.ids[0]

    # base64encdode : 스페이스같은 것들을 치환해서 인코딩해주는 것
    user_data = base64encode(
      templatefile(
        "templates/user_data.sh.tpl",
        {
          # userdata 43번째줄 : 실행시킬 때 필요한 환경변수 값 넣어주기
          server_port = 80
          profile     = "dev"
        }
      )
    )

    allow_access = {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
