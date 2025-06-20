output "vm_name" {
  value = azurerm_linux_virtual_machine.main.name
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.main.public_ip_address
}

output "ssh_command" {
  value = "ssh ${var.admin_username}@${azurerm_linux_virtual_machine.main.public_ip_address}"
}
