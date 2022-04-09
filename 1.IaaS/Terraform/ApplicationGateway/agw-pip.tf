#
# Public IP
#

resource "azurerm_public_ip" "agw" {
  name                = "${local.prefix}-hub-agw1-pip1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = data.azurerm_resource_group.rg.tags
}