output "load-balancer-arn" {
  value = aws_lb.load-balancer.arn
}

output "load-balancer-tg-arn" {
  description = "load balancer target group arn"
  value       = aws_lb_target_group.load-balancer-tg.arn
}

output "load-balancer-http-listener-arn" {
  description = "load balancer http listener arn"
  value       = aws_lb_listener.load-balancer-http-listener.arn
}

output "load-balancer-https-listener-arn" {
  description = "load balancer http listener arn"
  value       = aws_lb_listener.load-balancer-https-listener.arn
}

output "load-balancer-sg-id" {
  description = "load balancer security group id"
  value       = aws_security_group.load-balancer-sg.id
}

output "load-balancer-dns-name" {
  description = "load balancer dns name"
  value       = aws_lb.load-balancer.dns_name
}

output "load-balancer-zone-id" {
  description = "load balancer zone id"
  value       = aws_lb.load-balancer.zone_id
}