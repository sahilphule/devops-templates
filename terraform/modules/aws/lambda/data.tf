data "aws_iam_policy_document" "lambda-assume-role-iam-policy-document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "lambda-cloudwatch-iam-policy-document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

# data "aws_iam_policy_document" "lambda-execution-iam-policy-document" {
#   statement {
#     effect    = var.lambda-properties.lambda-execution-iam-policy-documents.effect
#     actions   = var.lambda-properties.lambda-execution-iam-policy-documents.actions
#     resources = var.lambda-properties.lambda-execution-iam-policy-documents.resources
#     principals {
#       identifiers = var.lambda-properties.lambda-execution-iam-policy-documents.principal
#       type        = "Service"
#     }
#   }
# }

data "aws_iam_policy_document" "lambda-aws-service-iam-policy-document" {
  count = var.lambda-properties.lambda-aws-service-iam-policy-count

  statement {
    effect    = var.lambda-properties.lambda-aws-service-iam-policy-documents[count.index].effect
    actions   = var.lambda-properties.lambda-aws-service-iam-policy-documents[count.index].actions
    resources = var.lambda-properties.lambda-aws-service-iam-policy-documents[count.index].resources
  }
}
