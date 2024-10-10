output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "vpc-private-subnets" {
  value = aws_subnet.vpc-private-subnet
}

output "vpc-public-subnets" {
  value = aws_subnet.vpc-public-subnet
}