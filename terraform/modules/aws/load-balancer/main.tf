resource "aws_security_group" "load-balancer-sg" {
  name   = "load-balancer-sg"
  vpc_id = var.vpc-id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.load-balancer-properties.load-balancer-sg-tag-value
  }
}

resource "aws_lb" "load-balancer" {
  name               = var.load-balancer-properties.load-balancer-name
  load_balancer_type = var.load-balancer-properties.load-balancer-type

  security_groups = [
    aws_security_group.load-balancer-sg.id
  ]

  subnets = [
    for subnet in var.vpc-public-subnets : subnet.id
    // for subnet in var.vpc-private-subnets : subnet.id
  ]
}

resource "aws_lb_target_group" "load-balancer-tg" {
  name        = var.load-balancer-properties.load-balancer-tg-name
  port        = var.load-balancer-properties.port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc-id
}

resource "aws_lb_listener" "load-balancer-listener" {
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load-balancer-tg.arn
  }

  load_balancer_arn = aws_lb.load-balancer.arn
  port              = 80
  protocol          = "HTTP"
}