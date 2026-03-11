provider "aws" {
  region = "eu-west-1"
}


resource "aws_s3_bucket" "state_bucket" {
  bucket = var.bucket_name
}
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "true"
  }
}
