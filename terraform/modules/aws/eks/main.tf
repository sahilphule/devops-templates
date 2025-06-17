resource "aws_iam_role" "eks-cluster-iam-role" {
  name               = var.eks-properties.eks-cluster-iam-role-name
  assume_role_policy = data.aws_iam_policy_document.eks-cluster-iam-policy-document.json
}

resource "aws_iam_role_policy_attachment" "eks-cluster-iam-role-policy-attachment-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-iam-role.name
}

resource "aws_eks_cluster" "eks-cluster" {
  name     = var.eks-properties.eks-cluster-name
  role_arn = aws_iam_role.eks-cluster-iam-role.arn

  vpc_config {
    subnet_ids = var.vpc-public-subnets
  }

  depends_on = [
    aws_iam_role.eks-cluster-iam-role,
    aws_iam_role_policy_attachment.eks-cluster-iam-role-policy-attachment-AmazonEKSClusterPolicy
  ]
}

resource "aws_iam_role" "eks-node-group-iam-role" {
  name               = var.eks-properties.eks-node-group-iam-role-name
  assume_role_policy = data.aws_iam_policy_document.eks-node-group-iam-policy-document.json
}

resource "aws_iam_role_policy_attachment" "eks-node-group-iam-role-policy-attachment-AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.eks-node-group-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-node-group-iam-role-policy-attachment-AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.eks-node-group-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks-node-group-iam-role-policy-attachment-AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.eks-node-group-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_node_group" "eks-node-group" {
  count = var.eks-properties.eks-node-group-count

  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = var.eks-properties.eks-node-group-name[count.index]
  instance_types  = [var.eks-properties.eks-node-group-instance-types[count.index]]
  node_role_arn   = aws_iam_role.eks-node-group-iam-role.arn

  subnet_ids = var.vpc-public-subnets

  scaling_config {
    desired_size = var.eks-properties.eks-node-group-scaling-config-desired-size
    max_size     = var.eks-properties.eks-node-group-scaling-config-max-size
    min_size     = var.eks-properties.eks-node-group-scaling-config-min-size
  }

  update_config {
    max_unavailable = var.eks-properties.eks-node-group-update-config-max-unavailable
  }

  depends_on = [
    aws_iam_role.eks-node-group-iam-role,
    aws_iam_role_policy_attachment.eks-node-group-iam-role-policy-attachment-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-node-group-iam-role-policy-attachment-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-node-group-iam-role-policy-attachment-AmazonEC2ContainerRegistryReadOnly
  ]
}
