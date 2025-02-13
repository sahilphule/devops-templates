locals {
  # resource group properties
  resource-group-properties = {}

  # virtual-machine-properties
  virtual-machine-properties = {
    public-ip-name              = "linux-vm-public-ip"
    public-ip-allocation-method = "Static"

    network-interface-name                          = "nic"
    network-interface-ip-configuration-name         = "test-configuration"
    network-interface-private-ip-address-allocation = "Dynamic"

    network-security-group-name = "vm-network-security-group"

    network-security-rule-count                      = 3
    network-security-rule-name                       = ["ssh-inbound", "http-inbound", "http-outbound"]
    network-security-rule-priority                   = [100, 200, 300]
    network-security-rule-direction                  = ["Inbound", "Inbound", "Outbound"]
    network-security-rule-access                     = ["Allow", "Allow", "Allow"]
    network-security-rule-protocol                   = ["Tcp", "Tcp", "Tcp"]
    network-security-rule-source-port-range          = ["22", "80", "80"]
    network-security-rule-destination-port-range     = ["22", "80", "80"]
    network-security-rule-source-address-prefix      = ["*", "*", "*"]
    network-security-rule-destination-address-prefix = ["*", "*", "*"]

    linux-vm-name                            = "linux-vm"
    linux-vm-size                            = "Standard_DS1_v2"
    linux-admin-username                     = "root"
    linux-admin-password                     = "password"
    linux-vm-disable-password-authentication = false

    linux-vm-admin-ssh-key-username = "linux-vm-ssh-key"

    linux-vm-os-disk-name                 = "linux-vm-os-disk"
    linux-vm-os-disk-caching              = "ReadWrite"
    linux-vm-os-disk-storage-account-type = "Standard_LRS"

    vm-storage-image-reference-publisher = "Canonical"
    vm-storage-image-reference-offer     = "UbuntuServer"
    vm-storage-image-reference-sku       = "22_04-lts"
    vm-storage-image-reference-version   = "latest"
  }
}
