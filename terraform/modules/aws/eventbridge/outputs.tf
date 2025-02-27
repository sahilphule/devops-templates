output "cloudwatch-event-rule-arns" {
  description = "cloudwatch event rule arns"
  value       = aws_cloudwatch_event_rule.eventbridge-cloudwatch-event-rule[*].arn
}
