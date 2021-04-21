resource "azurerm_key_vault" "main" {
  name                     = "${var.prefix}akv"
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  tenant_id                = data.azurerm_client_config.main.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false
}


resource "azurerm_key_vault_access_policy" "main" {
  key_vault_id            = azurerm_key_vault.main.id
  tenant_id               = data.azurerm_client_config.main.tenant_id
  object_id               = data.azurerm_client_config.main.object_id
  certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
  key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
  secret_permissions      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}


resource "azurerm_key_vault_secret" "resource_group_name" {
  name         = "resource-group-name"
  value        = data.azurerm_resource_group.main.name
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault_access_policy.main]
}

resource "azurerm_key_vault_secret" "subscription_id" {
  name         = "subscription-id"
  value        = data.azurerm_client_config.main.subscription_id
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault_access_policy.main]
}

resource "azurerm_key_vault_secret" "prefix" {
  name         = "prefix"
  value        = var.prefix
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault_access_policy.main]
}