variable "vpc-id" {
  description = "vpc id"
  type        = string
}

variable "vpc-public-subnets" {
  description = "vpc public subnets"
  type        = list(any)
}

variable "vpc-private-subnets" {
  description = "vpc private subnets"
  type        = list(any)
}

variable "load-balancer-properties" {
  description = "load balancer properties"
  type        = map(any)
}