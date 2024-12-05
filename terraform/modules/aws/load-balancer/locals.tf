locals {
  # vpc-id             = module.vpc.vpc-id
  # vpc-public-subnets = module.vpc.vpc-public-subnets

  # load balancer properties
  load-balancer-properties = {
    load-balancer-name    = "lb"
    load-balancer-type    = "application"
    load-balancer-tg-name = "lb-tg"
    port                  = "${local.ecs-properties.ecs-container-port}"

    load-balancer-sg-tag-value = "load-balancer-sg"
  }
}