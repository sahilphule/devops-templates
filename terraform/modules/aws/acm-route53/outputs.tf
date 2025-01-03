output "acm-certificate-arn" {
  description = "acm certificate arn"
  value       = aws_acm_certificate.acm-certificate.arn
}

output "route53-zone-id" {
  description = "route53 zone id"
  value       = aws_route53_zone.route53-zone.zone_id
}