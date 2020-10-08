output "Resource_group_name" {
  value                 = azurerm_resource_group.rg.name
  description           = "The name of Resource Group."
}

output "sql_server_fqdn" {
  value                 = module.azure_sql_db.sql_server_fqdn
  description           = ""
}

output "sql_server_fqdn" {
  value                 = module.azure_sql_db.database_name
  description           = ""
}
