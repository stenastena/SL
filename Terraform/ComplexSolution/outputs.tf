output "Resource_group_name" {
  value                 = azurerm_resource_group.rg.name
  description           = "The name of Resource Group."
}

output "sql_server_fqdn" {
  value                 = module.azure_sql_db.sql_server_fqdn
  description           = ""
}

output "azure_sql_db" {
  value                 = module.azure_sql_db.database_name
  description           = ""
}

output "sql_server_administrator_login" {
  value                 = module.azure_sql_db.sql_server_administrator_login
  description           = ""
}

output "sql_server_administrator_login_password" {
  value                 = module.azure_sql_db.sql_server_administrator_login_password
  description           = ""
}

output "storage_account_id" {
  value                 = module.storage.storage_account_id
  description           = ""
}

output "storage_account_primary_blob_endpoint" {
  value                 = module.storage.storage_account_primary_blob_endpoint
  description           = ""
}

output "aci-ip_address" {
  value = module.containerinstance.aci-ip_address
}

output "aci-fqdn" {
  value = module.containerinstance.aci-fqdn
}
