output "terraform_group_name" {
  value = azurerm_resource_group.tfstate.name
}

output "terraform_storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "terraform_storage_container_name" {
  value = azurerm_storage_container.tfstate.name
}