# resource "aws_route53_record" "route53-ip-record" {
#   name    = var.route53-record-properties.route53-ip-record-name
#   type    = var.route53-record-properties.route53-ip-record-type
#   ttl     = var.route53-record-properties.route53-ip-record-ttl
#   records = var.route53-record-properties.route53-ip-record-records
#   zone_id = var.route53-zone-id
# }

resource "aws_route53_record" "route53-alias-record" {
  name    = var.route53-record-properties.route53-alias-record-name
  type    = var.route53-record-properties.route53-alias-record-type
  zone_id = var.route53-zone-id

  alias {
    name                   = var.route53-record-properties.route53-alias-record-dns-name
    zone_id                = var.route53-record-properties.route53-alias-record-zone-id
    evaluate_target_health = true
  }
}