locals {
  # ec2 properties
  ec2-properties = {
    ec2-ami-owners = "137112412989"
    ec2-ami-value  = "al2023-ami-2023.6.20241212.0-kernel-6.1-x86_64"

    ec2-security-group-name      = "ec2-instance-security-group"
    ec2-security-group-tags-Name = "ec2-instance-security-group"

    ec2-vpc-security-group-ingress-rule-count  = 3
    ec2-vpc-security-group-ingress-from-port   = [22, 80, 443] # 0
    ec2-vpc-security-group-ingress-to-port     = [22, 80, 443] # 65535
    ec2-vpc-security-group-ingress-protocol    = ["tcp", "tcp", "tcp"]
    ec2-vpc-security-group-ingress-cidr-blocks = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]

    ec2-ipv4-vpc-security-group-egress-cidr-blocks = "0.0.0.0/0"
    ec2-ipv4-vpc-security-group-egress-protocol    = "-1"

    ec2-ipv6-vpc-security-group-egress-cidr-blocks = "::/0"
    ec2-ipv6-vpc-security-group-egress-protocol    = "-1"

    ec2-key-pair-count = 1
    ec2-key-pair-name  = "ec2-instance-ssh-key-pair"
    ec2-public-key     = "~/desktop/aws/ssh-keys/ec2-instance-ssh-key-pair.pub"

    ec2-instance-type                          = "t2.micro"
    ec2-instance-user-data                     = "./aws/linux-user-data.tpl"
    ec2-instance-associate-public-ip-address   = true
    ec2-instance-root-block-device-volume-size = 8
    ec2-instance-root-block-device-volume-type = "gp3"
    ec2-instance-tags-Name                     = "ec2-instance"
  }
}
