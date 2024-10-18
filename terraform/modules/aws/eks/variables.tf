variable "vpc-public-subnets" {
  description = "vpc public subnets"
  type        = list(any)
}

variable "vpc-private-subnets" {
  description = "vpc private subnets"
  type        = list(any)
}

variable "eks-properties" {
  description = "eks properties"
  type        = any
}