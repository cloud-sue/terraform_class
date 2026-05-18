output "module" {
  value =  {
    network = module.network
    platform = module.platform
    workload = module.workload
  }
}

output "endpoint" {
  value = "${lower(module.platform.lb.listener.protocol)}://${module.platform.lb.dns_name}:${module.platform.lb.listener.port}"
}