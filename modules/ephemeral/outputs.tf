output "vm_name" {
  value = azurerm_linux_virtual_machine.main.name
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.main.public_ip_address
}

output "ssh_command" {
  value = "ssh ${var.admin_username}@${azurerm_linux_virtual_machine.main.public_ip_address}"
}

output "additional_machine_pw" {
  value = var.additional_machine_count>0? var.default_admin_password : "No additional machines deployed."
}