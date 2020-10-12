resource "azurerm_container_group" "aci" {
  name                     = "${var.prefix}-container-group"
  resource_group_name      = var.rg_name
  location                 = var.location
  ip_address_type     = "public"
  dns_name_label      = "${var.prefix}-container-group-14x49"
  os_type             = "linux"
  

  container {
    name   = "hw"
    image  = "microsoft/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  container {
    name   = "sidecar"
    image  = "microsoft/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = var.tags
}
