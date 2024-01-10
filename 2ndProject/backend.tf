terraform {
  backend "s3" {
    bucket = "zhaoyiii-terraform-states"
    region = "us-east-1"
    key = "brandon/terraform.tfstate"
  }
}
