# 가상 네트워크 피어링
* [가상 네트워크 피어링](https://docs.microsoft.com/ko-kr/azure/virtual-network/virtual-network-peering-overview)
* [Virtual Network 가격](https://azure.microsoft.com/ko-kr/pricing/details/virtual-network/)
* [자습서: Azure Portal을 사용하여 가상 네트워크 피어링으로 가상 네트워크 연결](https://docs.microsoft.com/ko-kr/azure/virtual-network/tutorial-connect-virtual-networks-portal)  
* [Azure CLI를 사용하여 가상 네트워크 피어링으로 가상 네트워크 연결](https://docs.microsoft.com/ko-kr/azure/virtual-network/tutorial-connect-virtual-networks-cli)
* [PowerShell을 사용하여 VNet-VNet VPN Gateway 연결 구성](https://docs.microsoft.com/ko-kr/azure/vpn-gateway/vpn-gateway-vnet-vnet-rm-ps)
* [PowerShell과 함께 Application Gateway를 사용하여 엔드투엔드 TLS 구성](https://github.com/MicrosoftDocs/azure-docs.ko-kr/blob/master/articles/application-gateway/application-gateway-end-to-end-ssl-powershell.md)  
* [How to re-size Azure virtual networks that are peered—now in preview](https://azure.microsoft.com/ko-kr/blog/how-to-resize-azure-virtual-networks-that-are-peered-now-in-preview/)

## 만드는 이유
- 두 네트워크 간에 트래픽을 라우팅하는 데 사용
- 지역 간 지리적 중복 및 지리적 상태
- 분리 또는 관리 경계를 가진 지역별 다중 계층 애플리케이션


## 종류
| 가상 네트워크 피어링 | 동일한 Azure 지역 내에서 가상 네트워크를 연결 |
| 글로벌 가상 네트워크 피어링 | Azure 지역에서 가상 네트워크를 연결 |

### 1. 상 네트워크의 ID를 가져오고 ID를 변수에 저장
```powershell
# Get the id for myVirtualNetwork1.
$vNet1Id=$(az network vnet show `
  --resource-group rg-skcc-ag `
  --name vnet-skcc-ag `
  --query id --out tsv)

# Get the id for myVirtualNetwork2.
$vNet2Id=$(az network vnet show `
  --resource-group rg-skcc-homepage-dev `
  --name vnet-skcc-dev `
  --query id `
  --out tsv)
```

### 2. "vnet-skcc-ag" 에서 "vnet-skcc-dev" 로 피어링을 만듬
```powershell
az network vnet peering create `
  --name peering-vnet-skcc-ag-vnet-skcc-dev `
  --resource-group rg-skcc-ag `
  --vnet-name vnet-skcc-ag `
  --remote-vnet $vNet2Id `
  --allow-vnet-access
```

### 3. peeringState 가 Connected 로 변경되었는지 확인
```powershell
az network vnet peering show `
  --name peering-vnet-skcc-ag-vnet-skcc-dev `
  --resource-group rg-skcc-ag `
  --vnet-name vnet-skcc-ag `
  --query peeringState
```
- 두 가상 네트워크의 피어링에 대한 peeringState가 Connected가 될 때까지, 한 가상 네트워크의 리소스는 다른 가상 네트워크의 리소스와 통신할 수 없습니다.
- 시간이 좀 걸림
![vnet-skcc-ag-peering.png](./img/vnet-skcc-ag-peering.png)  
![peering-vnet-skcc-ag-vnet-skcc-dev.png](./img/peering-vnet-skcc-ag-vnet-skcc-dev.png)

### 4. 생성 조회
```powershell
az network vnet peering list -o table -g rg-skcc-ag --vnet-name vnet-skcc-ag
```

## 수행 결과
```powershell
PS C:\workspace\AzureBasic\1.IaaS> az network vnet list -o table    
                                                
Name             ResourceGroup         Location      NumSubnets    Prefixes      DnsServers    DDOSProtection
---------------  --------------------  ------------  ------------  ------------  ------------  ----------------
vnet-kubernetes  rg-kubernetes         koreacentral  1             10.0.0.0/16                 False
vnet-skcc-ag     rg-skcc-ag            koreacentral  2             10.21.0.0/16                False
vnet-skcc-dev    rg-skcc-homepage-dev  koreacentral  2             10.0.0.0/16                 False
PS C:\workspace\AzureBasic\1.IaaS> $vNet1Id=$(az network vnet show `
>>   --resource-group rg-skcc-ag `
>>   --name vnet-skcc-ag `
>>   --query id --out tsv)

PS C:\workspace\AzureBasic\1.IaaS> $vNet2Id=$(az network vnet show `
>>   --resource-group rg-skcc-homepage-dev `
>>   --name vnet-skcc-dev `
>>   --query id `
>>   --out tsv)
PS C:\workspace\AzureBasic\1.IaaS> az network vnet peering create `
>>   --name peering-vnet-skcc-ag-vnet-skcc-dev `
>>   --resource-group rg-skcc-ag `
>>   --vnet-name vnet-skcc-ag `
>>   --remote-vnet $vNet2Id `
>>   --allow-vnet-access

{
  "allowForwardedTraffic": false,
  "allowGatewayTransit": false,
  "allowVirtualNetworkAccess": true,
  "etag": "W/\"cb1cd6df-fa0e-4cb7-9a35-9a12e60a4974\"",
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-ag/providers/Microsoft.Network/virtualNetworks/vnet-skcc-ag/virtualNetworkPeerings/peering-vnet-skcc-ag-vnet-skcc-dev",
  "name": "peering-vnet-skcc-ag-vnet-skcc-dev",
  "peeringState": "Initiated",
  "provisioningState": "Succeeded",
  "remoteAddressSpace": {
    "addressPrefixes": [
      "10.0.0.0/16"
    ]
  },
  "remoteBgpCommunities": null,
  "remoteVirtualNetwork": {
    "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-homepage-dev/providers/Microsoft.Network/virtualNetworks/vnet-skcc-dev",
    "resourceGroup": "rg-skcc-homepage-dev"
  },
  "resourceGroup": "rg-skcc-ag",
  "type": "Microsoft.Network/virtualNetworks/virtualNetworkPeerings",
  "useRemoteGateways": false
}
PS C:\workspace\AzureBasic\1.IaaS> az network vnet peering show `
>>   --name peering-vnet-skcc-ag-vnet-skcc-dev `
>>   --resource-group rg-skcc-ag `
>>   --vnet-name vnet-skcc-ag `
>>   --query peeringState

"Initiated"
PS C:\workspace\AzureBasic\1.IaaS> az network vnet peering show `
>>   --name peering-vnet-skcc-ag-vnet-skcc-dev `
>>   --resource-group rg-skcc-ag `
>>   --vnet-name vnet-skcc-ag `
>>   --query peeringState

"Initiated"
PS C:\workspace\AzureBasic\1.IaaS> az network vnet peering show `
>>   --name peering-vnet-skcc-ag-vnet-skcc-dev `
>>   --resource-group rg-skcc-ag `
>>   --vnet-name vnet-skcc-ag `
>>   --query peeringState

"Initiated"
PS C:\workspace\AzureBasic\1.IaaS> az network vnet peering show `
>>   --name peering-vnet-skcc-ag-vnet-skcc-dev `
>>   --resource-group rg-skcc-ag `
>>   --vnet-name vnet-skcc-ag `
>>   --query peeringState

"Initiated"
PS C:\workspace\AzureBasic\1.IaaS> az network vnet peering show `
>>   --name peering-vnet-skcc-ag-vnet-skcc-dev `
>>   --resource-group rg-skcc-ag `
>>   --vnet-name vnet-skcc-ag `
>>   --query peeringState

"Initiated"
PS C:\workspace\AzureBasic\1.IaaS> az network vnet peering show `
>>   --name peering-vnet-skcc-ag-vnet-skcc-dev `
>>   --resource-group rg-skcc-ag `
>>   --vnet-name vnet-skcc-ag `
>>   --query peeringState

"Initiated"
PS C:\workspace\AzureBasic\1.IaaS> 
```

```powershell
PS C:\workspace\AzureBasic\1.IaaS> az network vnet peering list -o table -g rg-skcc-ag --vnet-name vnet-skcc-ag

AllowForwardedTraffic    AllowGatewayTransit    AllowVirtualNetworkAccess    Name                                PeeringState    ProvisioningState    ResourceGroup    UseRemoteGateways
-----------------------  ---------------------  ---------------------------  ----------------------------------  --------------  -------------------  ---------------  -------------------     
False                    False                  True                         peering-vnet-skcc-ag-vnet-skcc-dev  Initiated       Succeeded            rg-skcc-ag       False
PS C:\workspace\AzureBasic\1.IaaS> 
```
