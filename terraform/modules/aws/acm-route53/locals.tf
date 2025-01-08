locals {
  # acm properties
  acm-properties = {
    acm-certificate-domain-name       = "example.com"
    acm-certificate-validation-method = "DNS"
  }

  # route53 properties
  route53-zone-properties = {
    route53-apex-zone-count = 0
    route53-apex-zone-name  = "example.com"

    route53-dev-zone-count = 0
    route53-dev-zone-name  = "dev.example.com"
  }
}