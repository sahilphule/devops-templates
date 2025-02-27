output "cloudwatch-log-group-arn" {
  description = "cloudwatch log group arns"
  value       = aws_cloudwatch_log_group.cloudwatch-log-group[*].arn
}
