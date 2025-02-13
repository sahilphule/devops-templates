variable "ec2-properties" {
  description = "ec2 properties"
  type        = any
}

variable "vpc-id" {
  description = "vpc id"
  type        = string
}

variable "vpc-public-subnets" {
  description = "vpc public subnets"
  type        = list(any)
}
