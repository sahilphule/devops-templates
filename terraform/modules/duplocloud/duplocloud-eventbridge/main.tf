resource "duplocloud_aws_cloudwatch_event_rule" "duplocloud-cloudwatch-event-rule" {
  tenant_id           = var.duplocloud-tenant-id
  name                = var.duplocloud-eventbridge-properties.cloudwatch-event-rule-name
  description         = var.duplocloud-eventbridge-properties.cloudwatch-event-rule-description
  schedule_expression = var.duplocloud-eventbridge-properties.cloudwatch-event-schedule-expression
  state               = var.duplocloud-eventbridge-properties.cloudwatch-event-rule-state

  #   event_pattern = jsonencode({
  #     detail-type = [
  #       "AWS Console Sign In via CloudTrail"
  #     ]
  #   })
}

resource "duplocloud_aws_cloudwatch_event_target" "duplocloud-cloudwatch-event-target" {
  tenant_id  = var.duplocloud-tenant-id
  rule_name  = duplocloud_aws_cloudwatch_event_rule.duplocloud-cloudwatch-event-rule.fullname
  target_arn = var.duplocloud-eventbridge-properties.cloudwatch-event-target-arn
  target_id  = var.duplocloud-eventbridge-properties.cloudwatch-event-target-id
}
