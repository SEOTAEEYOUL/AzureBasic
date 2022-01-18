# Azure Public IP Address
- 인터넷 리소스가 Azure 리소스에 대한 인바운드 통신을 할 수 있음
- Public IP Address 리소스를 연결할 수 있는 일부 리소스
  - Virtual machine network interfaces
  - Virtual machine scale sets
  - Public Load Balancers
  - Virtual Network Gateways (VPN/ER)
  - NAT gateways
  - Application Gateways
  - Azure Firewall
  - Bastion Host

## PowerShell 명령어
* [New-AzPublicIpAddress](https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-7.1.0)
* [Get-AzPublicIpAddress](https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-7.1.0)
* [Set-AzPublicIpAddress](https://docs.microsoft.com/en-us/powershell/module/az.network/set-azpublicipaddress?view=azps-7.1.0)

## Create IP tag for Internet and Routing Preference.
```powershell
$tag = @{
    IpTagType = 'RoutingPreference'
    Tag = 'Internet'   
}
$ipTag = New-AzPublicIpTag @tag

## Create IP. ##
$ip = @{
    Name = 'myStandardPublicIP-RP'
    ResourceGroupName = 'QuickStartCreateIP-rg'
    Location = 'eastus2'
    Sku = 'Standard'
    AllocationMethod = 'Static'
    IpAddressVersion = 'IPv4'
    IpTag = $ipTag
    Zone = 1,2,3   
}
New-AzPublicIpAddress @ip
```

```powershell
PS D:\workspace\AzureBasic\1.IaaS> Get-Help New-AzPublicIpAddress


NAME
    New-AzPublicIpAddress

SYNOPSIS
    Creates a public IP address.


SYNTAX
    New-AzPublicIpAddress -AllocationMethod {Dynamic | Static} [-AsJob] [-DefaultProfile <Microsoft.Azure.Commands.Common.Authentication.Abstractions.Core.IAzureContextContainer>] [-DomainNameLabel <System.String>] [-EdgeZone <System.String>] [-Force] [-IdleTimeoutInMinutes <System.Int32>] [-IpAddressVersion {IPv4 | IPv6}] [-IpTag <Microsoft.Azure.Commands.Network.Models.PSPublicIpTag[]>] [-Location <System.String>] [-Name <System.String>] [-PublicIpPrefix <Microsoft.Azure.Commands.Network.Models.PSPublicIpPrefix>] -ResourceGroupName <System.String> [-ReverseFqdn <System.String>] [-Sku {Basic | Standard}] [-Tag <System.Collections.Hashtable>] [-Tier {Regional | Global}] [-Zone <System.String[]>] [-Confirm] [-WhatIf] [<CommonParameters>]


DESCRIPTION
    The New-AzPublicIpAddress cmdlet creates a public IP address.


RELATED LINKS
    Online Version: https://docs.microsoft.com/powershell/module/az.network/new-azpublicipaddress
    Get-AzPublicIpAddress
    Remove-AzPublicIpAddress
    Set-AzPublicIpAddress

REMARKS
    To see the examples, type: "Get-Help New-AzPublicIpAddress -Examples"
    For more information, type: "Get-Help New-AzPublicIpAddress -Detailed"
    For technical information, type: "Get-Help New-AzPublicIpAddress -Full"
    For online help, type: "Get-Help New-AzPublicIpAddress -Online"
```