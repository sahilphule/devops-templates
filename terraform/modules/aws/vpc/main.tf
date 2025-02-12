resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-properties.vpc-cidr-block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc-properties.vpc-tags-Name
  }
}

resource "aws_subnet" "vpc-public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.vpc-properties.vpc-subnet-count.public
  cidr_block              = var.vpc-properties.vpc-public-subnet-cidr-blocks[count.index]
  availability_zone       = var.vpc-properties.availability-zones[count.index]
  map_public_ip_on_launch = var.vpc-properties.vpc-public-subnet-map-public-ip-on-launch

  tags = {
    Name = var.vpc-properties.vpc-public-subnet-tags-Name
  }
}

resource "aws_subnet" "vpc-private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = var.vpc-properties.vpc-subnet-count.private
  cidr_block        = var.vpc-properties.vpc-private-subnet-cidr-blocks[count.index]
  availability_zone = var.vpc-properties.availability-zones[count.index]

  tags = {
    Name = var.vpc-properties.vpc-private-subnet-tags-Name
  }
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.vpc-properties.vpc-igw-tags-Name
  }
}

resource "aws_route_table" "vpc-public-rtb" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "default-route" {
  route_table_id         = aws_route_table.vpc-public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-igw.id
}

resource "aws_route_table_association" "public-rtb-assoc" {
  route_table_id = aws_route_table.vpc-public-rtb.id
  count          = var.vpc-properties.vpc-subnet-count.public
  subnet_id      = aws_subnet.vpc-public-subnet[count.index].id
}

resource "aws_route_table" "vpc-private-rtb" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "private-rtb-assoc" {
  route_table_id = aws_route_table.vpc-private-rtb.id
  count          = var.vpc-properties.vpc-subnet-count.private
  subnet_id      = aws_subnet.vpc-private-subnet[count.index].id
}
