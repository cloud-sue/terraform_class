output "instance" {
  value = {
    (local.instance.name) = {
      id        = aws_instance.web.id
      public_ip = aws_instance.web.public_ip
    }
  }
}

output "web_endpoint" {
  value = "http://${aws_instance.web.public_ip}:${local.instance.allow_access.port}"
}