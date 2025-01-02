locals {
  # s3 properties
  s3-bucket-properties = {
    s3-bucket-name          = "s3-bucket"
    s3-bucket-force-destroy = true

    s3-bucket-versioning = "Disabled"

    s3-bucket-ownership-controls-object-ownership = "BucketOwnerPreferred"

    s3-bucket-acl = "private"

    s3-bucket-public-access-block-public-acls        = false
    s3-bucket-public-access-block-public-policy      = false
    s3-bucket-public-access-ignore-public-acls       = false
    s3-buckets-public-access-restrict-public-buckets = false
  }
}