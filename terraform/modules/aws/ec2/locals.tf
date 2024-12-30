locals {
  ec2-properties = {
    ec2-instance-ami-value = [""]
    ec2-instance-owners = [""]

    ec2-instance-sg-ingress-from-port = ""
    ec2-instance-sg-ingress-to-port = ""
    ec2-instance-sg-ingress-protocol = ""
    ec2-instance-sg-ingress-cidr-blocks = [""]

    ec2-instance-sg-egress-from-port = "" 
    ec2-instance-sg-egress-to-port = ""
    ec2-instance-sg-egress-protocol = ""
    ec2-instance-sg-egress-cidr-blocks = [""]
  
    ec2-instance-sg-tag-value = ""

    ec2-instance-key-pair-name = ""
    ec2-instance-public-key = ""

    ec2-instance-type = ""
    ec2-instance-associate-public-ip-address = true
    ec2-instance-tag-value = ""
  }
}