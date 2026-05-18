locals {
  org       = "tf-core"
  project   = "lab18-gallery"
  namespace = "${local.org}-${local.project}"

  region = "ap-northeast-2"

  infra = {
    lt = {
      service_port = 8080
    }
    
    lb = {
      target_group_port = 8080
      listener_port = 80
    }

    asg = {
      asg_min_size = 2
      asg_max_size = 4
      asg_desired_capacity = 2
    }
  }
}