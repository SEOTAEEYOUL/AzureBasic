provider "azurerm" {
  features {}

  # subscription_id   = "<azure_subscription_id>"
  # tenant_id         = "<azure_subscription_tenant_id>"
  # client_id         = "<service_principal_appid>"
  # client_secret     = "<service_principal_password>"
  # default_tags {
  #   tags = {
  #     ServiceName         = "hybrid-cloud"
  #     Environment         = "stg"
  #     Personalinformation = "yes"
  #   }
  # }
}

# Your code goes here
resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  # location = "eastus"
  location = "Korea Central"
}