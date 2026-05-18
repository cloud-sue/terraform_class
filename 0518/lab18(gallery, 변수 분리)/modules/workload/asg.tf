resource "aws_autoscaling_group" "this" {
  name = "${local.namespace}-asg-${local.asg.name}"

  min_size         = local.asg.min_size
  max_size         = local.asg.max_size
  desired_capacity = local.asg.desired_capacity

  vpc_zone_identifier = local.asg.vpc_zone_identifier

  target_group_arns = local.asg.target_group_arns

  health_check_type         = local.asg.health_check_type
  health_check_grace_period = local.asg.health_check_grace_period

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling" # 새 버전 올려놓고 옛날 버전 죽이는거..?
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"] # 중요! 
    # triggers 설정을 안해놓으면 내용이 조금만 바뀌어도(띄어쓰기, 엔터) 템플릿이 새버전으로 올라가버림
    # 즉 태그가 바뀌면 인스턴스를 새로 만들겠다 임!
    # 내용이 바뀌면 태그 업데이트 하기
  }

  tag {
    key                 = "DeployVersion"
    value               = "${local.namespace}-asg-${local.asg.deploy_version}"
    propagate_at_launch = true # 해당 태그를 launch template에도 적용해준다는 설정
  }
}
resource "aws_launch_template" "this" {
  name = "${local.namespace}-lt-${local.lt.name}"

  image_id               = local.lt.image_id
  instance_type          = local.lt.instance_type
  vpc_security_group_ids = [aws_security_group.this.id]
  update_default_version = true # 새버전이 항상 default 버전으로

  iam_instance_profile {
    name = local.lt.iam_instance_profile.name
  }

  user_data = local.lt.user_data

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.namespace}-instance-${local.lt.name}"
    }
  }

  tags = {
    Name = "${local.namespace}-lt-${local.lt.name}"
  }
}

resource "aws_security_group" "this" {
  name = "${local.namespace}-sg-lt-${local.lt.name}"

  vpc_id = local.vpc_id

  ingress {
    from_port   = local.lt.allow_access.port
    to_port     = local.lt.allow_access.port
    protocol    = "tcp"
    cidr_blocks = local.lt.allow_access.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.namespace}-sg-lt-${local.lt.name}"
  }
}