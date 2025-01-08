output "acm-certificate-arn" {
  description = "acm certificate arn"
  value       = aws_acm_certificate.acm-certificate.arn
}

output "route53-apex-zone-id" {
  description = "route53 apex zone id"
  value       = aws_route53_zone.route53-apex-zone[0].zone_id
}

# output "route53-dev-zone-id" {
#   description = "route53 apex zone id"
#   value       = aws_route53_zone.route53-dev-zone[0].zone_id
# }