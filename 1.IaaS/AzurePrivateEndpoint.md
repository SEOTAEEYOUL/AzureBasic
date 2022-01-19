# [프라이빗 엔드포인트](https://docs.microsoft.com/ko-kr/azure/private-link/private-endpoint-overview)  
- 가상 네트워크의 개인 IP 주소를 사용 하는 네트워크 인터페이스
- 네트워크 인터페이스는 개인적이 고 안전 하 게 Azure 개인 링크를 통해 제공 되는 서비스에 연결


### Azure 서비스
- Azure Storage
- Azure Cosmos DB
- Azure SQL Database

* [New-AzPrivateLinkServiceConnection](https://docs.microsoft.com/ko-kr/powershell/module/az.network/New-AzPrivateLinkServiceConnection?view=azps-7.1.0)
* [New-AzPrivateEndpoint](https://docs.microsoft.com/ko-kr/powershell/module/az.network/new-azprivateendpoint?view=azps-7.1.0)

* [빠른 시작: Azure PowerShell을 사용하여 Azure Private Endpoint 만들기](https://docs.microsoft.com/ko-kr/azure/private-link/create-private-endpoint-powershell)   


## Sample
```powershell
$location = "koreacentral"
$vnetName = "vnet-skcc-dev"
$resourceGroupName = "rg-skcc-homepage-dev"
$subnetName = "snet-skcc-dev-frontend"
$privateEndPointName = "pe-skccdevhomepagemysql"
$subscriptionId = "9ebb0d63-8327-402a-bdd4-e222b01329a1"


$virtualNetwork = Get-AzVirtualNetwork `
  -ResourceName $vnetName `
  -ResourceGroupName $resourceGroupName

$subnet = $virtualNetwork | `
  Select-Object -ExpandProperty subnets | `
    Where-Object Name -eq $subnetName
$plsConnection = `
  New-AzPrivateLinkServiceConnection `
    -Name $privateEndPointName `
    -PrivateLinkServiceId "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Network/privateLinkServices/privateLinkService" `
    -RequestMessage 'Please Approve my request'
New-AzPrivateEndpoint `
  -Name $privateEndPointName `
  -ResourceGroup $resourceGroupName `
  -Location $location `
  -PrivateLinkServiceConnection $plsConnection  `
  -Subnet $subnet
```