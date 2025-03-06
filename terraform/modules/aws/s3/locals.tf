locals {
  # s3 properties
  # s3-bucket-arn = module.s3-bucket.s3-bucket-arn

  s3-properties = {
    s3-bucket-count         = 1
    s3-bucket-name          = ["s3-bucket"]
    s3-bucket-force-destroy = [true]

    s3-bucket-versioning = ["Disabled"]

    s3-bucket-ownership-controls-object-ownership = ["BucketOwnerPreferred"]

    s3-bucket-acl = ["private"]

    s3-bucket-public-access-block-public-acls        = [false]
    s3-bucket-public-access-block-public-policy      = [false]
    s3-bucket-public-access-ignore-public-acls       = [false]
    s3-buckets-public-access-restrict-public-buckets = [false]

    s3-bucket-website-configuration-count = 0

    s3-object-count  = 0
    s3-object-key    = ""
    s3-object-source = ""

    s3-bucket-policy-count = 0
  }

  s3-bucket-policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "*",
        # "Resource" : "${local.s3-bucket-arn}/*"
      }
    ]
  }
}
