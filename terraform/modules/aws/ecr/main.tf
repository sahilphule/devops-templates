resource "aws_ecr_repository" "ecr-repository" {
  count = var.ecr-properties.ecr-repository-count

  name         = var.ecr-properties.ecr-repository-name[count.index]
  force_delete = var.ecr-properties.ecr-repository-force-delete[count.index]
}

resource "aws_ecrpublic_repository" "ecr-public-repository" {
  count = var.ecr-properties.ecr-public-repository-count

  repository_name = var.ecr-properties.ecr-public-repository-name[count.index]
  force_destroy   = var.ecr-properties.ecr-public-repository-force-destroy[count.index]
}
