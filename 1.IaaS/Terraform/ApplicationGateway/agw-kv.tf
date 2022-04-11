# -
# - Key Vault
# -

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "agw" {
  name                       = "${local.prefix}-hub-kv1"
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  
  # The EnableSoftDelete feature must be used for TLS termination to function properly. If you're configuring Key Vault soft-delete through the Portal, the retention period must be kept at 90 days, the default value. Application Gateway doesn't support a different retention period yet.
  soft_delete_enabled        = true 
  soft_delete_retention_days = 90
  purge_protection_enabled   = false
  sku_name                   = "standard"

  #  network_acls {
  #    default_action = "Deny"
  #    bypass         = "AzureServices"
  #  }

  tags = data.azurerm_resource_group.rg.tags
}

resource "azurerm_key_vault_access_policy" "builder" {
  key_vault_id = azurerm_key_vault.agw.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  certificate_permissions = [
    "Create",
    "Get",
    "List"
  ]
}

resource "azurerm_key_vault_access_policy" "agw" {
  key_vault_id = azurerm_key_vault.agw.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.agw.principal_id

  secret_permissions = [
    "Get",
  ]
}

resource "azurerm_key_vault_certificate" "mysite1" {
  name         = "mysite1"
  key_vault_id = azurerm_key_vault.agw.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject_alternative_names {
        dns_names = ["mysite1.com"]
      }

      subject            = "CN=mysite1.com"
      validity_in_months = 12
    }
  }
}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [azurerm_key_vault_certificate.mysite1]

  create_duration = "60s"
}