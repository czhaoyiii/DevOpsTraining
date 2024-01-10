terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  count = 1
  key_name = "Server_Key"

  tags = {
    Name = "Server"
  }
}

resource "aws_instance" "app_client" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  count = 2
  key_name = "Client_Key"

  tags = {
    Name = "Client"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "zhaoyiii-terraform-states"
}
