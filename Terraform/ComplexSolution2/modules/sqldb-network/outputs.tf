output "sql_server_fqdn" {
  value = azurerm_sql_server.sql_server.fully_qualified_domain_name
}

output "sql_server_administrator_login" {
  value = azurerm_sql_server.sql_server.administrator_login
}

output "sql_server_administrator_login_password" {
  value = azurerm_sql_server.sql_server.administrator_login_password
}

output "database_name" {
  value = azurerm_sql_database.sql_db.name
}

output "sql_server_id" {
  value = azurerm_sql_server.sql_server.id
}

output "vnet-name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "subnet1" {
  value = azurerm_subnet.subnet1.name
}

output "subnet1_address_prefixes" {
  value = azurerm_subnet.subnet1.address_prefixes
}

output "subnet1-id" {
  value = azurerm_subnet.subnet1.id
}

/*
output "subnet2" {
  value = azurerm_subnet.subnet2.name
}

output "subnet2_address_prefixes" {
  value = azurerm_subnet.subnet2.address_prefixes
}
*/