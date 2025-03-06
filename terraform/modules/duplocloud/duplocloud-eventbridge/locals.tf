locals {
  # duplocloud eventbridge properties
  duplocloud-eventbridge-properties = {
    cloudwatch-event-rule-name                = "cloudwatch-event-rule"
    cloudwatch-event-rule-description         = "This is a cloudwatch event rule created by duplo"
    cloudwatch-event-rule-schedule-expression = "rate(10 minutes)"
    cloudwatch-event-rule-state               = "ENABLED"

    cloudwatch-event-target-arn = "arn:aws:lambda:us-west-2:294468937448:function:orphan-resource-tag"
    cloudwatch-event-target-id  = "lamda-tst1"
  }
}
