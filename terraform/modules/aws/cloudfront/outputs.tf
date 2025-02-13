output "cloudfront-distribution-domain-name" {
  description = "cloudfront distribution domain name"
  value       = aws_cloudfront_distribution.cloudfront-distribution.domain_name
}

output "cloudfront-distribution-hosted-zone-id" {
  description = "cloudfront distribution hosted zone id"
  value       = aws_cloudfront_distribution.cloudfront-distribution.hosted_zone_id
}
