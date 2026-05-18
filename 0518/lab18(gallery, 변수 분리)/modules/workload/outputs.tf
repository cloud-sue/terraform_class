output "asg" {
  value = {
    (local.asg.name) = {
        id = aws_autoscaling_group.this.id
        arn = aws_autoscaling_group.this.arn
        deploy_version = local.asg.deploy_version       
    }
  }
}