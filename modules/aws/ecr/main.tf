resource "aws_ecr_repository" "ecr-repository" {
  name = var.ecr-repo-name
}