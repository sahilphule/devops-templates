variable "s3-bucket-properties" {
  description = "s3 properties"
  type        = map(any)
}

variable "s3-bucket-policy" {
  description = "s3 bucket policy"
  type        = any
}