$groupName='rg-skcc1-homepage-dev'
$vmNames= "vm-skcc1-comdap1","vm-skcc1-comdpt1"

foreach ($vmName in $vmNames)
{
  Write-Host "dealloc vm $vmName"
  az vm deallocate `
    --resource-group $groupName `
    --name $vmName
  
  az vm get-instance-view `
  --name $vmName `
  --resource-group $groupName `
  --query instanceView.statuses[1] `
  --output table
}

