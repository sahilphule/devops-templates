variable "ecs-properties" {
  description = "ecs properties"
  type        = any
}

variable "ecs-container-definition" {
  description = "ecs container definition"
  type        = string
}

variable "vpc-id" {
  description = "vpc id"
  type        = string
}

variable "vpc-public-subnets" {
  description = "vpc public subnets"
  type        = list(any)
}

variable "lb-security-group-id" {
  description = "load balancer security group id"
  type        = string
}

variable "lb-target-group-arn" {
  description = "target group arn"
  type        = string
}
