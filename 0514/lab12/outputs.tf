output "sg" {
  value = {
    id   = aws_security_group.this.id
    name = aws_security_group.this.name
  }
}