output "iamprofile" {
  value = {
    name = aws_iam_instance_profile.this.name
  }
}

output "iamattachment" {
  value = {
    iamattachment = aws_iam_role_policy_attachment.this_ssm
  }
}