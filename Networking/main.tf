provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-poc-de-project-02-kz"
    key = "networking/terraform.tfstate"
  }
}