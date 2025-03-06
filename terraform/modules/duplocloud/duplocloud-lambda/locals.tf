locals {
  # duplocloud tenant id
  duplocloud-tenant-id = module.duplocloud-tenant.duplocloud-tenant-id

  # duplocloud lambda properties
  duplocloud-lambda-properties = {
    lambda-function-name        = "lambda-function"
    lambda-function-description = "A description of my function"

    lambda-function-runtime   = "java11"
    lambda-function-handler   = "com.example.MyFunction::handleRequest"
    lambda-function-s3-bucket = "s3-bucket"
    lambda-function-s3-key    = "lambda-function.zip"

    lambda-function-environment-variables = {
      "foo" = "bar"
    }

    lambda-package-type                   = "Image"
    lambda-image-uri                      = "dkr.ecr.us-west-2.amazonaws.com/myimage:latest"
    lambda-image-config-command           = ["echo", "hello world"]
    lambda-image-config-entry-point       = ["echo hello workd"]
    lambda-image-config-working-directory = "/tmp3"

    lambda-function-timeout     = 60
    lambda-function-memory-size = 512
  }
}
