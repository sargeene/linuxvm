
resource "azurerm_linux_virtual_machine" "this_linux_vm" {
  name                = "${local.owner}-${local.environment}-${var.linux_vm}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  size                = "Standard_F2"
  admin_username      = var.linux_admin_user
  network_interface_ids = [
    azurerm_network_interface.this_vm_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_user_ssh_username
    public_key = file("~/.ssh/id_rsa.pub")
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
    os_profile {
    computer_name  = "myVM"
    admin_username = "azureuser"
  
  }
  os_profile_linux_config {
    disable_password_authentication = false
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file("${var.ssh_public_key_path}")
    }
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = file("${var.ssh_private_key_path}")
      host        = azurerm_public_ip.this_publicip.ip_address
    }
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-17-jdk",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt-get update",
      "sudo apt-get install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins"
    ]
  }
}
 

 /* resource "azurerm_linux_virtual_machine" "this_linux_vm" {
  name                = "${local.owner}-${local.environment}-${var.linux_vm}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  size                = "Standard_F2"
  admin_username      = var.linux_admin_user
  network_interface_ids = [
    azurerm_network_interface.this_vm_nic.id,
  ]

  admin_ssh_key {
    username   = var.linux_admin_user
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = "myVM"
    admin_username = var.linux_admin_user
  }

  os_profile_linux_config {
    disable_password_authentication = false
    ssh_keys {
      path     = "/home/${var.linux_admin_user}/.ssh/authorized_keys"
      key_data = file(var.ssh_public_key_path)
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.linux_admin_user
      private_key = file(var.ssh_private_key_path)
      host        = azurerm_public_ip.this_publicip.ip_address
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-17-jdk",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt-get update",
      "sudo apt-get install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins"
    ]
  }
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key used for connecting to the instance"
  type        = string
  default     = "${path.home}/.ssh/id_rsa"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key used for configuring the instance"
  type        = string
  default     = "${path.home}/.ssh/id_rsa.pub"
}

variable "linux_admin_user" {
  description = "Admin username for the Linux VM"
  type        = string
  default     = "azureuser"
}

variable "linux_vm" {
  description = "Name of the Linux VM"
  type        = string
  default     = "jenkins-server"
}
 */