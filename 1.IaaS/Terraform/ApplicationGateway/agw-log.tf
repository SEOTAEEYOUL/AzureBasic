# -
# - Log Analytics Workspace
# -
resource "azurerm_log_analytics_workspace" "wks" {
  name                = "${local.prefix}-hub-logaw1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018" #(Required) Specifies the Sku of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, and PerGB2018 (new Sku as of 2018-04-03).
  retention_in_days   = 100         #(Optional) The workspace data retention in days. Possible values range between 30 and 730.
  tags                = data.azurerm_resource_group.rg.tags
}

resource "azurerm_log_analytics_solution" "agw" {
  solution_name         = "AzureAppGatewayAnalytics"
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.wks.id
  workspace_name        = azurerm_log_analytics_workspace.wks.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureAppGatewayAnalytics"
  }
}