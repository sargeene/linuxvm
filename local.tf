locals {
  owner       = var.owner
  environment = var.environment
  tags = {
    environment = "pj"
    project     = "linux"
  }
}