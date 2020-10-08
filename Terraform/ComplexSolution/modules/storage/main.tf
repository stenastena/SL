resource "azurerm_storage_account" "sta" {
  name                     = "${var.prefix}storageacct"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = "true"
  tags                     = var.tags
}

