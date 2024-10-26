resource "aws_iam_role" "eks-cluster-role" {
  assume_role_policy = data.aws_iam_policy_document.eks-cluster-assume-role-policy.json
  name               = var.eks-properties.eks-cluster-role-name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-role-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_eks_cluster" "eks-cluster" {
  name     = var.eks-properties.eks-cluster-name
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    subnet_ids = [
      for subnet in var.vpc-public-subnets : subnet.id
    ]
  }

  depends_on = [
    aws_iam_role.eks-cluster-role,
    aws_iam_role_policy_attachment.eks-cluster-role-AmazonEKSClusterPolicy
  ]
}

resource "aws_iam_role" "eks-node-role" {
  name = var.eks-properties.eks-node-role-name
  // assume_role_policy = data.aws_iam_policy_document.eks-node-assume-role-policy.json

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks-node-role-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "eks-node-role-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "eks-node-role-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-role.name
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = var.eks-properties.eks-node-group-name
  node_role_arn   = aws_iam_role.eks-node-role.arn

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = var.eks-properties.eks-instance-types
  subnet_ids = [
    for subnet in var.vpc-public-subnets : subnet.id
  ]

  depends_on = [
    aws_iam_role.eks-node-role,
    aws_iam_role_policy_attachment.eks-node-role-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-node-role-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-node-role-AmazonEC2ContainerRegistryReadOnly
  ]
}