output "vm_public_ip" {
  value = module.ephemeral.public_ip
}

output "additional_machine_pw" {
  value = module.ephemeral.additional_machine_pw
}