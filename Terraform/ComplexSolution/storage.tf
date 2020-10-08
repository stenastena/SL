resource "azurerm_storage_account" "sta" {
  name                     = "${var.prefix}storageacct"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = "true"
  tags                     = var.tags
}

output "Resource_group_name" {
  value                 = azurerm_resource_group.rg.name
  description           = "The name of Resource Group."
}