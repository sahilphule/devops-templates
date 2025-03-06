resource "aws_s3_bucket" "s3-bucket" {
  bucket        = var.s3-properties.s3-bucket-name
  force_destroy = var.s3-properties.s3-bucket-force-destroy
}

resource "aws_s3_bucket_versioning" "s3-bucket-versioning" {
  bucket = var.s3-properties.s3-bucket-name

  versioning_configuration {
    status = var.s3-properties.s3-bucket-versioning
  }

  depends_on = [
    aws_s3_bucket.s3-bucket
  ]
}

resource "aws_s3_bucket_ownership_controls" "s3-bucket-ownership-controls" {
  bucket = aws_s3_bucket.s3-bucket.id

  rule {
    object_ownership = var.s3-properties.s3-bucket-ownership-controls-object-ownership
  }

  depends_on = [
    aws_s3_bucket.s3-bucket
  ]
}

resource "aws_s3_bucket_acl" "s3-bucket-acl" {
  bucket = aws_s3_bucket.s3-bucket.id
  acl    = var.s3-properties.s3-bucket-acl

  depends_on = [
    aws_s3_bucket_ownership_controls.s3-bucket-ownership-controls
  ]
}

resource "aws_s3_bucket_public_access_block" "s3-bucket-public-access" {
  bucket = aws_s3_bucket.s3-bucket.id

  block_public_acls       = var.s3-properties.s3-bucket-public-access-block-public-acls
  block_public_policy     = var.s3-properties.s3-bucket-public-access-block-public-policy
  ignore_public_acls      = var.s3-properties.s3-bucket-public-access-ignore-public-acls
  restrict_public_buckets = var.s3-properties.s3-buckets-public-access-restrict-public-buckets

  depends_on = [
    aws_s3_bucket.s3-bucket
  ]
}

resource "aws_s3_bucket_website_configuration" "s3-bucket-website-configuration" {
  count = var.s3-properties.s3-bucket-website-configuration-count

  bucket = aws_s3_bucket.s3-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [
    aws_s3_bucket.s3-bucket
  ]
}

resource "aws_s3_bucket_policy" "s3-bucket-policy" {
  count = var.s3-properties.s3-bucket-policy-count

  bucket = aws_s3_bucket.s3-bucket.id
  policy = jsonencode(var.s3-bucket-policy)

  depends_on = [
    aws_s3_bucket_public_access_block.s3-bucket-public-access
  ]
}

resource "aws_s3_object" "s3-object" {
  count = var.s3-properties.s3-object-count

  bucket = aws_s3_bucket.s3-bucket.bucket
  key    = var.s3-properties.s3-object-key
  source = var.s3-properties.s3-object-source
  etag   = filemd5(var.s3-properties.s3-object-source)
}
