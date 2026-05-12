# 역할 만들기
resource "aws_iam_role" "instance_minimal" {
  name = "${local.project}-iamrole-instance-minimal"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "${local.project}-iamrole-instance-minimal"
  }
}

# 역할에 정책 붙이기
# SSM : EC2를 원격으로 관리하기 위한 AWS 서비스
# AmazonSSMManagedInstanceCore : EC2가 SSM Session Manager로 관리되기 위해 필요한 최소 권한을 묶어놓은 것
resource "aws_iam_role_policy_attachment" "instance_minimal_ssm" {
  role       = aws_iam_role.instance_minimal.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# 프로필(role의 포장지) 생성
resource "aws_iam_instance_profile" "instance_minimal" {
  name = "${local.project}-iamprofile-instance-minimal"

  role = aws_iam_role.instance_minimal.name

  tags = {
    Name = "${local.project}-iamprofile-instance-minimal"
  }
}

# SG 생성
# SSM이 API Server라서 EC2 -> SSM 엔드포인트로 연결 시도
# EC2가 SSM에 폴링(polling)방식으로 연결을 하기 때문에 아웃바운드만 있으면 됨
# 즉, 나가기만 하면 됨(요청만 하면 된다는 뜻)
resource "aws_security_group" "instance_minimal" {
  name = "${local.project}-sg-instance-minimal"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project}-sg-instance-minimal"
  }
}

resource "aws_instance" "minimal" {
  ami           = "ami-0c003e98ceffee43e"
  instance_type = "t3.micro"
  # sg를 여러개 놓을 수 있기 때문에 list [] 사용
  vpc_security_group_ids = [aws_security_group.instance_minimal.id]

  iam_instance_profile = aws_iam_instance_profile.instance_minimal.name
  # depends on : 명시적으로 정책이 만들어지고 나서 EC2가 생성될 수 있도록 지정
  # role, profile, ec2는 순서대로 만들어진다. why?  각 resource에 참조되어 있기 때문에
  # 그러나 instance에는 policy에 대한 참조가 없어서 정책이 들어가는지는 체크 X, 즉 테라폼은 모른다!
  # 따라서 정책을 명시해서 해당 정책이 들어가고나서 인스턴스 생성할 수 있도록 함
  # 정책이 나중에 추가되면 꼬이거나 문제가 생길 수 있음
  # depends_on은 비용이 발생하기 때문에 참조로 해결 가능하면 참조를 먼저 쓰고, 암묵적 의존성이 누락된 경우에만 사용
  depends_on = [aws_iam_role_policy_attachment.instance_minimal_ssm]

  tags = {
    Name = "${local.project}-instance-minimal"
  }
}