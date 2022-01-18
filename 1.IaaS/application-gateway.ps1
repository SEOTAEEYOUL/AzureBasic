# 변수 선언
$resourceGroup = "rg-skcc-ag"
$location = "koreacentral"

$agSubnetName = "snet-skcc-ag"
$agSubnetPrefix = "10.21.0.0/24"
$bacendSubnetName = "snet-skcc-backend"
$bacendSubnetPrefix = "10.21.1.0/24"

$agVnetName = "vnet-skcc-ag"
$agVnetPrefix = "10.21.0.0/16"

$agPulicIPName = "pip-ag"
$agDomainNameLabel = "skcchomepage"
$customFqdn = "skcchomepage.koreacentral.cloudapp.azure.com"

$agIPConfigName = "ag-ip-cfg"
$agFrontendIPConfigName = "ag-fe-cfg"
$agFrontendPortName = "ag-fe-port"

$agBackendPoolName = "ag-be-pool"
$agBackendPoolSettingsName = "ag-be-http-setting" 

$agListenerName = "ag-listener"
$agFrontendRule1Name = "ag-fe-rule1"

$appGatewayName = "ag-skcc"

## 네트워크 리소스 만들기
### 1. subnet 만들기
$agSubnetConfig = New-AzVirtualNetworkSubnetConfig `
  -Name $agSubnetName `
  -AddressPrefix $agSubnetPrefix
$backendSubnetConfig = New-AzVirtualNetworkSubnetConfig `
  -Name $bacendSubnetName `
  -AddressPrefix $bacendSubnetPrefix

### 2. subnet 구성이 포함된 가상 네트워크 만들기
New-AzVirtualNetwork `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -Name $agVnetName `
  -AddressPrefix $agVnetPrefix `
  -Subnet $agSubnetConfig, $backendSubnetConfig

### 3. 공용 IP 주소 만들기
New-AzPublicIpAddress `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -Name $agPulicIPName `
  -AllocationMethod Static `
  -Sku Standard
  
# Add DNS domain label of a public IP address
$publicIp = Get-AzPublicIpAddress `
  -Name $agPulicIPName `
  -ResourceGroupName $resourceGroup
$publicIp.DnsSettings = @{"DomainNameLabel" = "skcchomepage"}
Set-AzPublicIpAddress -PublicIpAddress $publicIp
$publicIp = Get-AzPublicIpAddress `
  -Name $agPulicIPName `
  -ResourceGroupName $resourceGroup

## 애플리케이션 게이트웨이 만들기
### 1. IP 구성 및 frontend port 만들기
$vnet = Get-AzVirtualNetwork `
  -ResourceGroupName $resourceGroup `
  -Name $agVnetName
$subnet = Get-AzVirtualNetworkSubnetConfig `
  -VirtualNetwork $vnet `
  -Name $agSubnetName
$pip  = Get-AzPublicIPAddress `
  -ResourceGroupName $resourceGroup `
  -Name $agPulicIPName

 
$gipconfig = New-AzApplicationGatewayIPConfiguration `
  -Name $agIPConfigName  `
  -Subnet $subnet
$fipconfig = New-AzApplicationGatewayFrontendIPConfig `
  -Name $agFrontendIPConfigName `
  -PublicIPAddress $pip
$frontendport = New-AzApplicationGatewayFrontendPort `
  -Name $agFrontendPortName `
  -Port 80

### 2. 백 엔드 풀 만들기
$backendPool = New-AzApplicationGatewayBackendAddressPool `
  -Name $agBackendPoolName
$poolSettings = New-AzApplicationGatewayBackendHttpSetting `
  -Name $agBackendPoolSettingsName `
  -Port 80 `
  -Protocol Http `
  -CookieBasedAffinity Enabled `
  -RequestTimeout 30

### 3. 수신기를 만들고 규칙을 추가
$defaultlistener = New-AzApplicationGatewayHttpListener `
  -Name $agListenerName `
  -Protocol Http `
  -FrontendIPConfiguration $fipconfig `
  -FrontendPort $frontendport
$frontendRule = New-AzApplicationGatewayRequestRoutingRule `
  -Name $agFrontendRule1Name `
  -RuleType Basic `
  -HttpListener $defaultlistener `
  -BackendAddressPool $backendPool `
  -BackendHttpSettings $poolSettings

## Application Gateway 만들기
$sku = New-AzApplicationGatewaySku `
  -Name Standard_v2 `
  -Tier Standard_v2 `
  -Capacity 2
New-AzApplicationGateway `
  -Name $appGatewayName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -BackendAddressPools $backendPool `
  -BackendHttpSettingsCollection $poolSettings `
  -FrontendIpConfigurations $fipconfig `
  -GatewayIpConfigurations $gipconfig `
  -FrontendPorts $frontendport `
  -HttpListeners $defaultlistener `
  -RequestRoutingRules $frontendRule `
  -Sku $sku