. ./acr-env.ps1

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