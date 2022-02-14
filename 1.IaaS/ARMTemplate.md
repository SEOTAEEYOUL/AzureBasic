# ARM(Azure Resource Management) Template

## 리소스 그룹에 배포하기

### 리소스 그룹 배포
#### bash
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "variables": {},
  "resources": []
}
```
```bash
groupName='rg-skcc7-homepage-dev'
templateName='rg-skcc7-homepage-dev.json'
az deployment group create \
  --resource-group $groupName \
  --template-file $templateName
```

#### PowerShell
```powershell
$groupName='rg-skcc7-homepage-dev'
$templateName='rg-skcc7-homepage-dev.json'
New-AzResourceGroupDeployment `
  -ResourceGroupName $groupName `
  -TemplateFile $templateName
```
