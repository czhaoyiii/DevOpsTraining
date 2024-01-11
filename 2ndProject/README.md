## 2nd Project (Creating 3 EC2 Instances using Terraform)
### Configurations:
1. Install Chocolatey on Windows
   
Ensure that the terminal is open as admin
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
2. Install Terraform on Windows
```
choco install terraform
```
3. Setting up AWS CLI
```
 aws configure
```
```
 AWS Access Key ID [*************xxxx]: <Your AWS Access Key ID>
 AWS Secret Access Key [**************xxxx]: <Your AWS Secret Access Key>
 Default region name: [us-east-1]: us-east-1
 Default output format [None]:
```

### Deployments:
1. Create and set up the terraform file (main.tf)
```
vim main.tf
```
```
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
    description      = "HTTP"
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

```
2. Initialize the Terraform configuration
```
terraform init
```
3. Create the Terraform plan
```
terraform plan
```
4. Execute the Terraform plan
```
terraform apply
```
5. Create the backend file
```
vim backend.tf
```
```
terraform {
  backend "s3" {
    bucket = "zhaoyiii-terraform-states"
    region = "us-east-1"
    key = "brandon/terraform.tfstate"
  }
}
```
6. Reinitialise, Plan and Apply Terraform again
```
terraform init
terraform plan
terraform apply
```
7. Delete the tfstate in the directory

Now we are able launch multiple instances while storing the logs (.tfstate) in AWS S3.

Wanted to implement a lock system, dynamodb but it is a paid service. :(

---
Reference:

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

https://github.com/ozbillwang/terraform-best-practices
