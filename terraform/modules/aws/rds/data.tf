data "aws_ami" "rds-ami" {
  most_recent = true
  owners      = var.rds-properties.rds-owners

  filter {
    name   = "name"
    values = var.rds-properties.rds-ami-value
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
