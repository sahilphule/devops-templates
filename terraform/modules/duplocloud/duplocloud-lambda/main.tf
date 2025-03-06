resource "duplocloud_aws_lambda_function" "duplocloud-lambda-function" {
  tenant_id = var.duplocloud-tenant-id

  name        = var.duplocloud-lambda-properties.lambda-function-name
  description = var.duplocloud-lambda-function-properties.lambda-function-description

  runtime   = var.duplocloud-lambda-properties.lambda-function-runtime
  handler   = var.duplocloud-lambda-properties.lambda-function-handler
  s3_bucket = var.duplocloud-lambda-properties.lambda-function-s3-bucket
  s3_key    = var.duplocloud-lambda-properties.lambda-function-s3-key

  environment {
    variables = var.duplocloud-lambda-properties.lambda-function-environment-variables
  }

  package_type = var.duplocloud-lambda-properties.lambda-package-type
  image_uri    = var.duplocloud-lambda-properties.lambda-image-uri

  image_config {
    command           = var.duplocloud-lambda-properties.lambda-image-config-command
    entry_point       = var.duplocloud-lambda-properties.lambda-image-config-entry-point
    working_directory = var.duplocloud-lambda-properties.lambda-image-config-working-directory
  }

  tracing_config {
    mode = "PassThrough"
  }

  timeout     = var.duplocloud-lambda-properties.lambda-function-timeout
  memory_size = var.duplocloud-lambda-properties.lambda-function-memory-size

  tags = {
    IsEdgeDeploy = true
  }
}
