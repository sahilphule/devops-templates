data "aws_iam_policy_document" "eks-cluster-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["eks.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "eks-node-assume-role-policy" {
  statement {
    actions = ["sts.AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}
