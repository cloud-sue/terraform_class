module "network" {
  source    = "./modules/network"
  namespace = local.namespace
  region    = local.region
}

module "iam" {
  source    = "./modules/iam"
  namespace = local.namespace
}

module "workload" {
  source    = "./modules/workload"
  namespace = local.namespace
  region    = local.region

  vpc_id    = module.network.vpc.id
  subnet_id = module.network.subnet.id

  iamprofile_name = module.iam.iamprofile.name

}

