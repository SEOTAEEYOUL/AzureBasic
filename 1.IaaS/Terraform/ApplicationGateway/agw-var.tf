# -
# - Variables
# -

locals {
  prefix   = "demo"
  rg_name  = "rg-skcc1-netwrok-dev" #An existing Resource Group for the Application Gateway 
  sku_name = "Standard_v2" #Sku with WAF is : WAF_v2
  sku_tier = "Standard_v2"
  zones    = ["1", "2", "3"] #Availability zones to spread the Application Gateway over. They are also only supported for v2 SKUs.
  capacity = {
    min = 1 #Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
    max = 3 #Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
  }
  subnet_id = "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc1-netwrok-dev/providers/Microsoft.Network/virtualNetworks/vnet-network-dev/subnets/snet-skcc1-network-frontend" #Fill Here a dedicated subnet if for the Application Gateway

  appname = "homepage"
  backend_address_pool = {
    name  = "${local.appname}-pool1"
    fqdns = ["mysite1.azurewebsites.net"]
  }
  frontend_port_name             = "${local.appname}-feport"
  frontend_ip_configuration_name = "${local.appname}-feip"
  http_setting_name              = "${local.appname}-be-htst"
  listener_name                  = "${local.appname}-httplstn"
  request_routing_rule_name      = "${local.appname}-rqrt"
  redirect_configuration_name    = "${local.appname}-rdrcfg"

  diag_appgw_logs = [
    "ApplicationGatewayAccessLog",
    "ApplicationGatewayPerformanceLog",
    "ApplicationGatewayFirewallLog",
  ]
  diag_appgw_metrics = [
    "AllMetrics",
  ]
}

#Get the Application Gateway Resource Group
data "azurerm_resource_group" "rg" {
  name = local.rg_name
}