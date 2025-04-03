locals {
  # vpc properties
  vpc-properties = {
    availability-zones = [
      "ap-south-1a",
      "ap-south-1b",
      "ap-south-1c"
    ]

    vpc-cidr-block = "10.0.0.0/16"

    vpc-public-subnet-count = 1 # Two subnets necessary for load balancer, eks
    vpc-public-subnet-cidr-blocks = [
      "10.0.1.0/24",
      "10.0.2.0/24",
      "10.0.3.0/24",
      "10.0.4.0/24"
    ]
    vpc-public-subnet-map-public-ip-on-launch = true

    vpc-private-subnet-count = 0 # Two subnets necessary for rds
    vpc-private-subnet-cidr-blocks = [
      "10.0.101.0/24",
      "10.0.102.0/24",
      "10.0.103.0/24",
      "10.0.104.0/24"
    ]

    vpc-tags-Name                = "vpc"
    vpc-public-subnet-tags-Name  = "vpc-public-subnet"
    vpc-private-subnet-tags-Name = "vpc-private-subnet"
    vpc-igw-tags-Name            = "vpc-igw"
    vpc-public-rtb-tags-Name     = "vpc-public-rtb"
    vpc-private-rtb-tags-Name    = "vpc-private-rtb"
  }
}
