variable "vm_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "ssh_public_key_path" {}

variable "allowed_ssh_cidr" {
  description = "CIDR range allowed to SSH into the VM"
  type        = string
}
variable "admin_username" {
  default = "azureuser"
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "storage_account_name" {}
variable "storage_account_key" {}
variable "share_name" {}
variable "exercism_token" {
  description = "Your Exercism API token"
  sensitive   = true
}
