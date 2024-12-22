# resource "aws_route53_zone" "route53-zone" {
#   name = var.route53-properties.route53-zone-name
# }

resource "aws_route53_record" "route53-record" {
#   zone_id = aws_route53_zone.route53-zone.zone_id
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.route53-properties.route53-record-name
  type    = var.route53-properties.route53-record-type
#   ttl     = var.route53-properties.route53-record-ttl
#   records = var.route53-properties.route53-record-records

  alias {
      name                   = var.route53-properties.route53-record-dns-name
      zone_id                = var.route53-properties.route53-record-alias-zone-id
      evaluate_target_health = true
  }

}