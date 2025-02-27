resource "aws_iam_role" "eventbridge-iam-role" {
  count = var.eventbridge-properties.scheduler-schedule-count == 0 ? 0 : 1

  name               = var.eventbridge-properties.eventbridge-iam-role-name
  assume_role_policy = data.aws_iam_policy_document.eventbridge-assume-iam-role-policy-document.json
}

resource "aws_iam_policy" "eventbridge-lambda-iam-policy" {
  count = var.eventbridge-properties.scheduler-schedule-count == 0 ? 0 : 1

  name   = var.eventbridge-properties.eventbridge-iam-policy-name
  policy = data.aws_iam_policy_document.eventbridge-aws-service-iam-policy-document.json
}

resource "aws_iam_role_policy_attachment" "eventbridge-lambda-iam-role-policy-attachment" {
  count = var.eventbridge-properties.scheduler-schedule-count == 0 ? 0 : 1

  role       = aws_iam_role.eventbridge-iam-role[count.index].name
  policy_arn = aws_iam_policy.eventbridge-lambda-iam-policy[count.index].arn
}

resource "aws_scheduler_schedule" "eventbridge-scheduler-schedule" {
  count = var.eventbridge-properties.scheduler-schedule-count

  name                         = var.eventbridge-properties.scheduler-schedule-name[count.index]
  schedule_expression_timezone = var.eventbridge-properties.scheduler-schedule-expression-timezone[count.index]
  schedule_expression          = var.eventbridge-properties.scheduler-schedule-expression[count.index]

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = var.eventbridge-properties.scheduler-scheduler-target-arn
    role_arn = aws_iam_role.eventbridge-iam-role[0].arn
    input = jsonencode(
      {
        action = var.eventbridge-properties.scheduler-schedule-action[count.index]
      }
    )
  }
}

resource "aws_cloudwatch_event_rule" "eventbridge-cloudwatch-event-rule" {
  count = var.eventbridge-properties.cloudwatch-event-rule-count

  name                = var.eventbridge-properties.cloudwatch-event-rule-name[count.index]
  schedule_expression = var.eventbridge-properties.cloudwatch-event-rule-schedule-expression[count.index]
}

resource "aws_cloudwatch_event_target" "eventbridge-cloudwatch-event-target" {
  count = var.eventbridge-properties.cloudwatch-event-rule-count

  rule      = aws_cloudwatch_event_rule.eventbridge-cloudwatch-event-rule[count.index].name
  target_id = aws_cloudwatch_event_rule.eventbridge-cloudwatch-event-rule[count.index].name
  arn       = var.eventbridge-properties.cloudwatch-event-rule-target-arn

  input = jsonencode(
    {
      action = var.eventbridge-properties.cloudwatch-event-target-action[count.index]
    }
  )
}
