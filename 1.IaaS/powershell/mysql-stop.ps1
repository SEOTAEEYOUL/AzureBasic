$groupName='rg-skcc1-homepage-dev'
$mysqlNames= "mysql-homepage"

foreach ($mysqlName in $mysqlNames)
{
  Write-Host "MySql $mysqlName Status"  
  az mysql server stop `
    --name $vmNamysqlNameme `
    --resource-group $groupName

  Write-Host "MySql $mysqlName Status"  
  az mysql server show `
    --name $vmNamysqlNameme `
    --resource-group $groupName | jq {name, sku, userVisibleState}
}