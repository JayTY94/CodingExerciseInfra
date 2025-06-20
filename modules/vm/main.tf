locals {
  creation_date     = formatdate("YYYYMMDD", timestamp())
  vm_name_with_date = "${var.vm_name}-${local.creation_date}"
}

resource "azurerm_network_interface" "main" {
  name                = "nic-${local.vm_name_with_date}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = local.vm_name_with_date
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  disable_password_authentication = true
  computer_name                   = local.vm_name_with_date

  # Mount and provision via cloud-init
  custom_data = base64encode(templatefile("${path.module}/cloud-init.yaml.tpl", {
    storage_account_name = var.storage_account_name
    storage_account_key  = var.storage_account_key
    share_name           = var.share_name
    exercism_token       = var.exercism_token
  }))

  tags = {
    environment = "exercism"
    created     = local.creation_date
  }
}
