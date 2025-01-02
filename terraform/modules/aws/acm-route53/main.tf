resource "aws_acm_certificate" "acm-certificate" {
  domain_name       = var.acm-properties.acm-certificate-domain-name
  validation_method = var.acm-properties.acm-certificate-validation-method

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "route53-zone" {
  name = var.route53-properties.route53-zone-name
}

# resource "aws_route53_record" "route53-ip-record" {
#   name    = var.route53-properties.route53-ip-record-name
#   type    = var.route53-properties.route53-ip-record-type
#   ttl     = var.route53-properties.route53-ip-record-ttl
#   records = var.route53-properties.route53-ip-record-records
#   zone_id = aws_route53_zone.route53-zone.zone_id
# }

resource "aws_route53_record" "route53-alias-record" {
  name    = var.route53-properties.route53-alias-record-name
  type    = var.route53-properties.route53-alias-record-type
  zone_id = aws_route53_zone.route53-zone.zone_id

  alias {
    name                   = var.route53-properties.route53-alias-record-dns-name
    zone_id                = var.route53-properties.route53-alias-record-zone-id
    evaluate_target_health = true
  }

  depends_on = [
    aws_route53_zone.route53-zone
  ]
}

resource "aws_route53_record" "route53-record" {
  for_each = { for dvo in aws_acm_certificate.acm-certificate.domain_validation_options : dvo.domain_name => {
    name   = dvo.resource_record_name
    type   = dvo.resource_record_type
    record = dvo.resource_record_value
  } }

  zone_id = aws_route53_zone.route53-zone.zone_id

  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60

  depends_on = [
    aws_route53_zone.route53-zone
  ]
}

resource "aws_acm_certificate_validation" "acm-certificate-validation" {
  certificate_arn         = aws_acm_certificate.acm-certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53-record : record.fqdn]
}