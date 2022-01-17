# application-gateway.ps1 의 수행 결과 

```powershell
PS C:\workspace\AzureBasic\1.IaaS> ./application-gateway.ps1

WARNING: Upcoming breaking changes in the cmdlet 'New-AzVirtualNetworkSubnetConfig' :
Update Property Name
Cmdlet invocation changes :
    Old Way : -ResourceId
    New Way : -NatGatewayId
Update Property Name
Cmdlet invocation changes :
    Old Way : -InputObject
    New Way : -NatGateway
Note : Go to https://aka.ms/azps-changewarnings for steps to suppress this breaking change warning, and other information on breaking changes in Azure PowerShell.
WARNING: Upcoming breaking changes in the cmdlet 'New-AzVirtualNetworkSubnetConfig' :
Update Property Name
Cmdlet invocation changes :
    Old Way : -ResourceId
    New Way : -NatGatewayId
Update Property Name
Cmdlet invocation changes :
    Old Way : -InputObject
    New Way : -NatGateway
Note : Go to https://aka.ms/azps-changewarnings for steps to suppress this breaking change warning, and other information on breaking changes in Azure PowerShell.

Name                   : vnet-skcc-ag
ResourceGroupName      : rg-skcc-ag
Location               : koreacentral
Id                     : /subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/virtualNetworks/vnet-skcc-ag
Etag                   : W/"edee788a-1705-4b66-ab71-8fbf8bbf68d8"
ResourceGuid           : ce638a0f-7467-42e7-b4ef-7393f65901c4
ProvisioningState      : Succeeded
Tags                   : 
AddressSpace           : {
                           "AddressPrefixes": [
                             "10.21.0.0/16"
                           ]
                         }
DhcpOptions            : {}
Subnets                : [
                           {
                             "Delegations": [],
                             "Name": "snet-skcc-ag",
                             "Etag": "W/\"edee788a-1705-4b66-ab71-8fbf8bbf68d8\"",
                             "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/virtualNetworks/vnet-skcc-ag/subnets/snet-skcc-a 
                         g",
                             "AddressPrefix": [
                               "10.21.0.0/24"
                             ],
                             "IpConfigurations": [],
                             "ServiceAssociationLinks": [],
                             "ResourceNavigationLinks": [],
                             "ServiceEndpoints": [],
                             "ServiceEndpointPolicies": [],
                             "PrivateEndpoints": [],
                             "ProvisioningState": "Succeeded",
                             "PrivateEndpointNetworkPolicies": "Enabled",
                             "PrivateLinkServiceNetworkPolicies": "Enabled",
                             "IpAllocations": []
                           },
                           {
                             "Delegations": [],
                             "Name": "snet-skcc-backend",
                             "Etag": "W/\"edee788a-1705-4b66-ab71-8fbf8bbf68d8\"",
                             "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/virtualNetworks/vnet-skcc-ag/subnets/snet-skcc-b 
                         ackend",
                             "AddressPrefix": [
                               "10.21.1.0/24"
                             ],
                             "IpConfigurations": [],
                             "ServiceAssociationLinks": [],
                             "ResourceNavigationLinks": [],
                             "ServiceEndpoints": [],
                             "ServiceEndpointPolicies": [],
                             "PrivateEndpoints": [],
                             "ProvisioningState": "Succeeded",
                             "PrivateEndpointNetworkPolicies": "Enabled",
                             "PrivateLinkServiceNetworkPolicies": "Enabled",
                             "IpAllocations": []
                           }
                         ]
VirtualNetworkPeerings : []
EnableDdosProtection   : false
DdosProtectionPlan     : null

WARNING: Upcoming breaking changes in the cmdlet 'New-AzPublicIpAddress' :
Default behaviour of Zone will be changed
Cmdlet invocation changes :
    Old Way : Sku = Standard means the Standard Public IP is zone-redundant.
    New Way : Sku = Standard and Zone = {} means the Standard Public IP has no zones. If you want to create a zone-redundant Public IP address, please specify all the zones in the region. For example, Zone = ['1', '2', '3'].
Note : Go to https://aka.ms/azps-changewarnings for steps to suppress this breaking change warning, and other information on breaking changes in Azure PowerShell.

PublicIpAllocationMethod : Static
Sku                      : Microsoft.Azure.Commands.Network.Models.PSPublicIpAddressSku
IpConfiguration          : 
DnsSettings              : 
IpTags                   : {}
IpAddress                : 20.196.196.53
PublicIpAddressVersion   : IPv4
IdleTimeoutInMinutes     : 4
Zones                    : {}
ProvisioningState        : Succeeded
PublicIpPrefix           : 
IpConfigurationText      : null
DnsSettingsText          : null
IpTagsText               : []
SkuText                  : {
                             "Name": "Standard",
                             "Tier": "Regional"
                           }
PublicIpPrefixText       : null
ResourceGroupName        : rg-skcc-ag
Location                 : koreacentral
ResourceGuid             : 7020ebc2-f1dd-4fcb-87b6-5014a3ab0e6f
Type                     : Microsoft.Network/publicIPAddresses
Tag                      : 
TagsTable                : 
Name                     : pip-ag
Etag                     : W/"9dc35c7b-d431-4bdd-9dd3-f9120dde3b06"
Id                       : /subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/publicIPAddresses/pip-ag

WARNING: Upcoming breaking changes in the cmdlet 'New-AzApplicationGatewayBackendHttpSetting' :
New-AzApplicationGatewayBackendHttpSettings alias will be removed in an upcoming breaking change release
- The change is expected to take effect from the version : '2.0.0'
Note : Go to https://aka.ms/azps-changewarnings for steps to suppress this breaking change warning, and other information on breaking changes in Azure PowerShell.

Sku                                 : Microsoft.Azure.Commands.Network.Models.PSApplicationGatewaySku
SslPolicy                           : 
GatewayIPConfigurations             : {ag-ip-cfg}
AuthenticationCertificates          : {}
SslCertificates                     : {}
TrustedRootCertificates             : {}
TrustedClientCertificates           : {}
FrontendIPConfigurations            : {ag-fe-cfg}
FrontendPorts                       : {ag-fe-port}
Probes                              : {}
BackendAddressPools                 : {ag-be-pool}
BackendHttpSettingsCollection       : {ag-be-http-setting}
SslProfiles                         : {}
HttpListeners                       : {ag-listener}
UrlPathMaps                         : {}
RequestRoutingRules                 : {ag-fe-rule1}
RewriteRuleSets                     : {}
RedirectConfigurations              : {}
WebApplicationFirewallConfiguration : 
FirewallPolicy                      : 
AutoscaleConfiguration              : 
CustomErrorConfigurations           : {}
PrivateLinkConfigurations           : {}
PrivateEndpointConnections          : {}
EnableHttp2                         : 
EnableFips                          : 
ForceFirewallPolicyAssociation      : 
Zones                               : {}
OperationalState                    : Running
ProvisioningState                   : Succeeded
Identity                            : 
GatewayIpConfigurationsText         : [
                                        {
                                          "Subnet": {
                                            "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/virtualNetworks/vnet-skcc-ag/subn 
                                      ets/snet-skcc-ag"
                                          },
                                          "ProvisioningState": "Succeeded",
                                          "Type": "Microsoft.Network/applicationGateways/gatewayIPConfigurations",
                                          "Name": "ag-ip-cfg",
                                          "Etag": "W/\"103a3af8-470e-48fd-9267-ae01728eec43\"",
                                          "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/gateway 
                                      IPConfigurations/ag-ip-cfg"
                                        }
                                      ]
TrustedClientCertificatesText       : []
AuthenticationCertificatesText      : []
SslCertificatesText                 : []
FrontendIpConfigurationsText        : [
                                        {
                                          "PrivateIPAllocationMethod": "Dynamic",
                                          "PublicIPAddress": {
                                            "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/publicIPAddresses/pip-ag"
                                          },
                                          "ProvisioningState": "Succeeded",
                                          "Type": "Microsoft.Network/applicationGateways/frontendIPConfigurations",
                                          "Name": "ag-fe-cfg",
                                          "Etag": "W/\"103a3af8-470e-48fd-9267-ae01728eec43\"",
                                          "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/fronten 
                                      dIPConfigurations/ag-fe-cfg"
                                        }
                                      ]
FrontendPortsText                   : [
                                        {
                                          "Port": 80,
                                          "ProvisioningState": "Succeeded",
                                          "Type": "Microsoft.Network/applicationGateways/frontendPorts",
                                          "Name": "ag-fe-port",
                                          "Etag": "W/\"103a3af8-470e-48fd-9267-ae01728eec43\"",
                                          "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/fronten 
                                      dPorts/ag-fe-port"
                                        }
                                      ]
BackendAddressPoolsText             : [
                                        {
                                          "BackendAddresses": [],
                                          "BackendIpConfigurations": [],
                                          "ProvisioningState": "Succeeded",
                                          "Type": "Microsoft.Network/applicationGateways/backendAddressPools",
                                          "Name": "ag-be-pool",
                                          "Etag": "W/\"103a3af8-470e-48fd-9267-ae01728eec43\"",
                                          "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/backend 
                                      AddressPools/ag-be-pool"
                                        }
                                      ]
BackendHttpSettingsCollectionText   : [
                                        {
                                          "Port": 80,
                                          "Protocol": "Http",
                                          "CookieBasedAffinity": "Enabled",
                                          "RequestTimeout": 30,
                                          "AuthenticationCertificates": [],
                                          "TrustedRootCertificates": [],
                                          "PickHostNameFromBackendAddress": false,
                                          "ProvisioningState": "Succeeded",
                                          "Type": "Microsoft.Network/applicationGateways/backendHttpSettingsCollection",
                                          "Name": "ag-be-http-setting",
                                          "Etag": "W/\"103a3af8-470e-48fd-9267-ae01728eec43\"",
                                          "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/backend 
                                      HttpSettingsCollection/ag-be-http-setting"
                                        }
                                      ]
SslProfilesText                     : []
HttpListenersText                   : [
                                        {
                                          "FrontendIpConfiguration": {
                                            "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/front 
                                      endIPConfigurations/ag-fe-cfg"
                                          },
                                          "FrontendPort": {
                                            "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/front 
                                      endPorts/ag-fe-port"
                                          },
                                          "Protocol": "Http",
                                          "HostNames": [],
                                          "RequireServerNameIndication": false,
                                          "ProvisioningState": "Succeeded",
                                          "Type": "Microsoft.Network/applicationGateways/httpListeners",
                                          "CustomErrorConfigurations": [],
                                          "Name": "ag-listener",
                                          "Etag": "W/\"103a3af8-470e-48fd-9267-ae01728eec43\"",
                                          "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/httpLis 
                                      teners/ag-listener"
                                        }
                                      ]
RewriteRuleSetsText                 : []
RequestRoutingRulesText             : [
                                        {
                                          "RuleType": "Basic",
                                          "BackendAddressPool": {
                                            "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/backe 
                                      ndAddressPools/ag-be-pool"
                                          },
                                          "BackendHttpSettings": {
                                            "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/backe 
                                      ndHttpSettingsCollection/ag-be-http-setting"
                                          },
                                          "HttpListener": {
                                            "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/httpL 
                                      isteners/ag-listener"
                                          },
                                          "ProvisioningState": "Succeeded",
                                          "Type": "Microsoft.Network/applicationGateways/requestRoutingRules",
                                          "Name": "ag-fe-rule1",
                                          "Etag": "W/\"103a3af8-470e-48fd-9267-ae01728eec43\"",
                                          "Id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc/request 
                                      RoutingRules/ag-fe-rule1"
                                        }
                                      ]
ProbesText                          : []
UrlPathMapsText                     : []
IdentityText                        : null
SslPolicyText                       : null
FirewallPolicyText                  : null
PrivateLinkConfigurationsText       : []
PrivateLinkEndpointConnectionsText  : []
ResourceGroupName                   : rg-skcc-ag
Location                            : koreacentral
ResourceGuid                        : e3a1bc7c-e6db-41c0-bf4d-0c1323e42989
Type                                : Microsoft.Network/applicationGateways
Tag                                 : 
TagsTable                           : 
Name                                : ag-skcc
Etag                                : W/"103a3af8-470e-48fd-9267-ae01728eec43"
Id                                  : /subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/applicationGateways/ag-skcc


PS C:\workspace\AzureBasic\1.IaaS> 
```