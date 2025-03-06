data "aws_ami" "ec2-ami" {
  most_recent = true
  owners      = [var.ec2-properties.ec2-ami-owners]

  filter {
    name   = "name"
    values = [var.ec2-properties.ec2-ami-value]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
