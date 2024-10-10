resource "aws_s3_bucket" "s3-bucket" {
  bucket        = var.s3-properties.s3-bucket-name
  force_destroy = var.s3-properties.s3-bucket-force-destroy
}

resource "aws_s3_bucket_versioning" "s3-bucket-versioning" {
  bucket = var.s3-properties.s3-bucket-name

  versioning_configuration {
    status = var.s3-properties.s3-bucket-versioning
  }
}