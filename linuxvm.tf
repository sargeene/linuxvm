
resource "azurerm_linux_virtual_machine" "this_linux_vm" {
  name                = "${local.owner}-${local.environment}-${var.linux_vm_name}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  size                = "Standard_F2"
  admin_username      = "Eka"
  network_interface_ids = [
    azurerm_network_interface.this_vm_nic.id,
  ]

  admin_ssh_key {
    username   = "Eka"
    public_key = file("~/.ssh/azure_terraform_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/cloud-init.yml")
}