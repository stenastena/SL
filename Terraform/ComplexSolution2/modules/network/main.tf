resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
################### 
  depends_on = [module.azure_sql_db]
###################
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  enforce_private_link_service_network_policies = true
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  enforce_private_link_endpoint_network_policies = true
}

/*
resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  sku                 = "Standard"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "example" {
  name                = "example-lb"
  sku                 = "Standard"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.example.name
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_private_link_service" "example" {
  name                = "example-privatelink"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  nat_ip_configuration {
    name      = azurerm_public_ip.example.name
    primary   = true
    subnet_id = azurerm_subnet.service.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration.0.id,
  ]
}

resource "azurerm_private_endpoint" "example" {
  name                = "example-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_private_link_service.example.id
    is_manual_connection           = false
  }
}
*/
module "azure_sql_db" {
  source 	        = "../sqldb"
  rg_name	        = var.rg_name
  location	      = var.location
  tags            = var.tags
  prefix          = var.prefix
}

resource "azurerm_private_endpoint" "peMSSQL" {
  name                = "${var.prefix}-peMSSQL"
  resource_group_name = var.rg_name
  location            = var.location
  subnet_id           = azurerm_subnet.subnet1.id

  private_service_connection {
    name                           = "tfex-MSSQL-connection"
    is_manual_connection           = false
    private_connection_resource_id = module.azure_sql_db.sql_server_id
    subresource_names              = ["sqlServer"]
  } 
  
 
}
