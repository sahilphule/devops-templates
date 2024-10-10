output "load-balancer-sg-id" {
  description = "load balancer security group id"
  value       = aws_security_group.load-balancer-sg.id
}
output "target-group-arn" {
  description = "load balancer target group arn"
  value       = aws_lb_target_group.target-group.arn
}