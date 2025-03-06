output "cloudwatch-log-group-arn" {
  description = "cloudwatch log group arns"
  value       = aws_cloudwatch_log_group.cloudwatch-log-group[*].arn
}

output "cloudwatch-log-group-name" {
  description = "cloudwatch log group name"
  value       = aws_cloudwatch_log_group.cloudwatch-log-group[*].name
}
