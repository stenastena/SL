module "storage" {
  source = "./storage"
}

provider "azurerm" {
  features {}
  version = "2.30.0"
  client_secret   = var.client_secret
  client_id       = var.client_id
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
} 

resource "azurerm_resource_group" "rg" {
  name                     = "rg${var.prefix}"
  location                 = var.location
  tags                     = var.tags
}


output "Resource_group_name" {
  value                 = azurerm_resource_group.rg.name
  description           = "The name of Resource Group."
}