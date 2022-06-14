# 원격 상태 스토리지 계정 구성

### terraform init
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init> terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "2.46.0"...
- Finding latest version of hashicorp/random...
- Installing hashicorp/azurerm v2.46.0...
- Installed hashicorp/azurerm v2.46.0 (signed by HashiCorp)
- Installing hashicorp/random v3.3.1...
- Installed hashicorp/random v3.3.1 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init> 
```

### terraform plan
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init> terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.tfstate will be created
  + resource "azurerm_resource_group" "tfstate" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "tfstate"
    }

  # azurerm_storage_account.tfstate will be created
  + resource "azurerm_storage_account" "tfstate" {
      + access_tier                      = (known after apply)
      + account_kind                     = "StorageV2"
      + account_replication_type         = "LRS"
      + account_tier                     = "Standard"
      + allow_blob_public_access         = true
      + enable_https_traffic_only        = true
      + id                               = (known after apply)
      + is_hns_enabled                   = false
      + large_file_share_enabled         = (known after apply)
      + location                         = "eastus"
      + min_tls_version                  = "TLS1_0"
      + name                             = (known after apply)
      + primary_access_key               = (sensitive value)
      + primary_blob_connection_string   = (sensitive value)
      + primary_blob_endpoint            = (known after apply)
      + primary_blob_host                = (known after apply)
      + primary_connection_string        = (sensitive value)
      + primary_dfs_endpoint             = (known after apply)
      + primary_dfs_host                 = (known after apply)
      + primary_file_endpoint            = (known after apply)
      + primary_file_host                = (known after apply)
      + primary_location                 = (known after apply)
      + primary_queue_endpoint           = (known after apply)
      + primary_queue_host               = (known after apply)
      + primary_table_endpoint           = (known after apply)
      + primary_table_host               = (known after apply)
      + primary_web_endpoint             = (known after apply)
      + primary_web_host                 = (known after apply)
      + resource_group_name              = "tfstate"
      + secondary_access_key             = (sensitive value)
      + secondary_blob_connection_string = (sensitive value)
      + secondary_blob_endpoint          = (known after apply)
      + secondary_blob_host              = (known after apply)
      + secondary_connection_string      = (sensitive value)
      + secondary_dfs_endpoint           = (known after apply)
      + secondary_dfs_host               = (known after apply)
      + secondary_file_endpoint          = (known after apply)
      + secondary_file_host              = (known after apply)
      + secondary_location               = (known after apply)
      + secondary_queue_endpoint         = (known after apply)
      + secondary_queue_host             = (known after apply)
      + secondary_table_endpoint         = (known after apply)
      + secondary_table_host             = (known after apply)
      + secondary_web_endpoint           = (known after apply)
      + secondary_web_host               = (known after apply)
      + tags                             = {
          + "environment" = "staging"
        }

      + blob_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }
    }

  # azurerm_storage_container.tfstate will be created
  + resource "azurerm_storage_container" "tfstate" {
      + container_access_type   = "blob"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "tfstate"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = (known after apply)
    }

  # random_string.resource_code will be created
  + resource "random_string" "resource_code" {
      + id          = (known after apply)
      + length      = 5
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 4 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init> 
```

### terraform apply
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.tfstate will be created
  + resource "azurerm_resource_group" "tfstate" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "tfstate"
    }

  # azurerm_storage_account.tfstate will be created
  + resource "azurerm_storage_account" "tfstate" {
      + access_tier                      = (known after apply)
      + account_kind                     = "StorageV2"
      + account_replication_type         = "LRS"
      + account_tier                     = "Standard"
      + allow_blob_public_access         = true
      + enable_https_traffic_only        = true
      + id                               = (known after apply)
      + is_hns_enabled                   = false
      + large_file_share_enabled         = (known after apply)
      + location                         = "eastus"
      + min_tls_version                  = "TLS1_0"
      + name                             = (known after apply)
      + primary_access_key               = (sensitive value)
      + primary_blob_connection_string   = (sensitive value)
      + primary_blob_endpoint            = (known after apply)
      + primary_blob_host                = (known after apply)
      + primary_connection_string        = (sensitive value)
      + primary_dfs_endpoint             = (known after apply)
      + primary_dfs_host                 = (known after apply)
      + primary_file_endpoint            = (known after apply)
      + primary_file_host                = (known after apply)
      + primary_location                 = (known after apply)
      + primary_queue_endpoint           = (known after apply)
      + primary_queue_host               = (known after apply)
      + primary_table_endpoint           = (known after apply)
      + primary_table_host               = (known after apply)
      + primary_web_endpoint             = (known after apply)
      + primary_web_host                 = (known after apply)
      + resource_group_name              = "tfstate"
      + secondary_access_key             = (sensitive value)
      + secondary_blob_connection_string = (sensitive value)
      + secondary_blob_endpoint          = (known after apply)
      + secondary_blob_host              = (known after apply)
      + secondary_connection_string      = (sensitive value)
      + secondary_dfs_endpoint           = (known after apply)
      + secondary_dfs_host               = (known after apply)
      + secondary_file_endpoint          = (known after apply)
      + secondary_file_host              = (known after apply)
      + secondary_location               = (known after apply)
      + secondary_queue_endpoint         = (known after apply)
      + secondary_queue_host             = (known after apply)
      + secondary_table_endpoint         = (known after apply)
      + secondary_table_host             = (known after apply)
      + secondary_web_endpoint           = (known after apply)
      + secondary_web_host               = (known after apply)
      + tags                             = {
          + "environment" = "staging"
        }

      + blob_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }
    }

  # azurerm_storage_container.tfstate will be created
  + resource "azurerm_storage_container" "tfstate" {
      + container_access_type   = "blob"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "tfstate"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = (known after apply)
    }

  # random_string.resource_code will be created
  + resource "random_string" "resource_code" {
      + id          = (known after apply)
      + length      = 5
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.resource_code: Creating...
random_string.resource_code: Creation complete after 0s [id=ebdqh]
azurerm_resource_group.tfstate: Creating...
azurerm_resource_group.tfstate: Creation complete after 4s [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/tfstate]
azurerm_storage_account.tfstate: Creating...
azurerm_storage_account.tfstate: Still creating... [10s elapsed]
azurerm_storage_account.tfstate: Still creating... [20s elapsed]
azurerm_storage_account.tfstate: Still creating... [30s elapsed]
azurerm_storage_account.tfstate: Creation complete after 31s [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/tfstate/providers/Microsoft.Storage/storageAccounts/tfstateebdqh]
azurerm_storage_container.tfstate: Creating...
azurerm_storage_container.tfstate: Creation complete after 0s [id=https://tfstateebdqh.blob.core.windows.net/tfstate]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init>
```

### terraform output
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init> terraform output 
terraform_group_name = "tfstate"
terraform_storage_account_name = "tfstateebdqh"
terraform_storage_container_name = "tfstate"
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init>
```

#### az group list -o table
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init> az group list -o table
Name                               Location       Status
---------------------------------  -------------  ---------
rg-ca10565-eastus                  eastus         Succeeded
rg-good-lynx                       eastus         Succeeded
tfstate                            eastus         Succeeded
cloud-shell-storage-southeastasia  southeastasia  Succeeded
NetworkWatcherRG                   koreacentral   Succeeded
DefaultResourceGroup-SE            koreacentral   Succeeded
AzureBackupRG_koreacentral_1       koreacentral   Succeeded
rg-skcc1-network-dev               koreacentral   Succeeded
rg-skcc7-homepage-dev              koreacentral   Succeeded
rg-skcc2-aks                       koreacentral   Succeeded
rg-ca10565-test                    koreacentral   Succeeded
rg-erp                             koreacentral   Succeeded
rg-aci                             koreacentral   Succeeded
springmysql_group                  koreacentral   Succeeded
rg-ca05087                         koreacentral   Succeeded
caf-rg                             koreacentral   Succeeded
azure-resources                    koreacentral   Succeeded
PS D:\workspace\AzureBasic\1.IaaS\Terraform\00.init> 
```