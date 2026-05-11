# init 할 때 꼭 필요한 요소1
terraform {
  required_version = ">= 1.14.0" #>=버전 : 해당 버전보다 큰 버전이면 사용 가능

  required_providers {
    #azurm
    aws = {
      # provider를 모아놓은 곳(hashicorp : 공식)
      # https://registry.terraform.io/providers/hashicorp/aws/latest
      source  = "hashicorp/aws"
      version = "~>6.0" # ~>버전 : 해당 버전대만 가능, 즉 6.9까지 가능, 7은 불가능
    }
  }
}

# init 할 때 꼭 필요한 요소2
provider "aws" {
  region = "ap-northeast-2" # 따로 안적으면 aws 인증했던 region이 기본이 된다.
}

# format 코드 정리 : 전체 드래그 + shift+alt+F

locals {
  vpc_cidr_block = "10.0.0.0/24"
}

# 코드상에서 사용하는 이름(terraform내에서만 관리하는 이름), 즉 변수
# ->  실제 resource와 관련 없음
resource "aws_vpc" "main" {
  cidr_block           = local.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    # Naming 규칙 : organization project resource capability(용도)
    Name = "tf-user-lab02-vpc-main"
  }
}

# plan or apply 하고 출력되는 부분
output "vpc" {
  value = {
    id  = aws_vpc.main.id
    arn = aws_vpc.main.arn
  }

}
