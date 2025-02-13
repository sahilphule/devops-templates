resource "aws_dynamodb_table" "dynamodb-table" {
  name         = var.dynamodb-properties.dynamodb-table-name
  billing_mode = var.dynamodb-properties.dynamodb-table-billing-mode

  # read_capacity  = var.dynamodb-properties.dynamodb-table-read-capacity
  # write_capacity = var.dynamodb-properties.dynamodb-table-write-capacity

  hash_key = var.dynamodb-properties.dynamodb-table-hash-key
  #   range_key      = var.dynamodb-properties.dynamodb-table-range-key

  attribute {
    name = var.dynamodb-properties.dynamodb-table-attribute-name
    type = var.dynamodb-properties.dynamodb-table-attribute-type
  }

  tags = {
    Name = var.dynamodb-properties.dynamodb-table-tags-Name
  }
}

resource "aws_dynamodb_resource_policy" "dynamodb-resource-policy" {
  count = var.dynamodb-properties.dyanamodb-resource-policy-count

  resource_arn = aws_dynamodb_table.dynamodb-table.arn
  policy       = jsonencode(var.dynamodb-resource-policy)

  depends_on = [
    aws_dynamodb_table.dynamodb-table
  ]
}
