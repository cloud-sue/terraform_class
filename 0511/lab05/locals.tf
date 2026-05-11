locals {
  org     = "tf-user"
  project = "lab05"

  namespace = "${local.org}-${local.project}"

  sg = {
    name="${local.namespace}-sg-instance-web"
  }
}
