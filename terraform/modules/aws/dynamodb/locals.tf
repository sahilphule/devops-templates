locals {
  
  # dynamodb properties
  dynamodb-properties = {
    dynamodb-table-name = ""
    dynamodb-table-billing-mode = "PROVISIONED"
    dynamodb-table-read-capacity = 20
    dynamodb-table-write-capacity = 20
    dynamodb-table-hash-key ="UserId"      # LockID
    dynamodb-table-range-key = ""

    dynamodb-table-attribute-name = "UserId"     # LockID
    dynamodb-table-attribute-type = "S"

    dynamodb-table-tags-Name = "dynamodb-table-1"
    dynamodb-table-tags-Environment = "dev"
  }
}