locals {
  # sns properties
  sns-properties = {
    sns-iam-role-name = "sns-iam-role"

    sns-cloudwatch-iam-policy-name        = "sns-cloudwatch-policy"
    sns-cloudwatch-iam-policy-description = "Policy to access CloudWatch Log Groups"

    sns-topic-name = "sns-topic"
    sns-topic-fifo = false

    sns-topic-subscription-count    = 1
    sns-topic-subscription-protocol = [""] # lambda, sqs, email, sms
    sns-topic-subscription-endpoint = []

    sns-sms-cloudwatch-logging-default-sms-type                      = "Transactional" # Promotional
    sns-sms-cloudwatch-logging-monthly-spend-limit                   = 1
    sns-sms-cloudwatch-logging-delivery-status-success-sampling-rate = 100

    # sns-platform-application-count               = 0
    # sns-platform-application-name                = ["platform-application"]
    # sns-platform-application-platform            = [""] # GCM, ADM, APNS/APNS_SANDBOX for development
    # sns-platform-application-platform-credential = [""] # YOUR_FCM_SERVER_KEY, YOUR_AMAZON_APP_CLIENT_SECRET, YOUR_APNS_PRIVATE_KEY
    # # sns-platform-application-platform-principal  = [""] # YOUR_APNS_CERTIFICATE

    # sns-platform-endpoint-count = 0
    # sns-platform-endpoint-token = "" # DEVICE_REGISTRATION_TOKEN
  }
}
