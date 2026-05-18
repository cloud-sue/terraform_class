locals {
  namespace = var.namespace
  region    = var.region

  vpc = {
    id = var.vpc_id
  }

  iamrole = {
    name = "main"

    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
    policy_arn         = data.aws_iam_policy.aws_ssm_core_policy.arn
  }

  lb = {
    name = "main"

    internal                   = false # 외부 접속 가능
    load_balancer_type         = "application"
    # enable_deletion_protection = false

    subnets = var.lb_subnets

    listener = {
      port        = 80
      protocol    = "HTTP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    target_group = {
      # 보통 서비스의 port번호와 일치시키는 것이 관례
      port        = 8080
      protocol    = "HTTP"
      target_type = "instance"

      health_check = {
        enabled             = true
        port                = 8080
        protocol            = "HTTP"
        # main 페이지에 많이 있으면 health check하는데 트래픽 소요가 많이 되기 때문에 health_check 하는 페이지를 보통 따로 둠
        path                = "/actuator/health" 
        healthy_threshold   = 3 # 3번 성공
        unhealthy_threshold = 3 # 3번 실패
        timeout             = 5
        interval            = 30
      }
    }
  }
}
