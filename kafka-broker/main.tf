data "aws_subnet" "private_subnet" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet"]
  }
}

data "aws_vpc" "main_vpc" {
  filter {
    name   = "tag:Name"
    values = ["main-vpc"]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "kafka_security_group" {
  name   = "kafka-sg"
  vpc_id = data.aws_vpc.main_vpc.id

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kafka-sg"
  }
}

resource "aws_instance" "kafka-broker" {
  subnet_id              = data.aws_subnet.private_subnet.id
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.kafka_security_group.id]

  tags = {
    Name = "kafka-broker-ec2"
  }
}