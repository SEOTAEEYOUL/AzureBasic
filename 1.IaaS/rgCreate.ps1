Write-Host "변수 선언"
$groupName = "rg-skcc-homepage-dev"
$locationName = "koreacentral"

Write-Host "리소스 그룹 만들기"
# New-AzResourceGroup 
#   -ResourceGroupName $groupName `
#   -Location $locationName 
$rg = @{
 Name = $groupName
 Location = $locationName 
}
New-AzResourceGroup @rg

Write-Host "리소스 그룹 잠금"
New-AzResourceLock `
  -LockName LockGroup `
  -LockLevel CanNotDelete `
  -ResourceGroupName $groupName

Write-Host "리소스 그룹 잠금 확인"
Get-AzResourceLock `
  -ResourceGroupName $groupName