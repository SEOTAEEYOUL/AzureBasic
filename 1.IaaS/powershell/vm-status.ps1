$groupName='rg-skcc1-homepage-dev'
$vmNames= "vm-skcc1-comdap1","vm-skcc1-comdpt1"

foreach ($vmName in $vmNames)
{
  Write-Host "vm $vmName Status"
  
  az vm get-instance-view `
  --name $vmName `
  --resource-group $groupName `
  --query instanceView.statuses[1] `
  --output table

  az vm show `
    --name $vmName `
    --resource-group $groupName | jq '{name, diagnosticsProfile}'
}