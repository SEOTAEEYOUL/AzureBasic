# Azure Resource Group

|구분| 내용 |  
|:---|:---|  
| 그룹 명칭 | rg-skcchomepage-dev |  
| 태그 | owner='SeoTaeYeol' </br> environment='dev' </br>    serviceTitle='homepage' </br> personalInformation='no' |
| 잠금 | rock-homepage |

## Portal
자원그룹 > "+ 만들기" > 
![ResourceGroup-기본.png](./img/ResourceGroup-기본.png)  
![ResourceGroup-태그.png](./img/ResourceGroup-태그.png)  
![ResourceGroup-검토+만들기.png](./img/ResourceGroup-검토+만들기.png  )  
![ResourceGroup-잠금.png](./img/ResourceGroup-잠금.png)  

## PowerShell
[New-AzResourceGroup](https://docs.microsoft.com/ko-kr/powershell/module/az.resources/new-azresourcegroup?view=azps-7.1.0)  
```powershell
$groupName='rg-skcc-homepage-dev'
$locationName='koreacentral'
$tags = @{
  owner='SeoTaeYeol'
  environment='dev'
  serviceTitle='homepage'
  personalInformation='no'
}
$rg = @{
    Name = $groupName
    Location = $locationName
    Tag=$tags
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
```

## CLI
```bash
#!/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName='koreacentral'
lockName="lock-homepage"
tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

az group create --name "$groupName" \
  --location "$locationName" \
  --tags $tags

az group lock create \
  --lock-type ReadOnly \
  -n $lockName \
  -g $groupName

az group lock delete \
  --name $lockName \
  -g $groupName
```