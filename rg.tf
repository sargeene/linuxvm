resource "azurerm_resource_group" "this_rg" {
  name     = "${local.owner}-${local.environment}-${var.rg}"
  location = "uksouth"
}
