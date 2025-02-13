resource "aws_security_group" "ec2-security-group" {
  name   = var.ec2-properties.ec2-security-group-name
  vpc_id = var.vpc-id

  tags = {
    Name = var.ec2-properties.ec2-security-group-tags-Name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2-vpc-security-group-ingress-ssh-rule" {
  security_group_id = aws_security_group.ec2-security-group.id
  cidr_ipv4         = var.ec2-properties.ec2-security-group-ingress-ssh-cidr-blocks
  from_port         = var.ec2-properties.ec2-security-group-ingress-ssh-from-port
  ip_protocol       = var.ec2-properties.ec2-security-group-ingress-ssh-protocol
  to_port           = var.ec2-properties.ec2-security-group-ingress-ssh-to-port
}

resource "aws_vpc_security_group_ingress_rule" "ec2-vpc-security-group-ingress-http-rule" {
  security_group_id = aws_security_group.ec2-security-group.id
  cidr_ipv4         = var.ec2-properties.ec2-security-group-ingress-http-cidr-blocks
  from_port         = var.ec2-properties.ec2-security-group-ingress-http-from-port
  ip_protocol       = var.ec2-properties.ec2-security-group-ingress-http-protocol
  to_port           = var.ec2-properties.ec2-security-group-ingress-http-to-port
}

resource "aws_vpc_security_group_ingress_rule" "ec2-vpc-security-group-ingress-https-rule" {
  security_group_id = aws_security_group.ec2-security-group.id
  cidr_ipv4         = var.ec2-properties.ec2-security-group-ingress-https-cidr-blocks
  from_port         = var.ec2-properties.ec2-security-group-ingress-https-from-port
  ip_protocol       = var.ec2-properties.ec2-security-group-ingress-https-protocol
  to_port           = var.ec2-properties.ec2-security-group-ingress-https-to-port
}

resource "aws_vpc_security_group_egress_rule" "ec2-vpc-security-group-egress-ipv4-rule" {
  security_group_id = aws_security_group.ec2-security-group.id
  cidr_ipv4         = var.ec2-properties.ec2-security-group-egress-ipv4-cidr-blocks
  ip_protocol       = var.ec2-properties.ec2-security-group-egress-ipv4-protocol
}

resource "aws_vpc_security_group_egress_rule" "ec2-vpc-security-group-egress-ipv6-rule" {
  security_group_id = aws_security_group.ec2-security-group.id
  cidr_ipv6         = var.ec2-properties.ec2-security-group-egress-ipv6-cidr-blocks
  ip_protocol       = var.ec2-properties.ec2-security-group-egress-ipv6-protocol
}

resource "aws_key_pair" "ec2-key-pair" {
  key_name   = var.ec2-properties.ec2-key-pair-name
  public_key = file(var.ec2-properties.ec2-public-key)
}

resource "aws_instance" "ec2-instance" {
  ami                         = data.aws_ami.ec2-ami.id
  instance_type               = var.ec2-properties.ec2-instance-type
  key_name                    = aws_key_pair.ec2-key-pair.id
  user_data                   = file(var.ec2-properties.ec2-instance-user-data)
  associate_public_ip_address = var.ec2-properties.ec2-instance-associate-public-ip-address
  subnet_id                   = var.vpc-public-subnets[0].id

  vpc_security_group_ids = [
    aws_security_group.ec2-security-group.id
  ]

  tags = {
    Name = var.ec2-properties.ec2-instance-tags-Name
  }

  depends_on = [
    aws_security_group.ec2-security-group,
    aws_key_pair.ec2-key-pair
  ]
}
