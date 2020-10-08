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

resource "azurerm_storage_account" "sta" {
  name                     = "${var.prefix}storageacct"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = "true"
  tags                     = var.tags
  
}