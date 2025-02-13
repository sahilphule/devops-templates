locals {
  # Allowed tfstate access User arns
  backend-access-iam-arns = ["arn:aws:iam::012345678901:user/username"]

  # dynamodb properties
  # dynamodb-table-arn = module.dynamodb.dyanamodb-table-arn

  dynamodb-properties = {
    dynamodb-table-name      = "remote-backend-dynamodb-table"
    dynamodb-table-tags-Name = "remote-backend-dynamodb-table"

    dynamodb-table-billing-mode   = "PAY_PER_REQUEST" # PROVISIONED, PAY_PER_REQUEST
    dynamodb-table-read-capacity  = 20
    dynamodb-table-write-capacity = 20
    dynamodb-table-hash-key       = "LockID" # UserId, LockID
    dynamodb-table-range-key      = ""

    dynamodb-table-attribute-name = "LockID" # UserId, LockID
    dynamodb-table-attribute-type = "S"

    dyanamodb-resource-policy-count = 0
  }

  dynamodb-resource-policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "${local.backend-access-iam-arns[0]}"
          ]
        },
        "Action" : [
          "dynamodb:*"
        ],
        "Resource" : [
          # "${local.dynamodb-table-arn}"
        ]
      },
      {
        "Effect" : "Deny",
        "Principal" : "*",
        "Action" : "dynamodb:*",
        "Resource" : [
          # "${local.dynamodb-table-arn}"
        ]
        "Condition" : {
          "StringNotEquals" : {
            "aws:PrincipalArn" : [
              "${local.backend-access-iam-arns[0]}"
            ]
          }
        }
      }
    ]
  }
}
