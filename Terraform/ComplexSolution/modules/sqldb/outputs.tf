output "sql_server_fqdn" {
  value = azurerm_sql_server.sql_server.fully_qualified_domain_name
}

output "database_name" {
  value = azurerm_sql_database.sql_db.name
}
