locals {

  backend-access-iam-arns = ["arn:aws:iam::012345678901:user/username"]

  # dynamodb properties
  # dynamodb-table-arn = module.dynamodb.dyanamodb-table-arn

  dynamodb-properties = {
    dynamodb-table-name           = ""
    dynamodb-table-billing-mode   = "PAY_PER_REQUEST" # PROVISIONED
    dynamodb-table-read-capacity  = 20
    dynamodb-table-write-capacity = 20
    dynamodb-table-hash-key       = "UserId" # LockID
    dynamodb-table-range-key      = ""

    dynamodb-table-attribute-name = "UserId" # LockID
    dynamodb-table-attribute-type = "S"

    dynamodb-table-tags-Name        = "dynamodb-table-1"
    dynamodb-table-tags-Environment = "dev"

    dyanamodb-resource-policy-count = 1
  }

  dynamodb-resource-policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            local.backend-access-iam-arns[0]
          ]
        },
        "Action" : [
          "dynamodb:*"
        ],
        "Resource" : [
          # local.dyanamodb-table-arn
        ]
      },
      {
        "Effect" : "Deny",
        "Principal" : "*",
        "Action" : "dynamodb:*",
        "Resource" : [
          # local.dyanamodb-table-arn
        ]
        "Condition" : {
          "StringNotEquals" : {
            "aws:PrincipalArn" : [
              local.backend-access-iam-arns[0]
            ]
          }
        }
      }
    ]
  }
}
