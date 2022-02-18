$groupName = 'rg-skcc7-homepage-dev'
$locationName = 'koreacentral'

$jsonNames = "mysql-deploy","mysql-private-endpoint-deploy"

foreach ($jsonName in $jsonNames)
{
  Write-Host "deploy $jsonName"

  New-AzResourceGroupDeployment `
      -ResourceGroupName $groupName `
      -TemplateFile "${jsonName}.json" `
      -TemplateParameterFile "${jsonName}.parameters.json"
}