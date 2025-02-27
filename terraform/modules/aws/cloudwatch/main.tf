resource "aws_cloudwatch_log_group" "cloudwatch-log-group" {
  count = var.cloudwatch-properties.cloudwatch-log-group-count

  name              = var.cloudwatch-properties.cloudwatch-log-group-name[count.index]
  retention_in_days = var.cloudwatch-properties.cloudwatch-log-group-retention-in-days[count.index]
}
