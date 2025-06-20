resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_share" "this" {
  name                 = var.share_name
  storage_account_name = azurerm_storage_account.this.name
  quota                = var.quota_gb
}

output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "storage_share_name" {
  value = azurerm_storage_share.this.name
}

output "storage_account_key" {
  value     = azurerm_storage_account.this.primary_access_key
  sensitive = true
}
