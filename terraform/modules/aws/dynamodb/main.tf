resource "aws_dynamodb_table" "dynamodb-table" {
  name           = var.dynamodb-properties.dynamodb-table-name
  billing_mode   = var.dynamodb-properties.dynamodb-table-billing-mode
  read_capacity  = var.dynamodb-properties.dynamodb-table-read-capacity
  write_capacity = var.dynamodb-properties.dynamodb-table-write-capacity
  hash_key       = var.dynamodb-properties.dynamodb-table-hash-key
#   range_key      = var.dynamodb-properties.dynamodb-table-range-key

  attribute {
    name = var.dynamodb-properties.dynamodb-table-attribute-name
    type = var.dynamodb-properties.dynamodb-table-attribute-type
  }

#   ttl {
#     attribute_name = "TimeToExist"
#     enabled        = true
#   }

#   global_secondary_index {
#     name               = "GameTitleIndex"
#     hash_key           = "GameTitle"
#     range_key          = "TopScore"
#     write_capacity     = 10
#     read_capacity      = 10
#     projection_type    = "INCLUDE"
#     non_key_attributes = ["UserId"]
#   }

  tags = {
    Name        = var.dynamodb-properties.dynamodb-table-tags-Name
    Environment = var.dynamodb-properties.dynamodb-table-tags-Environment
  }
}