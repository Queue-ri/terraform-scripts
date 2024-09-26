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
    vpc_security_group_ids = [ "sg-0fde538436252f879" ]
    associate_public_ip_address = true

    root_block_device {
        volume_type = "gp2"
        volume_size = 30
    }
}

# EIP 설정
resource "aws_eip" "integrated-server-eip" {
    vpc = true
    instance = aws_instance.integrated-server.id
}
