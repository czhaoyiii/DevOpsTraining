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

# Create the Server EC2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  count = 1
  key_name = "Server_Key"
  security_groups = [aws_security_group.Terraform_SG.name]

  tags = {
    Name = "Server"
  }
}

# Create the Client EC2 instance
resource "aws_instance" "app_client" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  count = 2
  key_name = "Client_Key"
  security_groups = [aws_security_group.Terraform_SG.name]

  tags = {
    Name = "Client"
  }
}

# Create the S3 Bucket for storing the logs of Terraform (.tfstate)
resource "aws_s3_bucket" "terraform_state" {
  bucket = "zhaoyiii-terraform-states"
}

# Create the EC2 Security Group to ssh into the EC2 instances.
resource "aws_security_group" "Terraform_SG" {
  name        = "EC2 SG using Terraform"
  description = "EC2 SG using Terrform"
  vpc_id      = "vpc-02585de53f275c621"

# Inbound rule: Typical SSH from any IP
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

# Inbound rule: Access port 443 from any IP
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

# Inbound rule: Access port 80 from any IP
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

# Outbound rule
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Terraform_SG"
  }
}
