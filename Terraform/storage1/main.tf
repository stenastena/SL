provider "azurerm" {
  features {}
  version = "2.30.0"
} 

resource "azurerm_resource_group" "example" {
  name                     = "rg${var.prefix}"
  location                 = var.location
  tags                     = var.tags
}

resource "azurerm_storage_account" "example" {
  name                     = "${var.prefix}storageacct"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = "true"
  tags                     = var.tags
  
}

resource "azurerm_storage_container" "example" {
  name                  = "${var.prefix}-sample-container"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "container"
  
}

resource "azurerm_storage_blob" "example" {
  name                   = "SampleImageJMiro.jpg"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "SampleImageJMiro.jpg"
  
}