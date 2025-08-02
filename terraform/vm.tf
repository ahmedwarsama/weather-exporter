resource "azurerm_linux_virtual_machine" "lab-vm" {
  name                = "lab-vm"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  size                = "Standard_F2"
  admin_username      = "lab-user"
  network_interface_ids = [
    azurerm_network_interface.lab-interface.id,
  ]

  admin_ssh_key {
    username   = "lab-user"
    public_key = file("~/.ssh/id_ed25519.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
