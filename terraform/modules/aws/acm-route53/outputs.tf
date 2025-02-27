output "acm-certificate-arn" {
  description = "acm certificate arn"
  value       = aws_acm_certificate.acm-certificate.arn
}

output "route53-apex-zone-id" {
  description = "route53 apex zone id"
  value       = aws_route53_zone.route53-apex-zone[*].zone_id
}

output "route53-dev-zone-id" {
  description = "route53 dev zone id"
  value       = aws_route53_zone.route53-dev-zone[*].zone_id
}
