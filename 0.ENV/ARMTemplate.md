# [ARM Template](https://docs.microsoft.com/ko-kr/azure/azure-resource-manager/templates/overview)
- Azure 솔루션의 코드형 인프라를 구현(IaC)
- 명령 시퀀스를 사용하지 않고 배포(선언적)
- Azure CLI 또는 Azure PowerShell 모듈

> [Bicep 파일의 구조 및 구문 이해](https://docs.microsoft.com/ko-kr/azure/azure-resource-manager/bicep/file)  
> [빠른 시작: Visual Studio Code를 사용하여 Bicep 파일 만들기](https://docs.microsoft.com/ko-kr/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI)  
> [Azure Resource Manager (ARM) Tools](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools)
> [Introducing the Azure Az PowerShell module](https://docs.microsoft.com/ko-kr/powershell/azure/new-azureps-module-az?view=azps-7.1.0)  
> [빠른 시작: Visual Studio Code를 사용하여 ARM 템플릿 만들기](https://docs.microsoft.com/ko-kr/azure/azure-resource-manager/templates/quickstart-create-templates-use-visual-studio-code?tabs=CLI)  
> [빠른 시작: 템플릿 사양 만들기 및 배포](https://docs.microsoft.com/ko-kr/azure/azure-resource-manager/templates/quickstart-create-template-specs?tabs=azure-powershell)  
## Template 형식
- 템플릿에 포함되는 요소
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "",
  "apiProfile": "",
  "parameters": {  },
  "variables": {  },
  "functions": [  ],
  "resources": [  ],
  "outputs": {  }
}
```

## Parameter
```json
"parameters": {
  "<parameter-name>" : {
    "type" : "<type-of-parameter-value>",
    "defaultValue": "<default-value-of-parameter>",
    "allowedValues": [ "<array-of-allowed-values>" ],
    "minValue": <minimum-value-for-int>,
    "maxValue": <maximum-value-for-int>,
    "minLength": <minimum-length-for-string-or-array>,
    "maxLength": <maximum-length-for-string-or-array-parameters>,
    "metadata": {
      "description": "<description-of-the parameter>"
    }
  }
}
```

## 매개 변수
- 템플릿의 parameters 섹션에서 리소스를 배포할 때 입력할 수 있는 값을 지정
```json
"parameters": {
  "<parameter-name>" : {
    "type" : "<type-of-parameter-value>",
    "defaultValue": "<default-value-of-parameter>",
    "allowedValues": [ "<array-of-allowed-values>" ],
    "minValue": <minimum-value-for-int>,
    "maxValue": <maximum-value-for-int>,
    "minLength": <minimum-length-for-string-or-array>,
    "maxLength": <maximum-length-for-string-or-array-parameters>,
    "metadata": {
      "description": "<description-of-the parameter>"
    }
  }
}
```

## 변수
```json
"variables": {
  "<variable-name>": "<variable-value>",
  "<variable-name>": {
    <variable-complex-type-value>
  },
  "<variable-object-name>": {
    "copy": [
      {
        "name": "<name-of-array-property>",
        "count": <number-of-iterations>,
        "input": <object-or-value-to-repeat>
      }
    ]
  },
  "copy": [
    {
      "name": "<variable-array-name>",
      "count": <number-of-iterations>,
      "input": <object-or-value-to-repeat>
    }
  ]
}
```

## 템플릿 배포
### Azure CLI
```bash
az deployment group create --resource-group arm-vscode --template-file azuredeploy.json --parameters azuredeploy.parameters.json
```

### PowerShell
```powershell
$resourceGroupName="rg-skcc-homepage-dev"
$locationName="koreacentral"
$templateFile="azuredeploy.json"
New-AzResourceGroup`
  -Name $resourceGroupName `
  -Location $locationName
New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFileName
```
