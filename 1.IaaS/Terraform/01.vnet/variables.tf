variable "prefix" {
  default = "azure"
  description = "The prefix used for all resources in this example"
}

variable "location" {
  default = "koreacentral"
  description = "The Azure location where all resources in this example should be created"
}

variable "resource_group_name_prefix" {
  default       = "rg"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

# variable "resource_group_location" {
#   default = "eastus"
#   description   = "Location of the resource group."
# }