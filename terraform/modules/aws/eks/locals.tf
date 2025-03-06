locals {
  # vpc-public-subnets = module.vpc.vpc-public-subnets

  # eks properties
  eks-properties = {
    eks-cluster-iam-role-name = "eks-cluster-role"
    eks-cluster-name          = "eks-cluster"

    eks-node-group-role-name = "eks-node-group-role"

    eks-node-group-count                         = 1
    eks-node-group-name                          = ["eks-node-group"]
    eks-instance-types                           = ["t2.medium"]
    eks-node-group-scaling-config-desired-size   = 1
    eks-node-group-scaling-config-max-size       = 1
    eks-node-group-scaling-config-min-size       = 1
    eks-node-group-update-config-max-unavailable = 1
  }
}
