locals {
  # eventbridge properties
  eventbridge-properties = {
    eventbridge-iam-role-name   = "eventbridge-iam-role"
    eventbridge-iam-policy-name = "eventbridge-iam-policy"

    eventbridge-aws-service-iam-policy-name        = "eventbridge-lambda-policy"           # "eventbridge-sns-policy"
    eventbridge-aws-service-iam-policy-description = "Policy for invoking lambda function" # "Policy for publishing sns topic"
    eventbridge-aws-service-iam-policy-documents = {
      effect = "Allow",
      actions = [
        "lambda:InvokeFunction" # "sns:Publish"
      ],
      resources = ["*"]
    }

    scheduler-schedule-count               = 2
    scheduler-schedule-name                = ["morning-eventbridge-schedule", "night-eventbridge-schedule"]
    scheduler-schedule-expression-timezone = ["Asia/Kolkata", "Asia/Kolkata"]
    scheduler-schedule-expression          = ["cron(0 8 ? * * *)", "cron(0 23 ? * * *)"] # Compulsory in above timezone format
    scheduler-scheduler-target-arn         = ""                                          # local.lambda-function-arn[0], local.sns-topic-arn[0]
    scheduler-schedule-action              = ["start", "stop"]

    cloudwatch-event-rule-count               = 0
    cloudwatch-event-rule-name                = ["start-ec2-morning", "stop-ec2-nightly"]
    cloudwatch-event-rule-schedule-expression = ["cron(30 2 ? * * *)", "cron(30 17 ? * * *)"] # Compulsory in UTC Format
    cloudwatch-event-rule-target-arn          = ""                                            # local.lambda-function-arn[0], local.sns-topic-arn[0]
    cloudwatch-event-target-action            = ["start", "stop"]
  }
}
