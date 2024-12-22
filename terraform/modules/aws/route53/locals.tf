locals {
#   eip-lb-public-ip = module.aws_eip.lb.public_ip
#   load-balancer-dns-name = module.load-balancer.load-balancer-dns-name
#   load-balancer-zone-id = module.load-balancer.load-balancer-zone-id

  # route53 properties
  route53-properties = {
    route53-zone-name = "test.example.com"

    route53-record-name = "www.example.com"
    route53-record-type = "A/CNAME"
    route53-record-ttl = 300
    # route53-record-records = ["${locals.eip-lb-public-ip}"]
  
    # route53-record-dns-name = "${locals.load-balancer-dns-name}"
    # route53-record-alias-zone-id = "${locals.load-balancer-zone-id}"
  }
}