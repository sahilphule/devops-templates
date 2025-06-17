resource "aws_security_group" "lb-security-group" {
  name   = var.load-balancer-properties.lb-security-group-name
  vpc_id = var.vpc-id

  tags = {
    Name = var.load-balancer-properties.lb-security-group-tags-Name
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb-vpc-security-group-ingress-https-rule" {
  security_group_id = aws_security_group.lb-security-group.id
  cidr_ipv4         = var.load-balancer-properties.lb-vpc-security-group-ingress-https-cidr-blocks
  from_port         = var.load-balancer-properties.lb-vpc-security-group-ingress-https-from-port
  ip_protocol       = var.load-balancer-properties.lb-vpc-security-group-ingress-https-protocol
  to_port           = var.load-balancer-properties.lb-vpc-security-group-ingress-https-to-port
}

resource "aws_vpc_security_group_egress_rule" "lb-security-group-egress-ipv4-rule" {
  security_group_id = aws_security_group.lb-security-group.id
  cidr_ipv4         = var.load-balancer-properties.lb-vpc-security-group-egress-ipv4-cidr-blocks
  ip_protocol       = var.load-balancer-properties.lb-vpc-security-group-egress-ipv4-protocol
}

resource "aws_vpc_security_group_egress_rule" "lb-vpc-security-group-egress-ipv6-rule" {
  security_group_id = aws_security_group.lb-security-group.id
  cidr_ipv6         = var.load-balancer-properties.lb-vpc-security-group-egress-ipv6-cidr-blocks
  ip_protocol       = var.load-balancer-properties.lb-vpc-security-group-egress-ipv6-protocol
}


resource "aws_lb" "lb" {
  name               = var.load-balancer-properties.lb-name
  load_balancer_type = var.load-balancer-properties.lb-type
  internal           = var.load-balancer-properties.lb-internal

  security_groups = [
    aws_security_group.lb-security-group.id
  ]

  subnets = var.vpc-public-subnets
}

resource "aws_lb_target_group" "lb-target-group" {
  name        = var.load-balancer-properties.lb-target-group-name
  port        = var.load-balancer-properties.lb-target-group-port
  protocol    = var.load-balancer-properties.lb-target-group-protocol
  target_type = var.load-balancer-properties.lb-target-group-target-type
  vpc_id      = var.vpc-id
}

resource "aws_lb_listener" "lb-https-listener" {
  count = var.load-balancer-properties.lb-https-listener-count

  load_balancer_arn = aws_lb.lb.arn
  port              = var.load-balancer-properties.lb-https-listener-port
  protocol          = var.load-balancer-properties.lb-https-listener-protocol

  certificate_arn = var.load-balancer-properties.lb-https-listener-certificate-arn
  ssl_policy      = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }

  depends_on = [
    aws_lb_target_group.lb-target-group
  ]
}

resource "aws_lb_listener" "lb-forward-http-listener" {
  count = var.load-balancer-properties.lb-https-listener-count == 0 ? 1 : 0

  load_balancer_arn = aws_lb.lb.arn
  port              = var.load-balancer-properties.lb-http-listener-port
  protocol          = var.load-balancer-properties.lb-http-listener-protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }

  depends_on = [
    aws_lb_listener.lb-https-listener
  ]
}

resource "aws_lb_listener" "lb-redirect-http-listener" {
  count = var.load-balancer-properties.lb-https-listener-count

  load_balancer_arn = aws_lb.lb.arn
  port              = var.load-balancer-properties.lb-http-listener-port
  protocol          = var.load-balancer-properties.lb-http-listener-protocol

  default_action {
    type = "redirect"
    redirect {
      port        = var.load-balancer-properties.lb-https-listener-port
      protocol    = var.load-balancer-properties.lb-https-listener-protocol
      status_code = "HTTP_301"
    }
  }

  depends_on = [
    aws_lb_listener.lb-https-listener
  ]
}
