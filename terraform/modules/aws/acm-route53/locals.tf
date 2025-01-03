locals {
  # route53 properties
  route53-properties = {
    route53-zone-name = "example.com"
  }

  # acm properties
  acm-properties = {
    acm-certificate-domain-name       = "example.com"
    acm-certificate-validation-method = "DNS"
  }
}