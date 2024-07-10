variable "rg_name" {
  description = "resourcegroup name"
  type        = string
  default     = "rg"
}
variable "owner" {
  description = "resource owner"
  type        = string
  default     = "linux"
}
variable "environment" {
  description = "resource environment"
  type        = string
  default     = "pj"
}
variable "location" {
  description = "resourcegroup location"
  type        = string
  default     = "uksouth"
}
variable "linux_vm" {
  description = "linux vm name"
  type        = string
  default     = "linuxvm"
}
variable "linux_admin_user" {
  description = "windows username"
  type        = string
  default     = "adminuser"
}
variable "admin_user_ssh_username" {
  description = "windows username"
  type        = string
  default     = "adminuser"
}
variable "vnet" {
  description = "virtual network"
  type        = string
  default     = "vnet"
}
variable "nic" {
  description = "network interface card"
  type        = string
  default     = "nic"
}
variable "public_ip" {
  description = "public ip address"
  type        = string
  default     = "public_ip"
}
variable "subnet" {
  description = "network subnet"
  type        = string
  default     = "subnet"
}
variable "ssh_public_key_path" {
  description = "Path to the SSH public key."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key."
  type        = string
  default     = "~/.ssh/id_rsa"
}
