$groupName = 'rg-skcc7-homepage-dev'
$locationName = 'koreacentral'

$r = Get-AzResourceGroup -Name $groupName -Location $locationName
if ($r -eq $null) {
  New-AzResourceGroup -Name $groupName -Location $locationName  
}

# $jsonNames = "vnet-deploy","vnet-peering"
# $jsonNames = "keyvault-deploy"
$jsonNames = "mysql-deploy","mysql-private-endpoint-deploy"

foreach ($jsonName in $jsonNames)
{
  Write-Host "deploy $jsonName"

  New-AzResourceGroupDeployment `
      -ResourceGroupName $groupName `
      -TemplateFile "${jsonName}.json" `
      -TemplateParameterFile "${jsonName}.parameters.json"
}