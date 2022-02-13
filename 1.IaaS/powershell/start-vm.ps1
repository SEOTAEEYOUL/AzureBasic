$groupName='rg-skcc1-homepage-dev'
$vmNames= "vm-skcc1-comdap1","vm-skcc1-comdpt1"

foreach ($vmName in $vmNames)
{
  Write-Host "start vm $vmName"
  az vm start `
    --resource-group $groupName `
    --name $vmName
  
  az vm get-instance-view `
  --name $vmName `
  --resource-group $groupName `
  --query instanceView.statuses[1] `
  --output table
}

# 그룹의 VM 전체를 기동
<#
az vm start --ids $(az vm list -g $groupName --query "[].id" -o tsv)
#>