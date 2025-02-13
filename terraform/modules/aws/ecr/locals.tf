locals {
  # ecr properties
  ecr-properties = {
    ecr-repository-name         = "ecr"
    ecr-repository-force-delete = false

    ecr-public-repository-name          = "ecr"
    ecr-public-repository-force-destroy = false
  }
}
