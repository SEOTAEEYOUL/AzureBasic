# -
# - Managed Service Identity
# -

resource "azurerm_user_assigned_identity" "agw" {
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  name                = "${local.prefix}-hub-agw1-msi"
  tags                = data.azurerm_resource_group.rg.tags
}