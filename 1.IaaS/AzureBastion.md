# Azure Bastion

> [Azure CLI를 사용하여 Bastion 배포](https://docs.microsoft.com/ko-kr/azure/bastion/create-host-cli)  
> [Azure PowerShell 사용하여 호스트 크기 조정 구성](https://docs.microsoft.com/ko-kr/azure/bastion/configure-host-scaling-powershell)  

## 구독 설정
```
PS D:\workspace\AzureBasic> az account list -o table
Name                   CloudName    SubscriptionId                        State    IsDefault
---------------------  -----------  ------------------------------------  -------  -----------
SK Square-LandingZone  AzureCloud   cfefd3da-b6d9-443c-9f08-d238a6f76c18  Enabled  False
SK Square-Test         AzureCloud   ad86c393-a0e5-4b09-9648-3d732b1f85f7  Enabled  False
SK Square-Dev          AzureCloud   d9bc4c6a-bb13-4ec6-9ad1-6361d443ee7e  Enabled  False
SK Square-Prd          AzureCloud   afa6d7c8-61ad-4faa-9809-022a344d120f  Enabled  False
Azure subscription 1   AzureCloud   9ebb0d63-8327-402a-bdd4-e222b01329a1  Enabled  True
PS D:\workspace\AzureBasic> az account set -s cfefd3da-b6d9-443c-9f08-d238a6f76c18
PS D:\workspace\AzureBasic> az account list -o table
Name                   CloudName    SubscriptionId                        State    IsDefault
---------------------  -----------  ------------------------------------  -------  -----------
SK Square-LandingZone  AzureCloud   cfefd3da-b6d9-443c-9f08-d238a6f76c18  Enabled  True
SK Square-Test         AzureCloud   ad86c393-a0e5-4b09-9648-3d732b1f85f7  Enabled  False
SK Square-Dev          AzureCloud   d9bc4c6a-bb13-4ec6-9ad1-6361d443ee7e  Enabled  False
SK Square-Prd          AzureCloud   afa6d7c8-61ad-4faa-9809-022a344d120f  Enabled  False
Azure subscription 1   AzureCloud   9ebb0d63-8327-402a-bdd4-e222b01329a1  Enabled  False
PS D:\workspace\AzureBasic> 
```

### 0. Login
```powershell
Connect-AzAccount
```
```
PS D:\workspace\AzureBasic> Connect-AzAccount          
WARNING: TenantId '1f5819a4-c347-48b2-9e4c-e10d169558f3' contains more than one active subscription. First one will be selected for further use. To select another subscription, use Set-AzContext.

Account                           SubscriptionName      TenantId                             Environment
-------                           ----------------      --------                             -----------
taeeyoul@sksquare.onmicrosoft.com SK Square-LandingZone 1f5819a4-c347-48b2-9e4c-e10d169558f3 AzureCloud

PS D:\workspace\AzureBasic>
```

### 1. Bastion Resource 가져오기
```powershell
$groupName = 'rg-sksq-lz-network-prd'
$bastionName = 'SKSQ-LZ-BASTION'

$bastion = Get-AzBastion `
  -Name $bastionName `
  -ResourceGroupName $groupName

$bastion.ScaleUnit
$bastion
```

```
PS D:\workspace\AzureBasic> $bastion

IpConfigurations     : {IpConf}
DnsName              : bst-74c8c33b-2646-43d8-8ddb-af63614ee836.bastion.azure.com
ProvisioningState    : Succeeded
IpConfigurationsText : [
                         {
                           "Subnet": {
                             "Id": "/subscriptions/cfefd3da-b6d9-443c-9f08-d238a6f76c18/resourceGroups/rg-sksq-lz-network-prd/providers/Microsoft.Network/virtualNetworks/vnet-sksq- 
                       lz-prd/subnets/AzureBastionSubnet"
                           },
                           "PublicIpAddress": {
                             "Id": "/subscriptions/cfefd3da-b6d9-443c-9f08-d238a6f76c18/resourceGroups/rg-sksq-lz-network-prd/providers/Microsoft.Network/publicIPAddresses/SKSQ-LZ- 
                       BASTION-pip"
                           },
                           "ProvisioningState": "Succeeded",
                           "PrivateIpAllocationMethod": "Dynamic",
                           "Name": "IpConf",
                           "Etag": "W/\"2ed5f9d9-0e8e-48f6-a24e-307258da6bb5\"",
                           "Id": "/subscriptions/cfefd3da-b6d9-443c-9f08-d238a6f76c18/resourceGroups/rg-sksq-lz-network-prd/providers/Microsoft.Network/bastionHosts/SKSQ-LZ-BASTION 
                       /bastionHostIpConfigurations/IpConf"
                         }
                       ]
ResourceGroupName    : rg-sksq-lz-network-prd
Location             : koreacentral
ResourceGuid         : 
Type                 : Microsoft.Network/bastionHosts
Tag                  : {environment, servicetitle, personalinformation}
TagsTable            : 
                       Name                 Value
                       ===================  =========
                       environment          LZ
                       servicetitle         Inframgmt
                       personalinformation  No

Name                 : SKSQ-LZ-BASTION
Etag                 : W/"2ed5f9d9-0e8e-48f6-a24e-307258da6bb5"
Id                   : /subscriptions/cfefd3da-b6d9-443c-9f08-d238a6f76c18/resourceGroups/rg-sksq-lz-network-prd/providers/Microsoft.Network/bastionHosts/SKSQ-LZ-BASTION


PS D:\workspace\AzureBasic>
```

### 2. Instance 수 조정
명령어는 있으나 아직 안됨

> [Azure Portal을 사용하여 호스트 크기 조정 구성](https://docs.microsoft.com/ko-kr/azure/bastion/configure-host-scaling)  
```powershell
$bastion.ScaleUnit = 14
Set-AzBastion -InputObject $bastion
```

