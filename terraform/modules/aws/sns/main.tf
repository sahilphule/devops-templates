resource "aws_iam_role" "sns-sms-logging-iam-role" {
  name               = var.sns-properties.sns-iam-role-name
  assume_role_policy = data.aws_iam_policy_document.sns-assume-role-iam-policy-document.json
}

resource "aws_iam_policy" "sns-cloudwatch-iam-policy" {
  name        = var.sns-properties.sns-cloudwatch-iam-policy-name
  description = var.sns-properties.sns-cloudwatch-iam-policy-description
  policy      = data.aws_iam_policy_document.sns-cloudwatch-iam-policy-document.json
}

resource "aws_iam_role_policy_attachment" "sns-cloudwatch-iam-role-policy-attachment" {
  role       = aws_iam_role.sns-sms-logging-iam-role.name
  policy_arn = aws_iam_policy.sns-cloudwatch-iam-policy.arn
}

resource "aws_sns_topic" "sns-topic" {
  name       = var.sns-properties.sns-topic-name
  fifo_topic = var.sns-properties.sns-topic-fifo
}

resource "aws_sns_topic_subscription" "sns-topic-subscription" {
  count = var.sns-properties.sns-topic-subscription-count

  topic_arn = aws_sns_topic.sns-topic.arn
  protocol  = var.sns-properties.sns-topic-subscription-protocol[count.index]
  endpoint  = var.sns-properties.sns-topic-subscription-endpoint[count.index]

  depends_on = [
    aws_sns_topic.sns-topic
  ]
}

resource "aws_sns_sms_preferences" "sns-sms-cloudwatch-logging" {
  count = aws_sns_topic_subscription.sns-topic-subscription[0].protocol == "sms" ? 1 : 0

  # default_sender_id = "sokalp.in"
  default_sms_type                      = var.sns-properties.sns-sms-cloudwatch-logging-default-sms-type
  monthly_spend_limit                   = var.sns-properties.sns-sms-cloudwatch-logging-monthly-spend-limit
  delivery_status_success_sampling_rate = var.sns-properties.sns-sms-cloudwatch-logging-delivery-status-success-sampling-rate
  delivery_status_iam_role_arn          = aws_iam_role.sns-sms-logging-iam-role.arn
}

# resource "aws_sns_platform_application" "sns-platform-application" {
#   count = var.sns-properties.sns-platform-application-count

#   name                = var.sns-properties.sns-platform-application-name[count.index]
#   platform            = var.sns-properties.sns-platform-application-platform[count.index]
#   platform_credential = var.sns-properties.sns-platform-application-platform-credential[count.index]

#   # apple_platform_team_id = ""
#   # apple_platform_bundle_id = ""
#   # platform_principal = var.sns-properties.sns-platform-application-platform == "APNS" || var.sns-properties.sns-platform-application-platform == "APNS_SANDBOX" ? var.sns-properties.sns-platform-application-platform : null
# }

# resource "aws_sns_platform_endpoint" "sns-platform-endpoint" {
#   count = var.sns-properties.sns-platform-endpoint-count

#   platform_application_arn = aws_sns_platform_application.sns-platform-application.arn
#   token                    = var.sns-properties.sns-platform-endpoint-token
# }
