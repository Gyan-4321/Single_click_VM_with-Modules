data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "hclkeyvault" {
    for_each = var.keyvault
  name                        = each.value.name  # Must be globally unique
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  sku_name                    = "standard"
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7

 
}

# Step 3: Store VM Username and Password in Key Vault as Secrets
resource "azurerm_key_vault_secret" "vm_secret" {
    for_each = var.keyvault
  name         = each.value.secret_name
  value        = each.value.value2  # Replace with your VM username
  key_vault_id = azurerm_key_vault.hclkeyvault[each.key].id
}

# resource "azurerm_role_assignment" "keyvault_access" {
#   principal_id   = azurerm_linux_virtual_machine.vmtest.identity[0].principal_id
#   role_definition_name = "Key Vault Secrets User"
#   scope           = azurerm_key_vault.hclkeyvaul.id
# }

# resource "azurerm_key_vault_access_policy" "access_policy" {
#   key_vault_id = azurerm_key_vault.hclkeyvaul.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = azurerm_linux_virtual_machine.vmtest.identity[0].principal_id

#   secret_permissions = [
#     "get",  # Permission to retrieve the secret value (password)
#     "list"   # Permission to list secrets
#   ]
# }



