module "network" {
  source    = "./modules/network"
  namespace = local.namespace
  region    = local.region
}

# main에서 불러올 때 '-'는 마이너스 연산자로 들어가기 때문에 - 를 사용할 수 없다.
# 그래서 그럴 경우에는 key값을 인덱스로 불러오는 것으로 활용하면 됨
# module.network.subnet.pub-1 == module.network.subnet["pub-1"]

# aws에서는 -를 이름에 사용하기 때문에 규칙을 지키기 위해서 다양한 방법 활용 가능
# terraform 문법에서는 - 가 연산자 취급이 되어 사용 불가능
# module "platform" {
#   source = "./modules/platform"
#   subnet = [
#     module.network.subnet[pub-1].id,
#     module.network.subnet[pub-2].id,
#   ]
# }