

Get-InstalledModule -Name "Az"

Connect-AzAccount

$resourceGroup = "<resource-group>"
$location = "<location>"
New-AzResourceGroup -Name $resourceGroup -Location $location

Get-AzLocation | select Location

New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name <account-name> `
  -Location $location `
  -SkuName Standard_RAGRS `
  -Kind StorageV2


  Remove-AzStorageAccount -Name <storage-account> -ResourceGroupName <resource-group>