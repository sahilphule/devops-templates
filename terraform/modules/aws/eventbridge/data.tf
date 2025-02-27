data "aws_iam_policy_document" "eventbridge-assume-iam-role-policy-document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [
        "events.amazonaws.com",
        "scheduler.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

data "aws_iam_policy_document" "eventbridge-aws-service-iam-policy-document" {
  statement {
    effect    = var.eventbridge-properties.eventbridge-aws-service-iam-policy-documents.effect
    actions   = var.eventbridge-properties.eventbridge-aws-service-iam-policy-documents.actions
    resources = var.eventbridge-properties.eventbridge-aws-service-iam-policy-documents.resources
  }
}
