module "azure_files" {
  source              = "./modules/azure_files"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vm" {
  source                  = "./modules/vm"
  vm_name                 = var.vm_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  ssh_public_key_path     = var.ssh_public_key_path
  allowed_ssh_cidr        = var.allowed_ssh_cidr
  exercism_token          = var.exercism_token
  storage_account_name    = module.azure_files.storage_account_name
  storage_account_key     = module.azure_files.storage_account_key
  share_name              = module.azure_files.storage_share_name
  subnet_id               = module.network.subnet_id
  public_ip_id            = module.network.public_ip_id
}
