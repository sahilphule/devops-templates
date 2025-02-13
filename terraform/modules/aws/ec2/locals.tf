locals {
  # ec2 properties
  ec2-properties = {
    ec2-owners    = ["137112412989"]
    ec2-ami-value = ["al2023-ami-2023.6.20241212.0-kernel-6.1-x86_64"]

    ec2-security-group-name      = "ec2-instance-security-group"
    ec2-security-group-tags-Name = "ec2-instance-security-group"

    ec2-security-group-ingress-ssh-cidr-blocks = "0.0.0.0/0"
    ec2-security-group-ingress-ssh-from-port   = 22
    ec2-security-group-ingress-ssh-protocol    = "tcp"
    ec2-security-group-ingress-ssh-to-port     = 22

    ec2-security-group-ingress-http-cidr-blocks = "0.0.0.0/0"
    ec2-security-group-ingress-http-from-port   = 80
    ec2-security-group-ingress-http-protocol    = "tcp"
    ec2-security-group-ingress-http-to-port     = 80

    ec2-security-group-ingress-https-cidr-blocks = "0.0.0.0/0"
    ec2-security-group-ingress-https-from-port   = 443
    ec2-security-group-ingress-https-protocol    = "tcp"
    ec2-security-group-ingress-https-to-port     = 443

    ec2-security-group-egress-ipv4-cidr-blocks = "0.0.0.0/0"
    ec2-security-group-egress-ipv4-protocol    = "-1"

    ec2-security-group-egress-ipv6-cidr-blocks = "::/0"
    ec2-security-group-egress-ipv6-protocol    = "-1"

    ec2-key-pair-name = "server-key"
    ec2-public-key    = "~/desktop/aws/ssh-keys/server-key.pub"

    ec2-instance-type                        = "t2.micro"
    ec2-instance-user-data                   = "../../aws/linux-user-data.tpl"
    ec2-instance-associate-public-ip-address = true
    ec2-instance-tags-Name                   = "server"
  }
}
