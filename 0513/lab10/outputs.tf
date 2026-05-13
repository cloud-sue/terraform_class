output "instance" {
  value = {
    (local.instance.name) = {
        id = aws_instance.instance.id
        public_ip = aws_instance.instance.public_ip
    }
  }
}

output "web_endpoint" {
  value = "http://${aws_instance.instance.public_ip}:${local.instance.allow_access.port}"
}