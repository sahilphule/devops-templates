locals {
  #   eip-lb-public-ip = module.aws_eip.lb.public_ip
  #   load-balancer-dns-name = module.load-balancer.load-balancer-dns-name
  #   load-balancer-zone-id = module.load-balancer.load-balancer-zone-id

  route53-record-properties = {
    # route53-ip-record-name = "example.com"
    # route53-ip-record-type = "ip"
    # route53-ip-record-ttl = 300
    # route53-ip-record-records = ["${local.eip}"]

    route53-alias-record-name     = "example.com"
    route53-alias-record-type     = "A"
    route53-alias-record-dns-name = ""
    route53-alias-record-zone-id  = ""
  }
}