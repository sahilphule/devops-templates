resource "azurerm_public_ip" "public-ip" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name              = var.virtual-machine-properties.public-ip-name
  allocation_method = var.virtual-machine-properties.public-ip-allocation-method

  lifecycle {
    create_before_destroy = false
  }
}

resource "azurerm_network_interface" "network-interface" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name = var.virtual-machine-properties.network-interface-name

  ip_configuration {
    name                          = var.virtual-machine-properties.network-interface-ip-configuration-name
    private_ip_address_allocation = var.virtual-machine-properties.network-interface-private-ip-address-allocation
    public_ip_address_id          = azurerm_public_ip.public-ip.id
    subnet_id                     = var.vnet-public-subnet-id
  }

  depends_on = [
    azurerm_public_ip.public-ip
  ]
}

resource "azurerm_network_security_group" "network-security-group" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name = var.virtual-machine-properties.network-security-group-name
}

resource "azurerm_network_security_rule" "network-security-rule" {
  resource_group_name = var.resource-group-properties.rg-name

  network_security_group_name = azurerm_network_security_group.network-security-group.name

  count                      = var.virtual-machine-properties.network-security-rule-count
  name                       = var.virtual-machine-properties.network-security-rule-name[count.index]
  priority                   = var.virtual-machine-properties.network-security-rule-priority[count.index]
  direction                  = var.virtual-machine-properties.network-security-rule-direction[count.index]
  access                     = var.virtual-machine-properties.network-security-rule-access[count.index]
  protocol                   = var.virtual-machine-properties.network-security-rule-protocol[count.index]
  source_port_range          = var.virtual-machine-properties.network-security-rule-source-port-range[count.index]
  destination_port_range     = var.virtual-machine-properties.network-security-rule-destination-port-range[count.index]
  source_address_prefix      = var.virtual-machine-properties.network-security-rule-source-address-prefix[count.index]
  destination_address_prefix = var.virtual-machine-properties.network-security-rule-destination-address-prefix[count.index]

  depends_on = [
    azurerm_network_security_group.network-security-group
  ]
}

resource "azurerm_network_interface_security_group_association" "nsg-association" {
  network_interface_id      = azurerm_network_interface.network-interface.id
  network_security_group_id = azurerm_network_security_group.network-security-group.id

  depends_on = [
    azurerm_network_interface.network-interface,
    azurerm_network_security_group.network-security-group
  ]
}

resource "azurerm_linux_virtual_machine" "linux-virtual-machine" {
  resource_group_name = var.resource-group-properties.rg-name
  location            = var.resource-group-properties.rg-location

  name                            = var.virtual-machine-properties.linux-vm-name
  size                            = var.virtual-machine-properties.linux-vm-size
  admin_username                  = var.virtual-machine-properties.linux-vm-admin-username
  admin_password                  = var.virtual-machine-properties.linux-vm-admin-password
  disable_password_authentication = var.virtual-machine-properties.linux-vm-disable-password-authentication
  custom_data                     = base64encode(file(var.virtual-machine-properties.linux-vm-custom-data))

  network_interface_ids = [
    azurerm_network_interface.network-interface.id
  ]

  # admin_ssh_key {
  #   username   = var.virtual-machine-properties.linux-vm-admin-ssh-key-username
  #   public_key = tls_private_key.secureadmin_ssh.public_key_openssh
  # }

  os_disk {
    name                 = var.virtual-machine-properties.linux-vm-os-disk-name
    caching              = var.virtual-machine-properties.linux-vm-os-disk-caching
    storage_account_type = var.virtual-machine-properties.linux-vm-os-disk-storage-account-type
  }

  source_image_reference {
    publisher = var.virtual-machine-properties.vm-source-image-reference-publisher
    offer     = var.virtual-machine-properties.vm-source-image-reference-offer
    sku       = var.virtual-machine-properties.vm-source-image-reference-sku
    version   = var.virtual-machine-properties.vm-source-image-reference-version
  }

  depends_on = [
    azurerm_network_interface.network-interface
  ]
}
