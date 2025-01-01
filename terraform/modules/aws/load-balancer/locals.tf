locals {
  # vpc-id             = module.vpc.vpc-id
  # vpc-public-subnets = module.vpc.vpc-public-subnets

  # load balancer properties
  load-balancer-properties = {

    load-balancer-sg-ingress-from-port   = 80
    load-balancer-sg-ingress-to-port     = 80
    load-balancer-sg-ingress-protocol    = "tcp"
    load-balancer-sg-ingress-cidr-blocks = ["0.0.0.0/0"]

    load-balancer-sg-egress-from-port   = 0
    load-balancer-sg-egress-to-port     = 0
    load-balancer-sg-egress-protocol    = -1
    load-balancer-sg-egress-cidr-blocks = ["0.0.0.0/0"]

    load-balancer-sg-tag-value = "load-balancer-sg"

    load-balancer-name     = "alb"
    load-balancer-type     = "application"
    load-balancer-internal = false

    load-balancer-tg-name        = "alb-tg"
    load-balancer-tg-port        = 80
    load-balancer-tg-protocol    = "HTTP"
    load-balancer-tg-target-type = "instance"

    load-balancer-listener-port     = 80
    load-balancer-listener-protocol = "HTTP"
  }
}