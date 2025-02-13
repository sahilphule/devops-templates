output "vm-public-ip" {
  description = "virtual machine public ip"
  value       = azurerm_linux_virtual_machine.linux-virtual-machine.public_ip_address
}
