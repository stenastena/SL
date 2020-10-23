output "Resource_group_name" {
  value                 = azurerm_resource_group.rg.name
  description           = "The name of Resource Group."
}


output "sql_server_fqdn" {
  value                 = module.sqldb-network.sql_server_fqdn
  description           = ""
}

output "azure_sql-db" {
  value                 = module.sqldb-network.database_name
  description           = ""
}

output "sql_server_administrator_login" {
  value                 = module.sqldb-network.sql_server_administrator_login
  description           = ""
}

output "sql_server_administrator_login_password" {
  value                 = module.sqldb-network.sql_server_administrator_login_password
  description           = ""
}


/*
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
*/


output "vnet-name" {
  value = module.sqldb-network.vnet-name
}

output "vnet_address_space" {
  value = module.sqldb-network.vnet_address_space
}

output "subnet1" {
  value = module.sqldb-network.subnet1
}

output "subnet1_address_prefixes" {
  value = module.sqldb-network.subnet1_address_prefixes
}

/*
output "subnet2" {
  value = module.sqldb-network.subnet2
}

output "subnet2_address_prefixes" {
  value = module.sqldb-network.subnet2_address_prefixes
}
*/