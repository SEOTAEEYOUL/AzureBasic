# AKS 변수 선언
Write-Host 'AKS 변수 선언'
$groupName = 'rg-skcc1-aks'
$locationName = 'koreacentral'


$serviceName = 'Homepage'
$ownerName = 'SeoTaeYeol'
$environment = 'Dev'
$personalInformation = 'No'
$tags="owner=$ownerName environment=$environment serviceTitle=$serviceName personalInformation=$personalInformation"


$acrName = 'acr' + $serviceName

$clusterName = 'aks-cluster-' + $serviceName  
$nodeGroupName = 'rg-' + $clusterName
$nodepoolName = ($serviceName).ToLower( ) + '01'


$serviceCidr = '10.0.0.0/16'
$dnsServiceIp = '10.0.0.10'
$podCidr = '10.244.0.0/16'
$dockerBridgeAddress = '172.17.0.1/16'