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


