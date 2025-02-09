output "dynamodb-table-arn" {
  description = "dynamodb table arn"
  value       = aws_dynamodb_table.dynamodb-table.arn
}
