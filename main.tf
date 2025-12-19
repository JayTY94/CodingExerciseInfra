provider "azurerm" {
  features {}
  use_msi          = false
  # This tells it to use your `az login` credentials
  use_cli = true
  subscription_id = "85f176c2-7103-40b1-ab54-5ffa8ee0f1dd"
}



module "azure_files" {
  source              = "./modules/azure_files"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "ephemeral" {
  source                  = "./modules/ephemeral"
  vm_name                 = var.vm_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  ssh_public_key_path     = var.ssh_public_key_path
  allowed_ssh_cidr        = var.allowed_ssh_cidr
  exercism_token          = var.exercism_token
  storage_account_name    = module.azure_files.storage_account_name
  storage_account_key     = module.azure_files.storage_account_key
  share_name              = module.azure_files.storage_share_name
}

# module "ephemeral2" {
#   source                  = "./modules/ephemeral"
#   vm_name                 = "scp-target-vm"
#   location                = var.location
#   resource_group_name     = var.resource_group_name
#   ssh_public_key_path     = var.ssh_public_key_path
#   allowed_ssh_cidr        = var.allowed_ssh_cidr
#   exercism_token          = var.exercism_token
#   storage_account_name    = module.azure_files.storage_account_name
#   storage_account_key     = module.azure_files.storage_account_key
#   share_name              = module.azure_files.storage_share_name
# }

