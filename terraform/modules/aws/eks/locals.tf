locals {
  # vpc-public-subnets = module.vpc.vpc-public-subnets

  # eks properties
  eks-properties = {
    eks-cluster-role-name = "eks-cluster-role"
    eks-cluster-name      = "eks-cluster"
    eks-node-role-name    = "eks-node-group-role"
    eks-node-group-name   = "eks-node-group"
    eks-instance-types = [
      "t2.medium"
    ]
  }
}
