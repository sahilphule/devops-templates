output "DB_HOST" {
  description = "mysql host address"
  value       = azurerm_mysql_flexible_server.mysql-flexible-server.fqdn
}
