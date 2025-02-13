locals {
  # eip-public-ip        = module.aws_eip.eip.public_ip
  # route53-apex-zone-id = module.acm-route53.route53-apex-zone-id
  # route53-dev-zone-id  = module.acm-route53.route53-apex-zone-id
  # lb-dns-name          = module.load-balancer.load-balancer-dns-name
  # lb-zone-id           = module.load-balancer.load-balancer-zone-id

  route53-record-properties = {
    route53-ip-record-count = 0
    route53-ip-record-name  = "example.com"
    route53-ip-record-type  = "ip"
    route53-ip-record-ttl   = 300
    # route53-ip-record-records = [local.eip-public-ip]

    route53-apex-alias-record-count = 0
    route53-apex-alias-record-name  = "example.com"
    route53-apex-alias-record-type  = "A"
    # route53-apex-zone-id               = local.route53-apex-zone-id
    # route53-apex-alias-record-dns-name = local.lb-dns-name
    # route53-apex-alias-record-zone-id  = local.lb-zone-id

    route53-dev-alias-record-count = 0
    route53-dev-alias-record-name  = "dev.example.com"
    route53-dev-alias-record-type  = "NS"
    # route53-dev-zone-id               = local.route53-dev-zone-id
    # route53-dev-alias-record-dns-name = local.lb-dns-name
    # route53-dev-alias-record-zone-id  = local.lb-zone-id
  }
}
