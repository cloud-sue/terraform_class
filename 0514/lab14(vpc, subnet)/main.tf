module "vpc" {
  source = "./modules/vpc"

  # 모듈에서 필요한 namespace가 root module에 있는 locals에 정의되어 있어서 전달해주기
  namespace  = local.namespace
  cidr_block = local.vpc.cidr_block
  name       = local.vpc.name
}

module "subnet" {
  source = "./modules/subnet"

  # vpc 모듈에서 받아와야하는데 서로 다른 모듈이라서 알기 쉽지 않음. 
  # 따라서 vpc에서 output으로 밖으로 내보내주면 그 값을 subnet으로 받아주면 된다
  # 즉 moudel vpc의 output에 있는 id 값
  vpc_id = module.vpc.id

  namespace               = local.namespace
  cidr_block              = local.subnet.cidr_block
  name                    = local.subnet.name
  availability_zone       = local.subnet.availability_zone
  map_public_ip_on_launch = local.subnet.map_public_ip_on_launch

}