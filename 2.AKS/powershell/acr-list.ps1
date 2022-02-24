. ./acr-env.ps1

az acr list -o table

Write-Host ""
Write-Host "[${acrName}] repository list"
az acr repository list -o table -n $acrName

Write-Host ""
Write-Host "[${acrName}:${repositoryName}] tag list"
az acr repository show-tags -o table -n $acrName --repository ${repositoryName}
