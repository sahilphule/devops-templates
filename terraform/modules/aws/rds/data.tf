data "aws_ami" "bastion-host-ami" {
  most_recent = true
  owners      = [var.bastion-host-properties.bastion-host-ami-owners]

  filter {
    name   = "name"
    values = [var.bastion-host-properties.bastion-host-ami-value]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
