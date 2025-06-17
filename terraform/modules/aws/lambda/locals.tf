locals {
  # lambda properties
  lambda-properties = {
    lambda-iam-role-name = "lambda-iam-role"

    # lambda-execution-iam-policy-name        = "" # lambda-execution-events-policy, lambda-execution-sns-policy
    # lambda-execution-iam-policy-description = "" # Policy for Eventbridge Lambda Funtion execution, Policy for SNS Lambda Function execution
    # lambda-execution-iam-policy-documents = {
    #   effect = "Allow",
    #   actions = [
    #     "lambda:InvokeFunction"
    #   ],
    #   resources = [
    #     # aws_lambda_function.my_lambda.arn,
    #     "*"
    #   ]
    #   principal = [
    #     "" # events.amazonaws.com sns.amazonaws.com
    #   ]
    # }

    lambda-cloudwatch-iam-policy-name        = "lambda-cloudwatch-policy"
    lambda-cloudwatch-iam-policy-description = "Policy to access CloudWatch Log Groups"

    lambda-aws-service-iam-policy-count       = 2
    lambda-aws-service-iam-policy-name        = ["lambda-ec2-policy", "lambda-ecs-policy"]
    lambda-aws-service-iam-policy-description = ["Policy for EC2 instance scaling", "Policy for ECS service scaling"]
    lambda-aws-service-iam-policy-documents = [
      {
        effect = "Allow",
        actions = [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:DescribeInstances"
        ],
        resources = ["*"]
      },
      {
        effect = "Allow",
        actions = [
          "ecs:UpdateService",
          "ecs:DescribeServices"
        ],
        resources = ["*"]
      }
    ]

    lambda-vpc-config                            = 0
    lambda-vpc-security-group-name               = "lambda-security-group"
    lambda-vpc-security-group-description        = "lambda security group"
    lambda-vpc-security-group-egress-from-port   = 0
    lambda-vpc-security-group-egress-to-port     = 0
    lambda-vpc-security-group-egress-protocol    = "-1"
    lambda-vpc-security-group-egress-cidr-blocks = ["0.0.0.0/0"]

    lambda-function-count    = 1
    lambda-function-name     = ["ec2-lambda-function", "ecs-lambda-function"]
    lambda-function-filename = ["./lambda-functions/ec2-lambda-function.zip", "./lambda-function/ecs-lambda-function.zip"]
    lambda-function-handler  = ["ec2-lambda-function.lambda_handler", "ecs-lambda-function.lambda_handler"]
    lambda-function-runtime  = ["python3.13", "python3.13"]
    lambda-function-timeout  = [30, 30]

    lambda-function-environment-variables = [
      {
        CLUSTER_NAME       = "dev"
        DEFAULT_TASK_COUNT = "1"
      }
    ]
  }
}
