data "azurerm_network_security_group" "nsghcl" {
  for_each = var.nsgsubnet
    name = each.value.nsg_name
    resource_group_name = each.value.resource_group_name
  
}

data "azurerm_subnet" "subnettest" {
    for_each = var.nsgsubnet
    name = each.value.subnet_name
    virtual_network_name = each.value.virtual_network_name
    resource_group_name = each.value.resource_group_name
  
}


resource "azurerm_subnet_network_security_group_association" "nsgassociate" {
    for_each = var.nsgsubnet
  subnet_id                 = data.azurerm_subnet.subnettest[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsghcl[each.key].id
}