variable "eks-properties" {
  description = "eks properties"
  type        = any
}

variable "vpc-public-subnets" {
  description = "vpc public subnets"
  type        = list(any)
}
