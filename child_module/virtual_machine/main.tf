data "azurerm_network_interface" "nictest" {
 for_each = var.vm
 name = each.value.nic_name
 resource_group_name = each.value.resource_group_name
  
}
data "azurerm_key_vault" "hclkeyvault" {
    for_each = var.vm
  name                = each.value.keyvault_name
  resource_group_name = each.value.resource_group_name
}


# Step 4: Fetch the Secrets from the Key Vault for VM Creation
data "azurerm_key_vault_secret" "vm_secret" {
    for_each = var.vm
  name         = each.value.vm_secret
  key_vault_id = data.azurerm_key_vault.hclkeyvault[each.key].id
}



resource "azurerm_linux_virtual_machine" "vmtest" {
    for_each = var.vm
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    size = "Standard_B1s"
    admin_username        = data.azurerm_key_vault_secret.vm_secret[each.key].value
    admin_password        = data.azurerm_key_vault_secret.vm_secret[each.key].value
    disable_password_authentication = false
    network_interface_ids = [data.azurerm_network_interface.nictest[each.key].id]
    

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts"
        version = "latest"

    }

    identity {
      type = "SystemAssigned"
    }

}