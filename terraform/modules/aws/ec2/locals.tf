locals {
  # ec2 properties
  ec2-properties = {
    ec2-instance-ami-value = [""]
    ec2-instance-owners    = [""]

    ec2-instance-sg-ingress-from-port   = 0
    ec2-instance-sg-ingress-to-port     = 0
    ec2-instance-sg-ingress-protocol    = -1
    ec2-instance-sg-ingress-cidr-blocks = ["0.0.0.0/0"]

    ec2-instance-sg-egress-from-port   = 0
    ec2-instance-sg-egress-to-port     = 0
    ec2-instance-sg-egress-protocol    = -1
    ec2-instance-sg-egress-cidr-blocks = ["0.0.0.0/0"]

    ec2-instance-sg-tag-value = "sg"

    ec2-instance-key-pair-name = "key"
    ec2-instance-public-key    = ""

    ec2-instance-type                        = "t2.micro"
    ec2-instance-user-data                   = ""
    ec2-instance-associate-public-ip-address = true
    ec2-instance-tag-value                   = ""
  }
}