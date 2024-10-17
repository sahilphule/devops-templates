output "DB_HOST" {
  description = "rds db host address"
  value       = aws_db_instance.db.address
}

output "bastion-host-ip" {
  description = "bastion host ip address"
  value       = aws_instance.bastion-host.public_ip
}