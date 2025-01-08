locals {
  # ec2 properties
  ec2-properties = {
    ec2-instance-ami-value = ["al2023-ami-2023.6.20241212.0-kernel-6.1-x86_64"]
    ec2-instance-owners    = ["137112412989"]

    ec2-instance-sg-ingress-ssh-cidr-blocks = "0.0.0.0/0"
    ec2-instance-sg-ingress-ssh-from-port   = 22
    ec2-instance-sg-ingress-ssh-protocol    = "tcp"
    ec2-instance-sg-ingress-ssh-to-port     = 22

    ec2-instance-sg-ingress-http-cidr-blocks = "0.0.0.0/0"
    ec2-instance-sg-ingress-http-from-port   = 80
    ec2-instance-sg-ingress-http-protocol    = "tcp"
    ec2-instance-sg-ingress-http-to-port     = 80

    ec2-instance-sg-ingress-https-cidr-blocks = "0.0.0.0/0"
    ec2-instance-sg-ingress-https-from-port   = 443
    ec2-instance-sg-ingress-https-protocol    = "tcp"
    ec2-instance-sg-ingress-https-to-port     = 443

    ec2-instance-sg-egress-ipv4-cidr-blocks = "0.0.0.0/0"
    ec2-instance-sg-egress-ipv4-protocol    = "-1"

    ec2-instance-sg-egress-ipv6-cidr-blocks = "::/0"
    ec2-instance-sg-egress-ipv6-protocol    = "-1"

    ec2-instance-sg-tag-value = "sg"

    ec2-instance-key-pair-name = "server-key"
    ec2-instance-public-key    = "~/desktop/aws/ssh-keys/server-key.pub"

    ec2-instance-type                        = "t2.micro"
    ec2-instance-user-data                   = "../../aws/linux-user-data.tpl"
    ec2-instance-associate-public-ip-address = true
    ec2-instance-tag-value                   = "server"
  }
}