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
##############################################
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]

################### 
  depends_on          = [azurerm_sql_server.sql_server]
###################

/*
provisioner "local-exec" {
  #command             = "cmd /c timeout /t 120"
  #command             = "pause"
}
*/

}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  enforce_private_link_service_network_policies = true
  enforce_private_link_endpoint_network_policies = true
}

/*
resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  enforce_private_link_endpoint_network_policies = true
}
*/

resource "azurerm_private_endpoint" "peMSSQL" {
  name                = "${var.prefix}-peMSSQL"
  resource_group_name = var.rg_name
  location            = var.location
  subnet_id           = azurerm_subnet.subnet1.id

  private_service_connection {
    name                           = "${var.prefix}-MSSQL-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_sql_server.sql_server.id
    subresource_names              = ["sqlServer"]
  } 

# A private dns zone group is an "A" recordset in private DNS zone for this endpoint
  private_dns_zone_group{
    name                          = "ourDNSZoneGroup"
    private_dns_zone_ids          = [azurerm_private_dns_zone.priv_zone.id]
  }
################### 
  depends_on          = [azurerm_private_dns_zone_virtual_network_link.vnet_link]
###################
}

#Private DNS zone and obligatary virtual network link between this zone and target network

resource "azurerm_private_dns_zone" "priv_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "vnet_link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.priv_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = "true"
}




###########################################################################
/* ===============
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}


resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}
===============
*/

resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-client-pip"
  resource_group_name          = var.rg_name
  location                     = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "pip149"
}

resource "azurerm_network_interface" "vm" {
  name                         = "${var.prefix}-nic"
  resource_group_name          = var.rg_name
  location                     = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
  
}

resource "azurerm_windows_virtual_machine" "main" {
  name                            = "${var.prefix}-vm"
  resource_group_name          = var.rg_name
  location                     = var.location
  size                            = "Standard_B2s"
  admin_username                  = "superadmin"
  admin_password                  = "1q21!Q@!1q21!"
  network_interface_ids = [
    azurerm_network_interface.vm.id,
  ]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
