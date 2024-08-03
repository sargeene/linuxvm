output "public_ip" {
  value = azurerm_public_ip.this_publicip.ip_address
}

# ssh -i ~/.ssh/azure_terraform_key Eka@51.145.36.212
# ssh-keygen -t rsa -b 4096 -f  ~/.ssh/azure_terraform_key -C "vitaliseaka@ymail.com"
# ssh -i ~/.ssh/azure_terraform_key Eka@51.145.40.248

# ssh-keygen -t rsa -b 4096 -f  ~/.ssh/azure_terraform_key -C "vitaliseaka@ymail.com"
