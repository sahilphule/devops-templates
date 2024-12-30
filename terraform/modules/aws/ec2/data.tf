data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = var.ec2-properties.ec2-instance-ami-value
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.ec2-properties.ec2-instance-owners
}