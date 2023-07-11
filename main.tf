provider "azurerm" {

data "azurerm_key_vault" "mysecretsfiles"{
  name                = mysecretsfiles
  resource_group_name = Azurevms
}

data "azurerm_key_vault_secret" "clientid" {
  name         = "clientid"
  key_vault_id = data.azurerm_key_vault.mysecretsfiles.id
}
output "clientid"{
value = data.azurerm_key_vault_secret.clientid.value
}
data "azurerm_key_vault_secret" "clientSecret" {
  name         = "clientSecret"
  key_vault_id = data.azurerm_key_vault.mysecretsfiles.id
}
output "clientSecret"{
value = data.azurerm_key_vault_secret.clientSecret.value
}
data "azurerm_key_vault_secret" "subscriptionID" {
  name         = "subscriptionID"
  key_vault_id = data.azurerm_key_vault.mysecretsfiles.id
}
output "subscriptionID" {
value = data.azurerm_key_vault_secret.subscriptionID.value
}
data "azurerm_key_vault_secret" "tenantid" {
  name         = tenantid
  key_vault_id = data.azurerm_key_vault.mysecretsfiles.id
}

output "tenantid" {
  value = data.azurerm_key_vault_secret.tenantid.value
}
  subscription_id = value.subscriptionID
  client_id       = value.clientid
  client_secret   = value.clientid
  tenant_id       = value.tenantid

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
