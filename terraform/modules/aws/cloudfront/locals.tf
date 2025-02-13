locals {
  # cloudfront properties
  cloudfront-properties = {
    cloudfront-oac-name         = "s3-bucket-oac"
    cloudfront-oac-origin-type  = "s3"
    cloudfront-signing-behavior = "always"
    cloudfront-signing-protocol = "sigv4"

    cloudfront-distribution-enabled             = true
    cloudfront-distribution-default-root-object = "index.html"
    cloudfront-distribution-aliases             = ["example.com", "dev.example.com"]
    cloudfront-distribution-price-class         = "PriceClass_200"
    cloudfront-distribution-is-ipv6-enabled     = false
    cloudfront-distribution-comment             = "official website"

    cloudfront-distribution-origin-id = "primaryS3"

    cloudfront-distribution-geo-restriction-type      = "none"
    cloudfront-distribution-geo-restriction-locations = []

    cloudfront-distribution-viewer-certificate-ssl-support-method       = "sni-only"
    cloudfront-distribution-viewer-certificate-minimum-protocol-version = "TLSv1.2_2021"
    cloudfront-distribution-viewer-certificate-default-certificate      = true
  }
}
