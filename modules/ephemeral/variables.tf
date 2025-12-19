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
  default = "Standard_B2s"
}

variable "storage_account_name" {}
variable "storage_account_key" {}
variable "share_name" {}
variable "exercism_token" {
  description = "Your Exercism API token"
  sensitive   = true
}

variable "additional_machine_count" {
  type = number
  description = "number of additional machines to deploy to practice something like scp"
  default = 0
}

variable "default_admin_password" {
  type= string
  default = "Gvc87jJS1kV1XhnWrVf%"
  description = "default password for additional machines - meaningless unless you set additional machine count > 0"
}