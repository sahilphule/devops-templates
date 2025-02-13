variable "load-balancer-properties" {
  description = "load balancer properties"
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

variable "acm-certificate-arn" {
  description = "acm certificate arn"
  type        = string
}
