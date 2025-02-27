data "aws_iam_policy_document" "sns-assume-role-iam-policy-document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["sns.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "sns-cloudwatch-iam-policy-document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}
