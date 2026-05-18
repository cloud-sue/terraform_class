output "vpc" {
  value = { (local.vpc.name) = {
    id = aws_vpc.this.id
    }
  }
}



output "subnet" {
  value = {

    # "pub-1" = {
    #   id = aws_subnet.pub1.id
    # },
    #   "pub-2" = {
    #   id = aws_subnet.pub2.id
    # },

    # 위에처럼 직접 이름을 쓸 수 있지만 이름은 바뀔 수 있기 때문에 참조해서 쓸 수 있음
    # 단, 괄호 필요
    # pub1
    (local.public_subnet[0].name) = {
      id         = aws_subnet.pub1.id,
      cidr_block = aws_subnet.pub1.cidr_block
    },
    # pub2
    (local.public_subnet[1].name) = {
      id         = aws_subnet.pub2.id,
      cidr_block = aws_subnet.pub2.cidr_block
    },
    # pri1
    (local.private_subnet[0].name) = {
      id         = aws_subnet.pri1.id,
      cidr_block = aws_subnet.pri1.cidr_block
    },
    # pri2
    (local.private_subnet[1].name) = {
      id         = aws_subnet.pri2.id,
      cidr_block = aws_subnet.pri2.cidr_block
    }
  }
}
