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

output "subnet2" {
  value = azurerm_subnet.subnet2.name
}

output "subnet2_address_prefixes" {
  value = azurerm_subnet.subnet2.address_prefixes
}