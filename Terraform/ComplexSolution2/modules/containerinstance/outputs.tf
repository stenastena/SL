output "aci-ip_address" {
  value = azurerm_container_group.aci.ip_address
}

#the dns fqdn of the container group if dns_name_label is set
output "aci-fqdn" {
  value = azurerm_container_group.aci.fqdn
}
