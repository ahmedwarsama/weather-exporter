resource "azurerm_private_dns_zone" "lab-domain" {
  name                = "mylab.com"
  resource_group_name = azurerm_resource_group.lab.name
}

resource "azurerm_private_dns_a_record" "vm-record" {
  name                = "lab-node"
  zone_name           = azurerm_private_dns_zone.lab-domain.name
  resource_group_name = azurerm_resource_group.lab.name
  ttl                 = 300
  records             = [azurerm_network_interface.lab-interface.ip_configuration[0].private_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "lab-domain-vnet-link"
  resource_group_name   = azurerm_resource_group.lab.name
  private_dns_zone_name = azurerm_private_dns_zone.lab-domain.name
  virtual_network_id    = azurerm_virtual_network.lab-vnet.id
}
