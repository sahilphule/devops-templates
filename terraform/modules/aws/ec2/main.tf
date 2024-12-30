resource "aws_security_group" "ec2-instance-sg" {
  name   = "ec2-instance-sg"
  vpc_id = var.vpc-id

  ingress {
    from_port   = var.ec2-properties.ec2-instance-sg-ingress-from-port
    to_port     = var.ec2-properties.ec2-instance-sg-ingress-to-port
    protocol    = var.ec2-properties.ec2-instance-sg-ingress-protocol
    cidr_blocks = var.ec2-properties.ec2-instance-sg-ingress-cidr-blocks
  }

  egress {
    from_port   = var.ec2-properties.ec2-instance-sg-egress-from-port
    to_port     = var.ec2-properties.ec2-instance-sg-egress-to-port
    protocol    = var.ec2-properties.ec2-instance-sg-egress-protocol
    cidr_blocks = var.ec2-properties.ec2-instance-sg-egress-cidr-blocks
  }

  tags = {
    Name = var.ec2-properties.ec2-instance-sg-tag-value
  }
}

resource "aws_key_pair" "ec2-instance-key-pair" {
  key_name   = var.ec2-properties.ec2-instance-key-pair-name
  public_key = file(var.ec2-properties.ec2-instance-public-key)
}


resource "aws_instance" "ec2-instance" {
  ami                         = data.aws_ami.ami.id
  instance_type               = var.ec2-properties.ec2-instance-type
  key_name                    = aws_key_pair.ec2-instance-key-pair.id
  user_data                   = var.ec2-properties.ec2-instance-user-data
  associate_public_ip_address = var.ec2-properties.ec2-instance-associate-public-ip-address
  subnet_id                   = var.vpc-public-subnets[0].id

  vpc_security_group_ids = [
    aws_security_group.ec2-instance-sg.id
  ]

  tags = {
    Name = var.ec2-properties.ec2-instance-tag-value
  }
}