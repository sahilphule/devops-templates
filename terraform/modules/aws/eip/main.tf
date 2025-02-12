resource "aws_eip" "eip" {
  instance = var.eip-properties.eip-instance-id
  domain   = var.eip-properties.eip-domain

  tags = {
    Name = var.eip-properties.eip-tags-Name
  }
}
