output "instance" {
  value = aws_instance.minimal.id
}

output "sg" {
  value = aws_security_group.instance_minimal.id
}

output "iamprofile" {
  value = aws_iam_instance_profile.instance_minimal.name
}

output "iamrole" {
  value = aws_iam_role.instance_minimal.id
}