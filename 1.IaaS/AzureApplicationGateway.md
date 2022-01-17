# [Azure Application Gateway란?](https://docs.microsoft.com/ko-kr/azure/application-gateway/overview)
- [빠른 시작: Azure PowerShell을 사용하여 Azure Application Gateway를 통해 웹 트래픽 보내기](https://docs.microsoft.com/ko-kr/azure/application-gateway/quick-create-powershell)

## 리소스 그룹 만들기
```
New-AzResourceGroup -Name rg-skcc-ag -Location koreacentral
```

## 네트워크 리소스 만들기

### 1. subnet 만들기
```powershell
$agSubnetConfig = New-AzVirtualNetworkSubnetConfig `
  -Name snet-skcc-ag `
  -AddressPrefix 10.21.0.0/24
$backendSubnetConfig = New-AzVirtualNetworkSubnetConfig `
  -Name snet-skcc-backend `
  -AddressPrefix 10.21.1.0/24
```

### 2. subnet 구성이 포함된 가상 네트워크 만들기
```powershell
New-AzVirtualNetwork `
  -ResourceGroupName rg-skcc-ag `
  -Location koreacentral `
  -Name vnet-skcc-ag `
  -AddressPrefix 10.21.0.0/16 `
  -Subnet $agSubnetConfig, $backendSubnetConfig
```

### 3. 공용 IP 주소 만들기
```
New-AzPublicIpAddress `
  -ResourceGroupName rg-skcc-ag `
  -Location eastus `
  -Name myAGPublicIPAddress `
  -AllocationMethod Static `
  -Sku Standard
```

## 애플리케이션 게이트웨이 만들기
### IP 구성 및 frontend port 만들기
###