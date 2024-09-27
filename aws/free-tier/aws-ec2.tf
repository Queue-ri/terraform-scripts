terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# 프로바이더 지정
provider "aws" {
    region = "ap-northeast-2"
    shared_credentials_file = "%USERPROFILE%/.aws/credentials"
    profile = "terraform_user"
}

# EC2 설정
resource "aws_instance" "integrated-server" {
    ami = "ami-0f0646a5f59758444"
    instance_type = "t2.micro"
    key_name = aws_key_pair.make_keypair.key_name
    associate_public_ip_address = true
    security_groups = [ aws_security_group.ec2_sg.name ] # id 아님!

    root_block_device {
        volume_type = "gp2"
        volume_size = 30
    }
}

# EC2 Security Rules
resource "aws_security_group" "ec2_sg" {
  name = "allow-ssh"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

# EIP 설정
resource "aws_eip" "integrated-server-eip" {
    vpc = true
    instance = aws_instance.integrated-server.id
}
