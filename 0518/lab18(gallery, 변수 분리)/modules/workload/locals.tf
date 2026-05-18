locals {
  namespace = var.namespace

  vpc_id = var.vpc_id

  asg = {
    name = "web"

    min_size         = var.asg_min_size
    max_size         = var.asg_max_size
    desired_capacity = var.asg_desired_capacity

    vpc_zone_identifier = var.asg_vpc_zone_identifier
    target_group_arns   = var.asg_target_group_arns

    # asg의 헬스체크는 instance의 갯수를 파악하기 위한 헬스체크인데 거의 무용지물임. (*OS 레벨 생존 여부만 파악)
    # 그래서 elb의 헬스체크를 사용하겠다
    # ec2 타입 : 인스턴스 상태가 running이면 무조건 정상으로 판단 -> web이 다운되어도 모름
    # elb 타입 : Target Group이 unhealthy 판정 내리면 새 인스턴스로 교체
    health_check_type         = "ELB" # target group의 헬스체크를 사용하겠다
    health_check_grace_period = 600 # 600초동안은 헬스체크 무시
    # 이유: 부팅 → 앱 설치/배포 → 서버 기동까지 시간이 걸리기 때문
    # 바로 체크해버리면 실행중인 인스턴스를 unhealty로 판단해서 무한 교체할 수 있음

    deploy_version = "1.0.0"
  }

  lt = {
    name = "web"

    image_id      = data.aws_ami.amazon_linux.id
    instance_type = "t3.small"

    iam_instance_profile = {
      name = var.lt_iam_instance_profile_name
    }

    user_data = base64encode(
      templatefile(
        "modules/workload/templates/user_data.sh.tpl",
        {
          # userdata 43번째줄 : 실행시킬 때 필요한 환경변수 값 넣어주기
          server_port = var.lt_service_port
          profile     = "dev"
        }
      )
    )

        allow_access = {
      port        = var.lt_service_port
      cidr_blocks = var.lt_allow_access_cidr_blocks
    }
  }

}
