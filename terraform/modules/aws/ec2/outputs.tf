output "ec2-instance-id" {
  description = "ec2 instance id"
  value       = aws_instance.ec2-instance.id
}

output "ec2-instance-public-ip" {
  description = "ec2 instance public ip"
  value       = aws_instance.ec2-instance.public_ip
}

output "ec2-security-group-id" {
  description = "ec2 security group id"
  value       = aws_security_group.ec2-security-group.id
}
