resource "azurerm_linux_virtual_machine" "additional" {
  count = var.additional_machine_count
  name                = "additional-machine-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password = var.default_admin_password

  network_interface_ids = [
    "${azurerm_network_interface.additional.*.id[count.index]}"
  ]


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

  computer_name = "additional-machine-${count.index}"


#   Mount and provision via cloud-init
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

resource "azurerm_network_interface" "additional" {
  count = var.additional_machine_count
  name                = "additional-machine-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig-additional"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}