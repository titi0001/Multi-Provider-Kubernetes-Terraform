terraform {
  backend "s3" {
    bucket = "terraform-state-codingbr"
    key = "Prod/terraform.tfstate"
    region = "us-west-2"
  }
}