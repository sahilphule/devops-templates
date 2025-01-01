resource "aws_security_group" "load-balancer-sg" {
  name   = "load-balancer-sg"
  vpc_id = var.vpc-id

  ingress {
    from_port   = var.load-balancer-properties.load-balancer-sg-ingress-from-port
    to_port     = var.load-balancer-properties.load-balancer-sg-ingress-to-port
    protocol    = var.load-balancer-properties.load-balancer-sg-ingress-protocol
    cidr_blocks = var.load-balancer-properties.load-balancer-sg-ingress-cidr-blocks
  }

  egress {
    from_port   = var.load-balancer-properties.load-balancer-sg-egress-from-port
    to_port     = var.load-balancer-properties.load-balancer-sg-egress-to-port
    protocol    = var.load-balancer-properties.load-balancer-sg-egress-protocol
    cidr_blocks = var.load-balancer-properties.load-balancer-sg-egress-cidr-blocks
  }

  tags = {
    Name = var.load-balancer-properties.load-balancer-sg-tag-value
  }
}

resource "aws_lb" "load-balancer" {
  name               = var.load-balancer-properties.load-balancer-name
  load_balancer_type = var.load-balancer-properties.load-balancer-type
  internal           = var.load-balancer-properties.load-balancer-internal

  security_groups = [
    aws_security_group.load-balancer-sg.id
  ]

  subnets = [
    for subnet in var.vpc-public-subnets : subnet.id
  ]
}

resource "aws_lb_target_group" "load-balancer-tg" {
  name        = var.load-balancer-properties.load-balancer-tg-name
  port        = var.load-balancer-properties.load-balancer-tg-port
  protocol    = var.load-balancer-properties.load-balancer-tg-protocol
  target_type = var.load-balancer-properties.load-balancer-tg-target-type
  vpc_id      = var.vpc-id
}

resource "aws_lb_listener" "load-balancer-listener" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = var.load-balancer-properties.load-balancer-listener-port
  protocol          = var.load-balancer-properties.load-balancer-listener-protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load-balancer-tg.arn
  }
}