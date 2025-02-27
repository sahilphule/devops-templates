resource "aws_route53_record" "route53-ip-record" {
  count = var.route53-record-properties.route53-ip-record-count

  name    = var.route53-record-properties.route53-ip-record-name
  type    = var.route53-record-properties.route53-ip-record-type
  ttl     = var.route53-record-properties.route53-ip-record-ttl
  records = var.route53-record-properties.route53-ip-record-records
  zone_id = var.route53-record-properties.route53-apex-zone-id[count.index]
}

resource "aws_route53_record" "route53-apex-alias-record" {
  count = var.route53-record-properties.route53-apex-alias-record-count

  name    = var.route53-record-properties.route53-apex-alias-record-name
  type    = var.route53-record-properties.route53-apex-alias-record-type
  zone_id = var.route53-record-properties.route53-apex-zone-id[count.index]

  alias {
    name                   = var.route53-record-properties.route53-apex-alias-record-dns-name
    zone_id                = var.route53-record-properties.route53-apex-alias-record-zone-id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "route53-dev-alias-record" {
  count = var.route53-record-properties.route53-dev-alias-record-count

  name    = var.route53-record-properties.route53-dev-alias-record-name
  type    = var.route53-record-properties.route53-dev-alias-record-type
  zone_id = var.route53-record-properties.route53-dev-zone-id[count.index]

  alias {
    name                   = var.route53-record-properties.route53-dev-alias-record-dns-name
    zone_id                = var.route53-record-properties.route53-dev-alias-record-zone-id
    evaluate_target_health = false
  }
}
