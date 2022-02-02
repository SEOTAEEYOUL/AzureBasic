# Azure Virtual Network
Private Network 로 Azure VM(Virtual Machines)과 같은 다양한 형식의 Azure 리소스가 서로, 인터넷 및 특정 온-프레미스 네트워크와 안전하게 통신
## 가상 네트워크 피어링
### 가격 정책
- 동일 지역 : GB당 $0.01
### 가상 네트워크 주소공간
- 가상 네트워크 간의 주소 공간이 겹칠 경우 가상 네트워크는 피어링을 할 수 없음

## Portal
가상 네트워크 > +만들기
### 기본사항
- 프로젝트 정보
  - 리소스 그룹 : 새로만들기 : rg-test
- 인스턴스 정보
  - 이름 : vnet-test-dev
  - 지역 : Korea Central
### IP 주소
- IPv4 주소공간 : 10.7.0.0/16
- +서브넷 추가
  - 서브넷 이름: snet-test-dev-frontend
  - 서브넷 주소 범위 : 10.7.0.0/28
  - frontend subnet : snet-skcc-dev-frontend
  - backend subnet : snet-skcc-dev-backend
### 보안
- BastionHost : 사용 안 함
- DDoS Protection 표준 : 사용 안함
- 방화벽 : 사용 안함
### 태그
- environment='dev'
- serviceTitle='test'
- personalInformation='no'
![AzVNet-Create.png](./img/AzVNet-Create.png)

## PowerShell
```powershell

$groupName = "rg-skcc-homepage-dev"
$locationName = "koreacentral"

$vnetName = "vnet-skcc-dev"
$vnetAddressPrefix = '10.0.0.0/16'

$subnetFrontendName = 'snet-skcc-dev-frontend'
$subnetFronendAddressPrefix = '10.0.0.0/28'
$subnetBackendName = 'snet-skcc-dev-backend'
$subnetAddressPrefix = '10.0.1.0/28'

$tags = @{
  owner='SeoTaeYeol'
  environment='dev'
  serviceTitle='homepage'
  personalInformation='no'
}

$vnet = @{
    Name = $vnetName
    ResourceGroupName = $groupName
    Location = $locationName
    AddressPrefix = $vnetAddressPrefix    
    Tag = $tags    
}
$virtualNetwork = New-AzVirtualNetwork @vnet

Write-Host "# subnet 만들기"
Write-Host "## Create frontend subnet config ##"
$subnet_frontend = @{
    Name = $subnetFrontendName
    VirtualNetwork = $virtualNetwork
    AddressPrefix = $subnetFronendAddressPrefix
}
$subnetConfig_frontend = Add-AzVirtualNetworkSubnetConfig @subnet_frontend

Write-Host "## Create backend subnet config ##"
$subnet_backend = @{
    Name = $subnetBackendName
    VirtualNetwork = $virtualNetwork
    AddressPrefix = $subnetAddressPrefix
}
$subnetConfig_backend = Add-AzVirtualNetworkSubnetConfig @subnet_backend

Write-Host "## 가상 네트워크에 subnet 연결"
$virtualNetwork | Set-AzVirtualNetwork
```


## CLI
### 생성하기
```bash
#!/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"

vnetName="vnet-skcc1-dev"
vnetAddressPrefix='10.0.0.0/16'

subnetFrontendName='snet-skcc1-dev-frontend'
subnetFrontendAddressPrefix='10.0.0.0/28'
subnetBackendName='snet-skcc1-dev-backend'
subnetBackendAddressPrefix='10.0.1.0/28'

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

az network vnet create \
  --resource-group $groupName \
  --location $locationName \
  --name $vnetName \
  --address-prefix $vnetAddressPrefix \
  --subnet-name $subnetFrontendName \
  --subnet-prefix $subnetFrontendAddressPrefix \
  --tags $tags

az network vnet subnet create \
  -n $subnetBackendName  \
  --vnet-name $vnetName \
  -g $groupName \
  --address-prefixes $subnetBackendAddressPrefix
```
### 삭제하기
```bash
az group delete -n $groupName
```