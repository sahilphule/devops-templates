resource "aws_acm_certificate" "acm-certificate" {
  domain_name               = var.acm-properties.acm-certificate-domain-name
  subject_alternative_names = var.acm-properties.acm-certificate-subject-alternative-domain-names
  validation_method         = var.acm-properties.acm-certificate-validation-method

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "route53-apex-zone" {
  count = var.route53-zone-properties.route53-apex-zone-count
  name  = var.route53-zone-properties.route53-apex-zone-name
}

resource "aws_route53_record" "route53-acm-record" {
  for_each = {
    for dvo in aws_acm_certificate.acm-certificate.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      record  = dvo.resource_record_value
      zone_id = aws_route53_zone.route53-apex-zone[0].zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
  zone_id         = each.value.zone_id

  depends_on = [
    aws_acm_certificate.acm-certificate,
    aws_route53_zone.route53-apex-zone
  ]
}

resource "aws_acm_certificate_validation" "acm-certificate-validation" {
  certificate_arn         = aws_acm_certificate.acm-certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53-acm-record : record.fqdn]

  depends_on = [
    aws_route53_record.route53-acm-record
  ]
}

resource "aws_route53_zone" "route53-dev-zone" {
  count = var.route53-zone-properties.route53-dev-zone-count
  name  = var.route53-zone-properties.route53-dev-zone-name
}
