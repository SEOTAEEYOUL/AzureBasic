# Azure CDN(Content Delivery Network)  
사용자에게 웹 콘텐츠를 효율적으로 제공할 수 있는 서버의 분산 네트워크

* [New-AzResourceGroupDeployment](https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroupdeployment?view=azps-7.1.0)


## PowerShell

### cmdlet 목록
```powershell
Get-Command -Module Az.Cdn
```

### 도움말 보기
```powershell
Get-Help Get-AzCdnProfile
```

### AzureCDN 환경 설정
```powershell
$resourceGroupName="rg-skcc-homepage-dev"
$locationName="koreacentral" # "Central US"
$cdnProfileName="skcc-homepage-dev-cdn"
$cdnSku="Standard_Akamai"
$originName="www"
$originHostName="skcchomepage.koreacentral.cloudapp.azure.com"
$cdnEndPointName="cdnposhdoc"
```

### Azure CDN 프로필 보기
```powershell
Get-AzCdnProfile

# Output the name of all profiles on this subscription.
Get-AzCdnProfile | ForEach-Object { Write-Host $_.Name }

# Return only **Azure CDN from Verizon** profiles.
Get-AzCdnProfile | Where-Object { $_.Sku.Name -eq "Standard_Verizon" }

Get-AzCdnProfile -ProfileName $cdnProfileName -ResourceGroupName $resourceGroupName

# Get a single endpoint.
Get-AzCdnEndpoint -ProfileName $cdnProfileName -ResourceGroupName $resourceGroupName -EndpointName cdndocdemo

# Get all of the endpoints on a given profile. 
Get-AzCdnEndpoint -ProfileName $cdnProfileName -ResourceGroupName $resourceGroupName

# Return all of the endpoints on all of the profiles.
Get-AzCdnProfile | Get-AzCdnEndpoint

# Return all of the endpoints in this subscription that are currently running.
Get-AzCdnProfile | Get-AzCdnEndpoint | Where-Object { $_.ResourceState -eq "Running" }
```

### CDN Profile
```powershell
# Create a new profile
New-AzCdnProfile `
  -ProfileName $cdnProfileName `
  -ResourceGroupName CdnDemoRG `
  -Sku $cdnSku `
  -Location $locationName
```

### CDN Endpoint 만들기
```powershell
# Create a new endpoint
New-AzCdnEndpoint `
  -ProfileName $cdnProfileName `
  -ResourceGroupName CdnDemoRG `
  -Location $locationName `
  -EndpointName cdnposhdoc `
  -OriginName $originName `
  -OriginHostName $originHostName

# Create a new profile and endpoint (same as above) in one line
New-AzCdnProfile `
  -ProfileName $cdnProfileName `
  -ResourceGroupName CdnDemoRG `
  -Sku $cdnSku `
  -Location $locationName | `
    New-AzCdnEndpoint `
      -EndpointName cdnposhdoc `
      -OriginName $originName `
      -OriginHostName $originHostName
```

### 엔드 포인트 이름 가용성 확인
```powershell
# Retrieve availability
$availability = `
  Get-AzCdnEndpointNameAvailability `
    -EndpointName "cdnposhdoc"

# If available, write a message to the console.
If($availability.NameAvailable) { Write-Host "Yes, that endpoint name is available." }
Else { Write-Host "No, that endpoint name is not available." }
```

## ARMTemplate
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "metadata": {
    "_generator": {
      "name": "bicep",
      "version": "0.4.1008.15138",
      "templateHash": "5054081787892083176"
    }
  },
  "parameters": {
    "profileName": {
      "type": "string",
      "metadata": {
        "description": "Name of the CDN Profile"
      }
    },
    "endpointName": {
      "type": "string",
      "metadata": {
        "description": "Name of the CDN Endpoint, must be unique"
      }
    },
    "originUrl": {
      "type": "string",
      "metadata": {
        "description": "Url of the origin"
      }
    },
    "CDNSku": {
      "type": "string",
      "defaultValue": "Standard_Microsoft",
      "allowedValues": [
        "Standard_Akamai",
        "Standard_Microsoft",
        "Standard_Verizon",
        "Premium_Verizon"
      ],
      "metadata": {
        "description": "CDN SKU names"
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for all resources."
      }
    }
  },
  "functions": [],
  "resources": [
    {
      "type": "Microsoft.Cdn/profiles",
      "apiVersion": "2020-04-15",
      "name": "[parameters('profileName')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "[parameters('CDNSku')]"
      }
    },
    {
      "type": "Microsoft.Cdn/profiles/endpoints",
      "apiVersion": "2020-04-15",
      "name": "[format('{0}/{1}', parameters('profileName'), parameters('endpointName'))]",
      "location": "[parameters('location')]",
      "properties": {
        "originHostHeader": "[parameters('originUrl')]",
        "isHttpAllowed": true,
        "isHttpsAllowed": true,
        "queryStringCachingBehavior": "IgnoreQueryString",
        "contentTypesToCompress": [
          "application/eot",
          "application/font",
          "application/font-sfnt",
          "application/javascript",
          "application/json",
          "application/opentype",
          "application/otf",
          "application/pkcs7-mime",
          "application/truetype",
          "application/ttf",
          "application/vnd.ms-fontobject",
          "application/xhtml+xml",
          "application/xml",
          "application/xml+rss",
          "application/x-font-opentype",
          "application/x-font-truetype",
          "application/x-font-ttf",
          "application/x-httpd-cgi",
          "application/x-javascript",
          "application/x-mpegurl",
          "application/x-opentype",
          "application/x-otf",
          "application/x-perl",
          "application/x-ttf",
          "font/eot",
          "font/ttf",
          "font/otf",
          "font/opentype",
          "image/svg+xml",
          "text/css",
          "text/csv",
          "text/html",
          "text/javascript",
          "text/js",
          "text/plain",
          "text/richtext",
          "text/tab-separated-values",
          "text/xml",
          "text/x-script",
          "text/x-component",
          "text/x-java-source"
        ],
        "isCompressionEnabled": true,
        "origins": [
          {
            "name": "origin1",
            "properties": {
              "hostName": "[parameters('originUrl')]"
            }
          }
        ]
      },
      "dependsOn": [
        "[resourceId('Microsoft.Cdn/profiles', parameters('profileName'))]"
      ]
    }
  ]
}
```

```powershell
# $location = Read-Host -Prompt "Enter the location (i.e. eastus)"
$locationName = "global"
$resourceGroupName = "rg-skcc-homepage-dev"

$templateUri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.cdn/cdn-with-custom-origin/azuredeploy.json"


# New-AzResourceGroup`
#  -Name $resourceGroupName `
#  -Location $locationName
New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile azure-cdn-deploy.json
#  -TemplateUri $templateUri
```
```
$tags = @{
  owner='SeoTaeYeol'
  environment='dev'
  serviceTitle='homepage'
  personalInformation='no'
}
New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile azure-cdn-deploy.json `
  -TemplateParameterFile azure-cdn-param.json ` 
  -Tag $tags
```
![Deploy to Azure](https://aka.ms/deploytoazurebutton)