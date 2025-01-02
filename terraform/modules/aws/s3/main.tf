resource "aws_s3_bucket" "s3-bucket" {
  bucket        = var.s3-bucket-properties.s3-bucket-name
  force_destroy = var.s3-bucket-properties.s3-bucket-force-destroy
}

resource "aws_s3_bucket_versioning" "s3-bucket-versioning" {
  bucket = var.s3-bucket-properties.s3-bucket-name

  versioning_configuration {
    status = var.s3-bucket-properties.s3-bucket-versioning
  }
}

resource "aws_s3_bucket_ownership_controls" "s3-bucket-ownership-controls" {
  bucket = aws_s3_bucket.s3-bucket.id

  rule {
    object_ownership = var.s3-bucket-properties.s3-bucket-ownership-controls-object-ownership
  }
}

resource "aws_s3_bucket_acl" "s3-bucket-acl" {
  bucket = aws_s3_bucket.s3-bucket.id
  acl    = var.s3-bucket-properties.s3-bucket-acl

  depends_on = [
    aws_s3_bucket_ownership_controls.s3-bucket-ownership-controls
  ]
}

resource "aws_s3_bucket_public_access_block" "s3-bucket-public-access" {
  bucket = aws_s3_bucket.s3-bucket.id

  block_public_acls       = var.s3-bucket-properties.s3-bucket-public-access-block-public-acls
  block_public_policy     = var.s3-bucket-properties.s3-bucket-public-access-block-public-policy
  ignore_public_acls      = var.s3-bucket-properties.s3-bucket-public-access-ignore-public-acls
  restrict_public_buckets = var.s3-bucket-properties.s3-buckets-public-access-restrict-public-buckets
}