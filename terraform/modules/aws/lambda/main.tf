resource "aws_iam_role" "lambda-iam-role" {
  name               = var.lambda-properties.lambda-iam-role-name
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role-iam-policy-document.json
}

resource "aws_iam_policy" "lambda-cloudwatch-iam-policy" {
  name        = var.lambda-properties.lambda-cloudwatch-iam-policy-name
  description = var.lambda-properties.lambda-cloudwatch-iam-policy-description
  policy      = data.aws_iam_policy_document.lambda-cloudwatch-iam-policy-document.json
}

resource "aws_iam_role_policy_attachment" "lambda-cloudwatch-iam-role-policy-attachment" {
  role       = aws_iam_role.lambda-iam-role.name
  policy_arn = aws_iam_policy.lambda-cloudwatch-iam-policy.arn
}

resource "aws_iam_policy" "lambda-aws-service-iam-policy" {
  count = var.lambda-properties.lambda-aws-service-iam-policy-count

  name        = var.lambda-properties.lambda-aws-service-iam-policy-name[count.index]
  description = var.lambda-properties.lambda-aws-service-iam-policy-description[count.index]
  policy      = data.aws_iam_policy_document.lambda-aws-service-iam-policy-document[count.index].json
}

resource "aws_iam_role_policy_attachment" "lambda-aws-service-iam-role-policy-attachment" {
  count = var.lambda-properties.lambda-aws-service-iam-policy-count

  role       = aws_iam_role.lambda-iam-role.name
  policy_arn = aws_iam_policy.lambda-aws-service-iam-policy[count.index].arn
}

resource "aws_security_group" "lambda-vpc-security-group" {
  count = var.lambda-properties.lambda-vpc-config

  name        = var.lambda-properties.lambda-vpc-security-group-name
  description = var.lambda-properties.lambda-vpc-security-group-description
  vpc_id      = var.vpc-id

  egress {
    from_port   = var.lambda-properties.lambda-vpc-security-group-egress-from-port
    to_port     = var.lambda-properties.lambda-vpc-security-group-egress-to-port
    protocol    = var.lambda-properties.lambda-vpc-security-group-egress-protocol
    cidr_blocks = var.lambda-properties.lambda-vpc-security-group-egress-cidr-blocks
  }
}

resource "aws_lambda_function" "lambda-function" {
  count = var.lambda-properties.lambda-function-count

  function_name    = var.lambda-properties.lambda-function-name[count.index]
  filename         = var.lambda-properties.lambda-function-filename[count.index]
  source_code_hash = filebase64sha256(var.lambda-properties.lambda-function-filename[count.index])
  handler          = var.lambda-properties.lambda-function-handler[count.index]
  runtime          = var.lambda-properties.lambda-function-runtime[count.index]
  timeout          = var.lambda-properties.lambda-function-timeout[count.index]
  role             = aws_iam_role.lambda-iam-role.arn

  environment {
    variables = var.lambda-properties.lambda-function-environment-variables[count.index]
  }

  vpc_config {
    subnet_ids         = var.lambda-properties.lambda-vpc-config == 1 ? [var.vpc-subnet-id] : []
    security_group_ids = var.lambda-properties.lambda-vpc-config == 1 ? [aws_security_group.lambda-vpc-security-group[0].id] : []
  }
}
