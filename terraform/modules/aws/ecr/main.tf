resource "aws_ecr_repository" "ecr-repository" {
  name         = var.ecr-properties.ecr-repository-name
  force_delete = var.ecr-properties.ecr-repository-force-delete
}

# resource "aws_ecrpublic_repository" "ecr-public-repository" {
#   repository_name = var.ecr-properties.ecr-public-repository-name
#   force_destroy = var.ecr-properties.ecr-public-repository-force-destroy
# }