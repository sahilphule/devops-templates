output "lambda-function-arn" {
  description = "lambda function arn"
  value       = aws_lambda_function.lambda-function[*].arn
}
