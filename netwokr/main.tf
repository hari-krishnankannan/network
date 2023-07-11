provider "azurerm" {

data "azurerm_key_vault" "mysecretsfiles"{
  name                = mysecretsfiles
  resource_group_name = Azurevms
}

data "azurerm_key_vault_secret" "clientid" {
  name         = "clientid"
  key_vault_id = data.azurerm_key_vault.mysecretsfiles.id
}

data "azurerm_key_vault_secret" "clientSecret" {
  name         = "clientSecret"
  key_vault_id = data.azurerm_key_vault.mysecretsfiles.id
}

data "azurerm_key_vault_secret" "subscriptionID" {
  name         = "subscriptionID"
  key_vault_id = data.azurerm_key_vault.mysecretsfiles.id
}
data "azurerm_key_vault_secret" "tenantid" {
  name         = tenantid
  key_vault_id = data.azurerm_key_vault.mysecretsfiles.id
}

output "secret_value" {
  value = data.azurerm_key_vault_secret.tenantid.value
  value = data.azurerm_key_vault_secret.subscriptionID.value
value = data.azurerm_key_vault_secret.clientid.value
value = data.azurerm_key_vault_secret.clientSecret.value
}

resource "azurerm_resource_group" "k8s" {
  name     = var.resource_group_name
  location = var.location
}
module "network" {
  source    = "./network"
  vnet_name =   var.vnet_name
resource_group_name = azurerm_resource_group.k8s.name
   subnet_address_space    = [var.subnet_address_space]
  subnet_address_prefixes = [var.subnet_address_prefixes]
   }
}
