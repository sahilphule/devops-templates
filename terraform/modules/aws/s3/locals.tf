locals {
  # s3 properties
  s3-properties = {
    s3-bucket-name          = "s3-bucket"
    s3-bucket-force-destroy = true
    s3-bucket-versioning    = "Disabled"
  }
}