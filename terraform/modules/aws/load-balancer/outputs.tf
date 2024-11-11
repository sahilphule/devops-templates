output "load-balancer-sg-id" {
  description = "load balancer security group id"
  value       = aws_security_group.load-balancer-sg.id
}

output "load-balancer-tg-arn" {
  description = "load balancer target group arn"
  value       = aws_lb_target_group.load-balancer-tg.arn
}

output "load-balancer-dns-name" {
  description = "load balancer dns name"
  value = aws_lb.load-balancer.dns_name
}