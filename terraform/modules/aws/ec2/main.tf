resource "aws_security_group" "ec2-security-group" {
  name   = var.ec2-properties.ec2-security-group-name
  vpc_id = var.vpc-id

  tags = {
    Name = var.ec2-properties.ec2-security-group-tags-Name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2-vpc-security-group-ingress-rule" {
  count = var.ec2-properties.ec2-vpc-security-group-ingress-rule-count

  from_port         = var.ec2-properties.ec2-vpc-security-group-ingress-from-port[count.index]
  to_port           = var.ec2-properties.ec2-vpc-security-group-ingress-to-port[count.index]
  ip_protocol       = var.ec2-properties.ec2-vpc-security-group-ingress-protocol[count.index]
  cidr_ipv4         = var.ec2-properties.ec2-vpc-security-group-ingress-cidr-blocks[count.index]
  security_group_id = aws_security_group.ec2-security-group.id
}

resource "aws_vpc_security_group_egress_rule" "ec2-ipv4-vpc-security-group-egress-rule" {
  ip_protocol       = var.ec2-properties.ec2-ipv4-vpc-security-group-egress-protocol
  cidr_ipv4         = var.ec2-properties.ec2-ipv4-vpc-security-group-egress-cidr-blocks
  security_group_id = aws_security_group.ec2-security-group.id
}

resource "aws_vpc_security_group_egress_rule" "ec2-ipv6-vpc-security-group-egress-rule" {
  ip_protocol       = var.ec2-properties.ec2-ipv6-vpc-security-group-egress-protocol
  cidr_ipv6         = var.ec2-properties.ec2-ipv6-vpc-security-group-egress-cidr-blocks
  security_group_id = aws_security_group.ec2-security-group.id
}

resource "aws_key_pair" "ec2-key-pair" {
  count      = var.ec2-properties.ec2-key-pair-count == 1 ? 1 : 0
  key_name   = var.ec2-properties.ec2-key-pair-name
  public_key = file(var.ec2-properties.ec2-public-key)
}

resource "aws_instance" "ec2-instance" {
  ami                         = data.aws_ami.ec2-ami.id
  instance_type               = var.ec2-properties.ec2-instance-type
  key_name                    = var.ec2-properties.ec2-key-pair-count == 1 ? aws_key_pair.ec2-key-pair[0].id : var.ec2-properties.ec2-key-pair-name
  user_data                   = file(var.ec2-properties.ec2-instance-user-data)
  associate_public_ip_address = var.ec2-properties.ec2-instance-associate-public-ip-address
  subnet_id                   = var.vpc-public-subnets[0]

  root_block_device {
    volume_size = var.ec2-properties.ec2-instance-root-block-device-volume-size
    volume_type = var.ec2-properties.ec2-instance-root-block-device-volume-type
  }

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
