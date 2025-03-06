output "lb-arn" {
  value = aws_lb.lb.arn
}

output "lb-target-group-arn" {
  description = "load balancer target group arn"
  value       = aws_lb_target_group.lb-target-group.arn
}

output "lb-http-listener-arn" {
  description = "load balancer http listener arn"
  value       = aws_lb_listener.lb-forward-http-listener[*].arn
}

output "lb-https-listener-arn" {
  description = "load balancer http listener arn"
  value       = aws_lb_listener.lb-https-listener[*].arn
}

output "lb-security-group-id" {
  description = "load balancer security group id"
  value       = aws_security_group.lb-security-group.id
}

output "lb-dns-name" {
  description = "load balancer dns name"
  value       = aws_lb.lb.dns_name
}

output "lb-zone-id" {
  description = "load balancer zone id"
  value       = aws_lb.lb.zone_id
}
