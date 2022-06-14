resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  # address_space       = ["10.0.0.0/16"]
  address_space       = [ local.vpc_cidr ]
}

resource "azurerm_subnet" "public_frontend" {
  # name                 = "frontend"
  name                 = "${local.public_dup_frontend_subnet_name}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  # address_prefixes     = ["10.0.1.0/24"]
  address_prefixes     = [ local.public_dup_frontend_subnet ]
}

resource "azurerm_subnet" "uniq_backend" {
  # name                 = "backend"
  name                 = "${local.private_uniq_backend_subnet_name}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  # address_prefixes     = ["10.0.2.0/24"]
  address_prefixes     = [ local.private_uniq_backend_subnet ]
}

resource "azurerm_subnet" "dup_backend" {
  # name                 = "backend"
  name                 = "${local.private_dup_backend_subnet_name}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  # address_prefixes     = ["10.0.2.0/24"]
  address_prefixes     = [ local.private_uniq_backend_subnet ]
}

resource "azurerm_subnet" "database_backend" {
  # name                 = "database"
  name                 = "${local.private_db_backend_subnet_name}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  # address_prefixes     = ["10.0.3.0/24"]
  address_prefixes     = [ local.private_db_backend_subnet ]
}