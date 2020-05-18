resource "azurerm_resource_group" "main" {
  name     = "${var.resourceGroup}"
  location = "${var.region}"
}

data "azurerm_virtual_network" "vnet" {
  name                = "${var.virtual_network_name}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.subnet_name}"
  virtual_network_name = "${data.azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.main.name}"
}

resource "azurerm_public_ip" "test" {
  name                = "${var.prefix}-PublicIp"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  allocation_method   = "Static"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_network_interface" "network_interface1" {
  name                = "${var.prefix}-nic"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-azure-vm"
  location              = "${var.region}"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  network_interface_ids = ["${azurerm_network_interface.network_interface1.id}"]
  vm_size               = "${var.vmSize}"

  storage_image_reference {
   id = "${var.image_reference}"
 }
  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.hostname}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  tags = {  
     environment = "staging"
  }
}

