# init 할 때 꼭 필요한 요소1
terraform {
  required_version = ">=1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# init 할 때 꼭 필요한 요소2
provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_security_group" "sg_sue" {
  name = "tf-user-lab01-sg-web"
  tags = {
    Name = "tf-user-lab01-sg-web"
  }
}

# 보안그룹을 출력하겠다
output "sg" {
  value = aws_security_group.sg_sue.name
}