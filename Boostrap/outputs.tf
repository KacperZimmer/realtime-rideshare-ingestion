output "state_bucket_name" {
  description = "Nazwa bucketu S3 przechowującego stan Terraforma"
  value       = aws_s3_bucket.terraform_state_bucket.bucket
}

output "state_bucket_arn" {
  description = "ARN bucketu ze stanem"
  value       = aws_s3_bucket.terraform_state_bucket.arn
}