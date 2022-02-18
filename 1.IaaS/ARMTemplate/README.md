# ARM Template 예제

## ARM Template 목록
| 파일명 | 설명 |  
|:---|:---|
| vnet-deploy | Virtual Network 생성 |  
| nsg-deploy | Network Security Group 생성 |  
| storage-account-deploy | Stroage Account 생성 |  
| public-ip-deploy | Public IP Address 만들기 |  
| nic-deploy | Azure Network Interface 만들기 | 
| vm-deploy |  VM 만들기 |  
| mysql-deploy | MySQL 만들기 |  
| mysql-private-endpoint-deploy | MySQL private endpoint 만들기 |  
| arm.ps1 | ARM Templat 배포 테스트 파일 |  

## ARM Templat 배포 테스트 파일
arm.ps1
```powershell
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
```
