data "azurerm_public_ip" "iptest" {
    for_each = var.nic
    name = each.value.pip_name
    resource_group_name = each.value.resource_group_name
  
}


data "azurerm_subnet" "subnettest" {
    for_each = var.nic
    name = each.value.subnet_name
    virtual_network_name = each.value.virtual_network_name
    resource_group_name = each.value.resource_group_name
  
}


resource "azurerm_network_interface" "nictest" {
    for_each = var.nic
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    

    ip_configuration {
        name = "internal"
        subnet_id = data.azurerm_subnet.subnettest[each.key].id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = data.azurerm_public_ip.iptest[each.key].id
        
  }
    }
