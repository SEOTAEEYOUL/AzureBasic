
. ./aks-env.ps1

Write-Host ""
Write-Host "자원그룹[$groupName] 생성"
$r = az group show --resource-group $groupName | jq .name
if ($r -eq $null) {  `
  az group create `
    --tags $tags `
    --name $groupName `
    --location $locationName
}

Write-Host ""
Write-Host "---"
Write-Host "ACR[$acrName] 생성하고 로그인하기"
$a = az acr show --name $acrName --resource-group $groupName | jq .name
if ($a -eq $null) {  
  az acr create `
    --tags $tags `
    --resource-group $groupName `
    --name $acrName `
    --sku Basic
}
az acr list -o table
az acr login --name $acrName --expose-token

Write-Host ""
Write-Host "---"
Write-Host "AKS[$clusterName] 생성하고 ACR[$acrName] 붙이기"
$c = az aks show --name $clusterName --resource-group $groupName | jq .name
if ($c -eq $null) {
  az aks create `
    --tags $tags `
    --resource-group $groupName `
    --name $clusterName `
    --node-resource-group $nodeGroupName `
    --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd `
    --node-osdisk-type Ephemeral `
    --nodepool-name $nodepoolName `
    --nodepool-tags $tags `
    --node-vm-size Standard_DS3_v2 `
    --node-count 1 `
    --vm-set-type VirtualMachineScaleSets `
    --load-balancer-sku standard `
    --node-count 3 `
    --zones 1 2 3 `
    --enable-cluster-autoscaler `
    --min-count 1 `
    --max-count 4 `
    --cluster-autoscaler-profile scan-interval=30s `
    --network-plugin kubenet `
    --network-policy calico `
    --service-cidr $serviceCidr `
    --dns-service-ip $dnsServiceIp `
    --pod-cidr $podCidr `
    --docker-bridge-address $dockerBridgeAddress `
    --enable-addons http_application_routing,monitoring `
    --generate-ssh-keys `
    --attach-acr $acrName
}

az aks list --resource-group $groupName -o table 

Write-Host ""
Write-Host "---"
Write-Host "$clusterName 접속"
az aks get-credentials --resource-group $groupName --name $clusterName


Write-Host ""
Write-Host "---"
Write-Host "Kubernetes 정보 보기"
kubectl version

Write-Host ""
Write-Host "---"
Write-Host "node 보기"
kubectl get nodes

Write-Host ""
Write-Host "---"
Write-Host "pod 보기"
kubectl get pod --all-namespaces


Write-Host ""
Write-Host "---"
Write-Host "AKS Update 가능 버전 보기"
az aks get-upgrades --resource-group $groupName --name $clusterName -o table