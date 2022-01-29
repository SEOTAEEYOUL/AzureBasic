# Azure Virtual Network

## 가격 정책
### 가상 네트워크 피어링
- 동일 지역 : GB당 $0.01

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
$vnet = @{
    Name = 'vnet-test-dev'
    ResourceGroupName = 'rg-test'
    Location = 'EastUS'
    AddressPrefix = '10.7.0.0/16'    
}
$virtualNetwork = New-AzVirtualNetwork @vnet

## Create backend subnet config ##
$subnet = @{
    Name = 'snet-test-dev-frontend'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '10.7.0.0/28'
}
$subnetConfig = New-AzVirtualNetworkSubnetConfig @subnet 

## subnet 연결
$virtualNetwork | Set-AzVirtualNetwork
```

## CLI
```bash
az group create \
  --name rg-skcc-homepage-dev \
  --location koreacentral

az network vnet create \
  --resource-group rg-skcc-homepage-dev \
  --location koreacentral \
  --name vnet-test-dev \
  --address-prefix 10.7.0.0/16 \
  --subnet-name snet-test-dev-frontend \
  --subnet-prefix 10.7.0.0/28
```