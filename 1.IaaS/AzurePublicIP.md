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

## [PowerShell](https://shell.azure.com)
<a href="https://shell.azure.com">
  <img class="cloudshell" src=./img/hdi-launch-cloud-shell.png>
</a>

### PowerShell 명령어
* [New-AzPublicIpAddress](https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-7.1.0)
* [Get-AzPublicIpAddress](https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-7.1.0)
* [Set-AzPublicIpAddress](https://docs.microsoft.com/en-us/powershell/module/az.network/set-azpublicipaddress?view=azps-7.1.0)

### Create IP tag for Internet and Routing Preference.
```powershell

## 변수 선언
$resourceGroup = "rg-skcc-ag"
$location = "koreacentral"

$agVnetName = "vnet-skcc-ag"
$agVnetPrefix = "10.21.0.0/16"

$agPulicIPName = "pip-ag"
$agDomainNameLabel = "skcchomepage"
$customFqdn = "skcchomepage.koreacentral.cloudapp.azure.com"
 

$tag = @{
    IpTagType = 'RoutingPreference'
    Tag = 'Internet'   
}
$ipTag = New-AzPublicIpTag @tag

## Create IP. ##
New-AzPublicIpAddress `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -Name $agPulicIPName `
  -AllocationMethod Static `
  -Sku Standard

$agPulicIPName = "pip-ag"
$agDomainNameLabel = "skcchomepage"
$customFqdn = "skcchomepage.koreacentral.cloudapp.azure.com"

$ip = @{
    Name = $agPulicIPName
    ResourceGroupName = $resourceGroup
    Location = $location
    Sku = 'Standard'
    AllocationMethod = 'Static'
    IpAddressVersion = 'IPv4'
    IpTag = $ipTag
    Zone = 1,2,3   
}
New-AzPublicIpAddress @ip

# Add DNS domain label of a public IP address
$publicIp = Get-AzPublicIpAddress `
  -Name $agPulicIPName `
  -ResourceGroupName $resourceGroup
$publicIp.DnsSettings = @{"DomainNameLabel" = $agDomainNameLabel}
Set-AzPublicIpAddress -PublicIpAddress $publicIp
$publicIp = Get-AzPublicIpAddress `
  -Name $agPulicIPName `
  -ResourceGroupName $resourceGroup
```
