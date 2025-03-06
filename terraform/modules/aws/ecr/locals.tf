locals {
  # ecr properties
  ecr-properties = {
    ecr-repository-count        = 1
    ecr-repository-name         = ["ecr"]
    ecr-repository-force-delete = [false]

    ecr-public-repository-count         = 0
    ecr-public-repository-name          = ["ecr"]
    ecr-public-repository-force-destroy = [false]
  }
}
