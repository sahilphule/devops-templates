output "s3-bucket-id" {
  description = "s3 bucket id"
  value       = aws_s3_bucket.s3-bucket.id
}

output "s3-bucket-name" {
  description = "s3 bucket name"
  value       = aws_s3_bucket.s3-bucket.tags.Name
}