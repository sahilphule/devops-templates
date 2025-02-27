locals {
  # cloudwatch properties
  cloudwatch-properties = {
    cloudwatch-log-group-count = 1

    cloudwatch-log-group-name              = ["/aws/<aws-service>/<aws-service-name>"]
    cloudwatch-log-group-retention-in-days = [14]
  }
}
