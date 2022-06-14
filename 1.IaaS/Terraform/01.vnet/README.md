# Virtutal Network

## Example: Virtual Network with multiple Subnets

This example provisions a Virtual Network containing a 3 Subnets.

### terraform init
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform\01.vnet> terraform init 

Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "azurerm" backend. No existing state was found in the newly
  configured "azurerm" backend. Do you want to copy this state to the new "azurerm"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes


Successfully configured the backend "azurerm"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
╷
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider hashicorp/azurerm: locked provider registry.terraform.io/hashicorp/azurerm 2.99.0 does not match configured     
│ version constraint 2.46.0; must use terraform init -upgrade to allow selection of new versions
╵

PS D:\workspace\AzureBasic\1.IaaS\Terraform\01.vnet> terraform init -upgrade

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "2.46.0"...
- Installing hashicorp/azurerm v2.46.0...
- Installed hashicorp/azurerm v2.46.0 (signed by HashiCorp)

Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
PS D:\workspace\AzureBasic\1.IaaS\Terraform\01.vnet>
```

### terraform plan
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform\01.vnet> terraform plan
azurerm_resource_group.state-demo-secure: Refreshing state... [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/state-demo]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "koreacentral"
      + name     = "azure-rg"
    }

  # azurerm_subnet.database_backend will be created
  + resource "azurerm_subnet" "database_backend" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "192.168.36.128/26",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "snet-private-db-backend"
      + resource_group_name                            = "azure-rg"
      + virtual_network_name                           = "azure-vnet"
    }

  # azurerm_subnet.dup_backend will be created
  + resource "azurerm_subnet" "dup_backend" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "100.64.34.96/28",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "snet-private-dup-backend"
      + resource_group_name                            = "azure-rg"
      + virtual_network_name                           = "azure-vnet"
    }

  # azurerm_subnet.public_frontend will be created
  + resource "azurerm_subnet" "public_frontend" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "100.64.8.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "snet-public-dup-frontend"
      + resource_group_name                            = "azure-rg"
      + virtual_network_name                           = "azure-vnet"
    }

  # azurerm_subnet.uniq_backend will be created
  + resource "azurerm_subnet" "uniq_backend" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "100.64.34.96/28",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "snet-private-uniq-backend"
      + resource_group_name                            = "azure-rg"
      + virtual_network_name                           = "azure-vnet"
    }

  # azurerm_virtual_network.vnet will be created
  + resource "azurerm_virtual_network" "vnet" {
      + address_space         = [
          + "192.168.36.128/26",
        ]
      + guid                  = (known after apply)
      + id                    = (known after apply)
      + location              = "koreacentral"
      + name                  = "azure-vnet"
      + resource_group_name   = "azure-rg"
      + subnet                = (known after apply)
      + vm_protection_enabled = false
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ~ resource_group_name = "azure-resources" -> "azure-rg"

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
PS D:\workspace\AzureBasic\1.IaaS\Terraform\01.vnet> 
```

### terraform apply
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform\vnet> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.example will be created
  + resource "azurerm_resource_group" "example" {
      + id       = (known after apply)
      + location = "koreacentral"
      + name     = "azure-resources"
    }

  # azurerm_subnet.backend will be created
  + resource "azurerm_subnet" "backend" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.2.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "backend"
      + resource_group_name                            = "azure-resources"
      + virtual_network_name                           = "azure-network"
    }

  # azurerm_subnet.database will be created
  + resource "azurerm_subnet" "database" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.3.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "database"
      + resource_group_name                            = "azure-resources"
      + virtual_network_name                           = "azure-network"
    }

  # azurerm_subnet.frontend will be created
  + resource "azurerm_subnet" "frontend" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.1.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "frontend"
      + resource_group_name                            = "azure-resources"
      + virtual_network_name                           = "azure-network"
    }

  # azurerm_virtual_network.example will be created
  + resource "azurerm_virtual_network" "example" {
      + address_space         = [
          + "10.0.0.0/16",
        ]
      + dns_servers           = (known after apply)
      + guid                  = (known after apply)
      + id                    = (known after apply)
      + location              = "koreacentral"
      + name                  = "azure-network"
      + resource_group_name   = "azure-resources"
      + subnet                = (known after apply)
      + vm_protection_enabled = false
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.example: Creating...
azurerm_resource_group.example: Creation complete after 0s [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/azure-resources]
azurerm_virtual_network.example: Creating...
azurerm_virtual_network.example: Creation complete after 4s [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/azure-resources/providers/Microsoft.Network/virtualNetworks/azure-network]
azurerm_subnet.frontend: Creating...
azurerm_subnet.backend: Creating...
azurerm_subnet.database: Creating...
azurerm_subnet.frontend: Creation complete after 3s [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/azure-resources/providers/Microsoft.Network/virtualNetworks/azure-network/subnets/frontend]
azurerm_subnet.database: Creation complete after 7s [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/azure-resources/providers/Microsoft.Network/virtualNetworks/azure-network/subnets/database]
azurerm_subnet.backend: Still creating... [10s elapsed]
azurerm_subnet.backend: Creation complete after 10s [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/azure-resources/providers/Microsoft.Network/virtualNetworks/azure-network/subnets/backend]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
PS D:\workspace\AzureBasic\1.IaaS\Terraform\vnet>


```