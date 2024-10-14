variable "availability-zones" {
  description = "ap-south-1 AZs"
  type        = list(string)
}

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

// variable "ecr-repo-url" {
//   description = "ecr repo url"
//   type        = string
// }

variable "repo-url" {
  description = "docker hub repo url"
  type        = string
}

variable "ecs-properties" {
  description = "ecs properties"
  type        = map(any)
}

variable "ecs-container-definition" {
  description = "ecs container definition"
  type        = string
}
variable "target-group-arn" {
  description = "target group arn"
  type        = string
}

variable "load-balancer-sg-id" {
  description = "load balancer security group id"
  type        = string
}