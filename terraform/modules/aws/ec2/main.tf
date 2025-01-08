resource "aws_security_group" "security-group" {
  name        = "ec2-instance-sg"
  vpc_id      = var.vpc-id

  tags = {
    Name = var.ec2-properties.ec2-instance-sg-tag-value
  }
}

resource "aws_vpc_security_group_ingress_rule" "sg-ingress-ssh-rule" {
  security_group_id = aws_security_group.security-group.id
  cidr_ipv4         = var.ec2-properties.ec2-instance-sg-ingress-ssh-cidr-blocks
  from_port         = var.ec2-properties.ec2-instance-sg-ingress-ssh-from-port
  ip_protocol       = var.ec2-properties.ec2-instance-sg-ingress-ssh-protocol
  to_port           = var.ec2-properties.ec2-instance-sg-ingress-ssh-to-port
}

resource "aws_vpc_security_group_ingress_rule" "sg-ingress-http-rule" {
  security_group_id = aws_security_group.security-group.id
  cidr_ipv4         = var.ec2-properties.ec2-instance-sg-ingress-http-cidr-blocks
  from_port         = var.ec2-properties.ec2-instance-sg-ingress-http-from-port
  ip_protocol       = var.ec2-properties.ec2-instance-sg-ingress-http-protocol
  to_port           = var.ec2-properties.ec2-instance-sg-ingress-http-to-port
}

resource "aws_vpc_security_group_ingress_rule" "sg-ingress-https-rule" {
  security_group_id = aws_security_group.security-group.id
  cidr_ipv4         = var.ec2-properties.ec2-instance-sg-ingress-https-cidr-blocks
  from_port         = var.ec2-properties.ec2-instance-sg-ingress-https-from-port
  ip_protocol       = var.ec2-properties.ec2-instance-sg-ingress-https-protocol
  to_port           = var.ec2-properties.ec2-instance-sg-ingress-https-to-port
}

resource "aws_vpc_security_group_egress_rule" "sg-egress-ipv4-rule" {
  security_group_id = aws_security_group.security-group.id
  cidr_ipv4         = var.ec2-properties.ec2-instance-sg-egress-ipv4-cidr-blocks
  ip_protocol       = var.ec2-properties.ec2-instance-sg-egress-ipv4-protocol
}

resource "aws_vpc_security_group_egress_rule" "sg-egress-ipv6-rule" {
  security_group_id = aws_security_group.security-group.id
  cidr_ipv6         = var.ec2-properties.ec2-instance-sg-egress-ipv6-cidr-blocks
  ip_protocol       = var.ec2-properties.ec2-instance-sg-egress-ipv6-protocol
}

resource "aws_key_pair" "ec2-instance-key-pair" {
  key_name   = var.ec2-properties.ec2-instance-key-pair-name
  public_key = file(var.ec2-properties.ec2-instance-public-key)
}

resource "aws_instance" "ec2-instance" {
  ami                         = data.aws_ami.ami.id
  instance_type               = var.ec2-properties.ec2-instance-type
  key_name                    = aws_key_pair.ec2-instance-key-pair.id
  user_data                   = file(var.ec2-properties.ec2-instance-user-data)
  associate_public_ip_address = var.ec2-properties.ec2-instance-associate-public-ip-address
  subnet_id                   = var.vpc-public-subnets[0].id

  vpc_security_group_ids = [
    aws_security_group.security-group.id
  ]

  tags = {
    Name = var.ec2-properties.ec2-instance-tag-value
  }

  depends_on = [
    aws_security_group.security-group,
    aws_key_pair.ec2-instance-key-pair
  ]
}