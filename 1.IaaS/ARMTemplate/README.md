# ARM Template 예제

## ARM Template 목록
| 파일명 | 설명 |  
|:---|:---|
| vnet-deploy | Virtual Network 생성 |  
| vnet-peering | Virtual Network Peering 생성 |
| nsg-deploy | Network Security Group 생성 |  
| storage-account-deploy | Stroage Account 생성 |  
| public-ip-deploy | Public IP Address 만들기 |  
| nic-deploy | Azure Network Interface 만들기 | 
| vm-deploy |  VM 만들기 |  
| mysql-deploy | MySQL 만들기 |  
| mysql-private-endpoint-deploy | MySQL private endpoint 만들기 |  
| arm.ps1 | ARM Templat 배포 테스트 파일 |  

## ARM Templat 배포 테스트 파일
### arm.ps1
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

### 실행 로고
```
PS C:\Users\taeey\pipeline-exam1> ./arm.ps1
deploy mysql-deploy

DeploymentName          : mysql-deploy
ResourceGroupName       : rg-skcc7-homepage-dev
ProvisioningState       : Succeeded
Timestamp               : 2022-02-19 오후 1:20:41
Mode                    : Incremental
TemplateLink            : 
Parameters              : 
                          Name                          Type                       Value
                          ============================  =========================  ==========
                          serverName                    String                     mysql-skcc7-homepage
                          administratorLogin            String                     mysqladmin
                          administratorLoginPassword    SecureString
                          skuCapacity                   Int                        2
                          skuName                       String                     GP_Gen5_2
                          skuSizeMB                     Int                        5120
                          skuTier                       String                     GeneralPurpose
                          skuFamily                     String                     Gen5
                          mysqlVersion                  String                     5.7
                          location                      String                     koreacentral
                          backupRetentionDays           Int                        7
                          geoRedundantBackup            String                     Disabled
                          virtualNetworkName            String                     vnet-skcc7-dev
                          subnetName                    String                     snet-skcc7-dev-backend
                          virtualNetworkRuleName        String                     AllowSubnet

Outputs                 : 
DeploymentDebugLogLevel : 

deploy mysql-private-endpoint-deploy
DeploymentName          : mysql-private-endpoint-deploy
ResourceGroupName       : rg-skcc7-homepage-dev
ProvisioningState       : Succeeded
Timestamp               : 2022-02-19 오후 1:21:34
Mode                    : Incremental
TemplateLink            : 
Parameters              : 
                          Name                   Type                       Value
                          =====================  =========================  ==========
                          location               String                     koreacentral
                          groupName              String                     rg-skcc7-homepage-dev
                          privateEndpointName    String                     PE-skcc7homepagedevmysql
                          mysqlServerName        String                     mysql-skcc7-homepage
                          vnetName               String                     vnet-skcc7-dev
                          vnetAddressPrefix      String                     10.0.0.0/16
                          subnetName             String                     snet-skcc7-dev-backend
                          privateIpAddress       String                     10.0.1.7

Outputs                 : 
DeploymentDebugLogLevel : 


PS C:\Users\taeey\pipeline-exam1>
```

### Azure DevOps pipeline
#### azure-pipelines.yaml
```
# Starter pipeline
# Start with a minimal pipeline that you can customize to build and deploy your code.
# Add steps that build, run tests, deploy, and more:
# https://aka.ms/yaml

# triggrer:
# - master

trigger: none

pool:
  vmImage: ubuntu-latest

steps:
- bash: az --version
  displayName: 'Show Azure CLI version'

- task: AzurePowerShell@5
  displayName: MySQL 만들기
  inputs:
    azureSubscription: 'Azure subscription 1(9ebb0d63-8327-402a-bdd4-e222b01329a1)'
    ScriptType: 'InlineScript'
    azurePowerShellVersion: 'LatestVersion'
    Inline: |
      # You can write your azure powershell scripts inline here. 
      # You can also pass predefined and custom variables to this script using arguments
      $groupName = 'rg-skcc7-homepage-dev'
      $locationName = 'koreacentral'

      $jsonName = "mysql-deploy"
      
      New-AzResourceGroupDeployment `
          -ResourceGroupName $groupName `
          -TemplateFile "${jsonName}.json" `
          -TemplateParameterFile "${jsonName}.parameters.json"
```
