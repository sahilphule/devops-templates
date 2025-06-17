output "lambda-function-arn" {
  description = "lambda function arn"
  value       = aws_lambda_function.lambda-function[*].arn
}

output "lambda-vpc-security-group-id" {
  description = "lambda security group id"
  value       = aws_security_group.lambda-vpc-security-group[*].id
}
