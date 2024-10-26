variable "database-properties" {
  description = "database properties"
  type        = map(any)
}

variable "bastion-properties" {
  description = "bastion properties"
  type        = any
}

variable "vpc-id" {
  description = "vpc id"
  type        = string
}

variable "vpc-public-subnets" {
  description = "db public subnet group ids"
  type        = list(any)
}

variable "vpc-private-subnets" {
  description = "db private subnet group id"
  type        = list(any)
}