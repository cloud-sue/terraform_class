output "iamprofile" {
  value = {
    (local.iamrole.name) = {
      name = aws_iam_instance_profile.this.name
    }
  }
}

output "lb" {
  value = {
    (local.lb.name) = {
      dns_name = aws_lb.this.dns_name

      # 개발자들이 알아야하는 정보
      listener = {
        port     = aws_lb_listener.this.port
        protocol = aws_lb_listener.this.protocol
      },

      # EC2나 ECS 같은 워크로드 리소스가 자기 자신을 Target Group에 등록할 때 ARN이 필요
      target_group = {
        arn = aws_lb_target_group.this.arn
      }
    }


  }
}
