locals {
  #   eip-lb-public-ip = module.aws_eip.lb.public_ip
  #   load-balancer-dns-name = module.load-balancer.load-balancer-dns-name
  #   load-balancer-zone-id = module.load-balancer.load-balancer-zone-id

  # route53 properties
  route53-properties = {
    route53-zone-name = ""

    route53-record-name = ""
    route53-record-type = "A"
    route53-record-ttl  = 60
    # route53-record-records         = ["${local.eip}"]
    route53-record-allow-overwrite = false

    # route53-record-alias-dns-name = "${local.load-balancer-dns-name}"
    # route53-record-alias-zone-id  = "${local.load-balancer-zone-id}"
  }
}