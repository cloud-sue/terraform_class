locals {
  org     = "tf-user" # providers.tf에서 참고
  project = "lab11"

  namespace = "${local.org}-${local.project}"

  s3bucket = {
    name   = "tfstate"                             # 내가 구분하기 위한 이름
    bucket = "${local.org}-tfstate" #실제 AWS s3 버킷 이름

    versioning_configuration = {
      status = "Enabled"
    }

    public_access_block = {
      block_public_acls       = true
      block_public_policy     = true
      ignore_public_acls      = true
      restrict_public_buckets = true
    }

  }
}