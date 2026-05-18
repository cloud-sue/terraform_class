terraform {
  required_version = ">=1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # s3 bucket에 넣는거라서 상태파일이 안생김
  # .terraform에 생긴 state file은 s3에 저장된 상태에 대한 정보
  backend "s3" {
    bucket       = "tf-user-tfstate" # bucket이름
    key          = "gallery/terraform.tfstate"
    region       = "ap-northeast-2"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      Organization = local.org
      Project      = local.project
      ManagedBy    = "Terraform"
    }
  }
}
