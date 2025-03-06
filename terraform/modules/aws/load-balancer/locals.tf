locals {
  # vpc-id              = module.vpc.vpc-id
  # vpc-public-subnets  = module.vpc.vpc-public-subnets
  # acm-certificate-arn = module.acm-route53.acm-certificate-arn

  # load balancer properties
  load-balancer-properties = {
    lb-security-group-name      = "lb-security-group"
    lb-security-group-tags-Name = "lb-security-group"

    lb-vpc-security-group-ingress-https-cidr-blocks = "0.0.0.0/0"
    lb-vpc-security-group-ingress-https-from-port   = 443 # 80, 443
    lb-vpc-security-group-ingress-https-protocol    = "tcp"
    lb-vpc-security-group-ingress-https-to-port     = 443 # 80, 443

    lb-vpc-security-group-egress-ipv4-cidr-blocks = "0.0.0.0/0"
    lb-vpc-security-group-egress-ipv4-protocol    = "-1"

    lb-vpc-security-group-egress-ipv6-cidr-blocks = "::/0"
    lb-vpc-security-group-egress-ipv6-protocol    = "-1"

    lb-name     = "lb"
    lb-type     = "application"
    lb-internal = false

    lb-target-group-name        = "lb-target-group"
    lb-target-group-port        = 80
    lb-target-group-protocol    = "HTTP"
    lb-target-group-target-type = "instance"

    lb-http-listener-port     = 80
    lb-http-listener-protocol = "HTTP"

    lb-https-listener-count    = 1
    lb-https-listener-port     = 443
    lb-https-listener-protocol = "HTTPS"
    # lb-https-listener-certificate-arn = local.acm-certificate-arn
  }

  # lb-target-group-arn = module.load-balancer.lb-target-group-arn
  # lb-dns-name         = module.load-balancer.lb-dns-name
  # lb-zone-id          = module.load-balancer.lb-zone-id
}
