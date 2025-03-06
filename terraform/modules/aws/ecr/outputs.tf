output "ecr-repository-url" {
  description = "ecr repository url"
  value       = aws_ecr_repository.ecr-repository[*].repository_url
}
