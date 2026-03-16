

resource "aws_s3_bucket" "s3_data_lake" {
  bucket = "bucket-data-lake-poc-kz-01"

}
resource  "aws_s3_bucket_public_access_block" "data_lake_access" {
  bucket = aws_s3_bucket.s3_data_lake.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "data_lake_versioning" {
  bucket = aws_s3_bucket.s3_data_lake.id

  versioning_configuration {
    status = "Enabled"
  }
}