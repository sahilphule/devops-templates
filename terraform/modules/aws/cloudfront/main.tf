resource "aws_cloudfront_origin_access_control" "cloudfront-oac" {
  name                              = var.cloudfront-properties.cloudfront-oac-name
  description                       = "An origin access control with s3 origin domain for cloudfront"
  origin_access_control_origin_type = var.cloudfront-properties.cloudfront-oac-origin-type
  signing_behavior                  = var.cloudfront-properties.cloudfront-signing-behavior
  signing_protocol                  = var.cloudfront-properties.cloudfront-signing-protocol
}

resource "aws_cloudfront_distribution" "cloudfront-distribution" {
  enabled             = var.cloudfront-properties.cloudfront-distribution-enabled
  default_root_object = var.cloudfront-properties.cloudfront-distribution-default-root-object
  aliases             = var.cloudfront-properties.cloudfront-distribution-aliases
  price_class         = var.cloudfront-properties.cloudfront-distribution-price-class
  is_ipv6_enabled     = var.cloudfront-properties.cloudfront-distribution-is-ipv6-enabled
  comment             = var.cloudfront-properties.cloudfront-distribution-comment

  origin {
    domain_name              = var.s3-bucket-regional-domain-name
    origin_id                = var.cloudfront-properties.cloudfront-distribution-origin-id
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront-oac.id
  }

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.cloudfront-properties.cloudfront-distribution-origin-id
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern           = "/content/immutable/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = var.cloudfront-properties.cloudfront-distribution-origin-id
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern           = "/content/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.cloudfront-properties.cloudfront-distribution-origin-id
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront-properties.cloudfront-distribution-geo-restriction-type
      locations        = var.cloudfront-properties.cloudfront-distribution-geo-restriction-locations
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm-certificate-arn
    ssl_support_method             = var.cloudfront-properties.cloudfront-distribution-viewer-certificate-ssl-support-method
    minimum_protocol_version       = var.cloudfront-properties.cloudfront-distribution-viewer-certificate-minimum-protocol-version
    cloudfront_default_certificate = var.cloudfront-properties.cloudfront-distribution-viewer-certificate-default-certificate
  }
}
