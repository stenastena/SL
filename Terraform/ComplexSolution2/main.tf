provider "azurerm" {
  features {}
  version = "2.30.0"
  client_secret   = var.client_secret
  client_id       = var.client_id
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
} 

resource "azurerm_resource_group" "rg" {
  name            = "rg${var.prefix}"
  location        = var.location
  tags            = var.tags
}


module "storage" {
  source 	        = "./modules/storage"
  rg_name	        = azurerm_resource_group.rg.name
  location	      = var.location
  tags            = var.tags
  prefix          = var.prefix
}

module "sqldb-network" {
  source 	        = "./modules/sqldb-network"
  rg_name	        = azurerm_resource_group.rg.name
  location	      = var.location
  tags            = var.tags
  prefix          = var.prefix
  DB_firewall_IP1 = var.DB_firewall_IP1
  DB_firewall_IP2 = var.DB_firewall_IP2
  DB_firewall_IP3 = var.DB_firewall_IP3
  DB_firewall_IP4 = var.DB_firewall_IP4
  DB_firewall_IP5 = var.DB_firewall_IP5
  DB_firewall_IP6 = var.DB_firewall_IP6
  DB_firewall_IP7 = var.DB_firewall_IP7
}

module "containerinstance" {
  source = "./modules/containerinstance"
  rg_name	        = azurerm_resource_group.rg.name
  location	      = var.location
  tags            = var.tags
  prefix          = var.prefix
}

