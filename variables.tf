variable "vm_name" {
  default = "exercism-vm"
}
variable "location" {
  default = "westus"
}
variable "resource_group_name" {
  default = "exercism-rg"
}
variable "ssh_public_key_path" {}
variable "allowed_ssh_cidr" {}
variable "exercism_token" {
  sensitive = true
}
