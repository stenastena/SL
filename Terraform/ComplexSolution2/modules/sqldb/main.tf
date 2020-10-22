resource "azurerm_sql_server" "sql_server" {
  name                         = "${var.prefix}-sqlsvr"
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
  tags                         = var.tags
}

resource "azurerm_sql_database" "sql_db" {
  name                             = "${var.prefix}-db"
  resource_group_name              = var.rg_name
  location                         = var.location
  server_name                      = azurerm_sql_server.sql_server.name
  edition                          = "Basic"
  collation                        = "SQL_Latin1_General_CP1_CI_AS"
  create_mode                      = "Default"
  requested_service_objective_name = "Basic"
  tags                             = var.tags
}


# Enables the "Allow Access to Azure services" box as described in the API docs
# https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
resource "azurerm_sql_firewall_rule" "rule1" {
  name                        = "rule1"
  resource_group_name         = var.rg_name
  server_name                 = azurerm_sql_server.sql_server.name
  start_ip_address            = "192.168.0.1"
  end_ip_address              = "192.168.0.1"
  
}

resource "azurerm_sql_firewall_rule" "rule2" {
  name                        = "rule2"
  resource_group_name         = var.rg_name
  server_name                 = azurerm_sql_server.sql_server.name
  start_ip_address            = "192.168.0.73"
  end_ip_address              = "192.168.0.73"
  
}

resource "azurerm_sql_firewall_rule" "rule3" {
  name                        = "rule3"
  resource_group_name         = var.rg_name
  server_name                 = azurerm_sql_server.sql_server.name
  start_ip_address            = "192.168.0.159"
  end_ip_address              = "192.168.0.187"
  
}

/*
resource "azurerm_private_endpoint" "private_endpoint_SQL" {
  name                 = "${var.prefix}-peSQL"
  location             = var.location
  resource_group_name  = var.rg_name
  subnet_id            = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "tfex-sqlServer-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_sql_server.sql_server.id
    subresource_names              = ["sqlServer"]
  }
}
*/