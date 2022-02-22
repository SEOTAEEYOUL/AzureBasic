# AKS 실행 결과

## 사전 준비

### 필수 구성 요소 등록
```
PS C:\workspace\AzureBasic> az feature register --namespace "Microsoft.ContainerService" --name "EnableAzureRBACPreview"
Once the feature 'EnableAzureRBACPreview' is registered, invoking 'az provider register -n Microsoft.ContainerService' is required to get the change propagated
{
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/providers/Microsoft.Features/providers/Microsoft.ContainerService/features/EnableAzureRBACPreview",
  "name": "Microsoft.ContainerService/EnableAzureRBACPreview",
  "properties": {
    "state": "Registered"
  },
  "type": "Microsoft.Features/providers/features"
}
PS C:\workspace\AzureBasic> az provider register --namespace Microsoft.OperationsManagement
PS C:\workspace\AzureBasic> az provider register --namespace Microsoft.OperationalInsights
PS C:\workspace\AzureBasic> az provider show -n Microsoft.OperationsManagement -o table
Namespace                       RegistrationPolicy    RegistrationState
------------------------------  --------------------  -------------------
Microsoft.OperationsManagement  RegistrationRequired  Registered
PS C:\workspace\AzureBasic> az provider show -n Microsoft.OperationalInsights -o table
Namespace                      RegistrationPolicy    RegistrationState
-----------------------------  --------------------  -------------------
Microsoft.OperationalInsights  RegistrationRequired  Registered
PS C:\workspace\AzureBasic> 
```

```
PS C:\workspace\AzureBasic> az aks install-cli
Downloading client to "C:\Users\taeey\.azure-kubectl\kubectl.exe" from "https://storage.googleapis.com/kubernetes-release/release/v1.23.4/bin/windows/amd64/kubectl.exe"
Please add "C:\Users\taeey\.azure-kubectl" to your search PATH so the `kubectl.exe` can be found. 2 options: 
    1. Run "set PATH=%PATH%;C:\Users\taeey\.azure-kubectl" or "$env:path += 'C:\Users\taeey\.azure-kubectl'" for PowerShell. This is good for the current command session.
    2. Update system PATH environment variable by following "Control Panel->System->Advanced->Environment Variables", and re-open the command window. You only need to do it once
Downloading client to "C:\Users\taeey\AppData\Local\Temp\tmpy3tzs7qp\kubelogin.zip" from "https://github.com/Azure/kubelogin/releases/download/v0.0.11/kubelogin.zip"
Please add "C:\Users\taeey\.azure-kubelogin" to your search PATH so the `kubelogin.exe` can be found. 2 options: 
    1. Run "set PATH=%PATH%;C:\Users\taeey\.azure-kubelogin" or "$env:path += 'C:\Users\taeey\.azure-kubelogin'" for PowerShell. This is good for the current command session.
    2. Update system PATH environment variable by following "Control Panel->System->Advanced->Environment Variables", and re-open the command window. You only need to do it once
```

## 2. 자원 그룹 생성
```
PS C:\workspace\AzureBasic> az group create --name $groupName --location $locationName
{
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc1-aks",
  "location": "koreacentral",
  "managedBy": null,
  "name": "rg-skcc1-aks",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
PS C:\workspace\AzureBasic> 
```

## 3. ACR 만들기
```
PS C:\workspace\AzureBasic> az acr create --resource-group $groupName --name $acrName --sku Basic
{
  "adminUserEnabled": false,
  "anonymousPullEnabled": false,
  "creationDate": "2022-02-22T13:18:38.480704+00:00",
  "dataEndpointEnabled": false,
  "dataEndpointHostNames": [],
  "encryption": {
    "keyVaultProperties": null,
    "status": "disabled"
  },
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc1-aks/providers/Microsoft.ContainerRegistry/registries/acrSKCC1",
  "identity": null,
  "location": "koreacentral",
  "loginServer": "acrskcc1.azurecr.io",
  "name": "acrSKCC1",
  "networkRuleBypassOptions": "AzureServices",
  "networkRuleSet": null,
  "policies": {
    "exportPolicy": {
      "status": "enabled"
    },
    "quarantinePolicy": {
      "status": "disabled"
    },
    "retentionPolicy": {
      "days": 7,
      "lastUpdatedTime": "2022-02-22T13:18:40.946285+00:00",
      "status": "disabled"
    },
    "trustPolicy": {
      "status": "disabled",
      "type": "Notary"
    }
  },
  "privateEndpointConnections": [],
  "provisioningState": "Succeeded",
  "publicNetworkAccess": "Enabled",
  "resourceGroup": "rg-skcc1-aks",
  "sku": {
    "name": "Basic",
    "tier": "Basic"
  },
  "status": null,
  "systemData": {
    "createdAt": "2022-02-22T13:18:38.480704+00:00",
    "createdBy": "ca07456@sktda.onmicrosoft.com",
    "createdByType": "User",
    "lastModifiedAt": "2022-02-22T13:18:38.480704+00:00",
    "lastModifiedBy": "ca07456@sktda.onmicrosoft.com",
    "lastModifiedByType": "User"
  },
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries",
  "zoneRedundancy": "Disabled"
}
PS C:\workspace\AzureBasic> az acr list -o table
NAME      RESOURCE GROUP    LOCATION      SKU    LOGIN SERVER         CREATION DATE         ADMIN ENABLED
--------  ----------------  ------------  -----  -------------------  --------------------  ---------------
acrSKCC1  rg-skcc1-aks      koreacentral  Basic  acrskcc1.azurecr.io  2022-02-22T13:18:38Z  False
PS C:\workspace\AzureBasic> az acr login --name $acrName
You may want to use 'az acr login -n acrSKCC1 --expose-token' to get an access token, which does not require Docker to be installed.
An error occurred: DOCKER_COMMAND_ERROR
error during connect: Get http://%2F%2F.%2Fpipe%2Fdocker_engine/v1.40/containers/json: open //./pipe/docker_engine: The system cannot find the file specified. In the default daemon configuration on Windows, the docker client must be run elevated to connect. This error may also indicate that the docker daemon is not running.

PS C:\workspace\AzureBasic> az acr login --name $acrName --expose-token
You can perform manual login using the provided access token below, for example: 'docker login loginServer -u 00000000-0000-0000-0000-000000000000 -p accessToken'
{
  "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlVWVzc6T1JDQjozVkNIOjY2UEI6R1kyWjpOU01KOldIVVE6Qjc3WDpLWTdaOlRaU1A6UkZZWDpIVTdRIn0.eyJqdGkiOiJmNDI2NGZkYS1lYjg1LTQwNDgtOTk5Yi0yNzFmOWJiZjc4ZTAiLCJzdWIiOiJjYTA3NDU2QHNrdGRhLm9ubWljcm9zb2Z0LmNvbSIsIm5iZiI6MTY0NTUzNTA4MSwiZXhwIjoxNjQ1NTQ2NzgxLCJpYXQiOjE2NDU1MzUwODEsImlzcyI6IkF6dXJlIENvbnRhaW5lciBSZWdpc3RyeSIsImF1ZCI6ImFjcnNrY2MxLmF6dXJlY3IuaW8iLCJ2ZXJzaW9uIjoiMS4wIiwicmlkIjoiNDBhN2Q5MWY2YjFkNGJmYjg2MmE2OGU2NDg2MDE2YzIiLCJncmFudF90eXBlIjoicmVmcmVzaF90b2tlbiIsImFwcGlkIjoiMDRiMDc3OTUtOGRkYi00NjFhLWJiZWUtMDJmOWUxYmY3YjQ2IiwidGVuYW50IjoiMTYwYmFjZWEtNzc2MS00YzgzLWJmYTAtMzU0ZjliMDQ3ZjVhIiwicGVybWlzc2lvbnMiOnsiQWN0aW9ucyI6WyJyZWFkIiwid3JpdGUiLCJkZWxldGUiXSwiTm90QWN0aW9ucyI6bnVsbH0sInJvbGVzIjpbXX0.jKqYghU5TiQolIRYvRyM9yKCgr5rhwoLrhDok0stxgE_mLhstvGsRc2_LQR0Xw1rCHRs1AQa1mPiFzw5XxKfdmzdj1h9XFTAuDzKP6PCWPpcvV-P5MY9Bi2dFhZWZu-OAsI_GaQ1NFobCb1SXyiDfMpL84VuXjvjvoSA4vvXqDPnEHDM31XWQy1YVmwgX8z-12np5ZQK0Xovg1tnY1RiTUodooLdoPNtFT4ku2JWC38hHjG3aCH7Pr84GRTG4k_NBUVWufMQuS3dMQgeD-cWOvxrJDIWmdql9jieYRkjXqQ5pbZP9QJDhFChMCyOcAxajOe8Ag7MPpaRj_Qb0Qgamg",
  "loginServer": "acrskcc1.azurecr.io"
}
PS C:\workspace\AzureBasic> 
```

## 4. AKS 클러스터 만들기
```
PS C:\workspace\AzureBasic\2.AKS\powershell> ./aks-create.ps1
AKS 변수 선언

자원그룹[rg-skcc1-aks] 생성
ERROR: (ResourceGroupNotFound) Resource group 'rg-skcc1-aks' could not be found.
Code: ResourceGroupNotFound
Message: Resource group 'rg-skcc1-aks' could not be found.
{
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc1-aks",
  "location": "koreacentral",
  "managedBy": null,
  "name": "rg-skcc1-aks",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}

---
PS C:\workspace\AzureBasic\2.AKS\powershell> ./aks-create.ps1
AKS 변수 선언

자원그룹[rg-skcc1-aks] 생성
ERROR: (ResourceGroupNotFound) Resource group 'rg-skcc1-aks' could not be found.
Code: ResourceGroupNotFound
Message: Resource group 'rg-skcc1-aks' could not be found.
{
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc1-aks",
  "location": "koreacentral",
  "managedBy": null,
  "name": "rg-skcc1-aks",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}

---
ACR[acrHomepage] 생성하고 로그인하기
ERROR: (ResourceNotFound) The Resource 'Microsoft.ContainerRegistry/registries/acrHomepage' under resource group 'rg-skcc1-aks' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix
Code: ResourceNotFound
Message: The Resource 'Microsoft.ContainerRegistry/registries/acrHomepage' under resource group 'rg-skcc1-aks' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix    
{
  "adminUserEnabled": false,
  "anonymousPullEnabled": false,
  "creationDate": "2022-02-22T15:12:25.956273+00:00",
  "dataEndpointEnabled": false,
  "dataEndpointHostNames": [],
  "encryption": {
    "keyVaultProperties": null,
    "status": "disabled"
  },
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc1-aks/providers/Microsoft.ContainerRegistry/registries/acrHomepage",
  "identity": null,
  "location": "koreacentral",
  "loginServer": "acrhomepage.azurecr.io",
  "name": "acrHomepage",
  "networkRuleBypassOptions": "AzureServices",
  "networkRuleSet": null,
  "policies": {
    "exportPolicy": {
      "status": "enabled"
    },
    "quarantinePolicy": {
      "status": "disabled"
    },
    "retentionPolicy": {
      "days": 7,
      "lastUpdatedTime": "2022-02-22T15:12:28.420194+00:00",
      "status": "disabled"
    },
    "trustPolicy": {
      "status": "disabled",
      "type": "Notary"
    }
  },
  "privateEndpointConnections": [],
  "provisioningState": "Succeeded",
  "publicNetworkAccess": "Enabled",
  "resourceGroup": "rg-skcc1-aks",
  "sku": {
    "name": "Basic",
    "tier": "Basic"
  },
  "status": null,
  "systemData": {
    "createdAt": "2022-02-22T15:12:25.956273+00:00",
    "createdBy": "ca07456@sktda.onmicrosoft.com",
    "createdByType": "User",
    "lastModifiedAt": "2022-02-22T15:12:25.956273+00:00",
    "lastModifiedBy": "ca07456@sktda.onmicrosoft.com",
    "lastModifiedByType": "User"
  },
  "tags": {
    "owner": "SeoTaeYeol environment=Dev serviceTitle=Homepage personalInformation=No"
  },
  "type": "Microsoft.ContainerRegistry/registries",
  "zoneRedundancy": "Disabled"
}
NAME         RESOURCE GROUP    LOCATION      SKU    LOGIN SERVER            CREATION DATE         ADMIN ENABLED
-----------  ----------------  ------------  -----  ----------------------  --------------------  ---------------
acrHomepage  rg-skcc1-aks      koreacentral  Basic  acrhomepage.azurecr.io  2022-02-22T15:12:25Z  False
You can perform manual login using the provided access token below, for example: 'docker login loginServer -u 00000000-0000-0000-0000-000000000000 -p accessToken'
{
  "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlVWVzc6T1JDQjozVkNIOjY2UEI6R1kyWjpOU01KOldIVVE6Qjc3WDpLWTdaOlRaU1A6UkZZWDpIVTdRIn0.eyJqdGkiOiJmNDA1NmI1Yi0yNDI2LTRiNzMtOWQ1OS1mODFhODEzZmJhNDUiLCJzdWIiOiJjYTA3NDU2QHNrdGRhLm9ubWljcm9zb2Z0LmNvbSIsIm5iZiI6MTY0NTU0MTg2MiwiZXhwIjoxNjQ1NTUzNTYyLCJpYXQiOjE2NDU1NDE4NjIsImlzcyI6IkF6dXJlIENvbnRhaW5lciBSZWdpc3RyeSIsImF1ZCI6ImFjcmhvbWVwYWdlLmF6dXJlY3IuaW8iLCJ2ZXJzaW9uIjoiMS4wIiwicmlkIjoiZmNjMWI3NjZmYjY4NDIzYzliZDEyZDdlNGZiMThiOWEiLCJncmFudF90eXBlIjoicmVmcmVzaF90b2tlbiIsImFwcGlkIjoiMDRiMDc3OTUtOGRkYi00NjFhLWJiZWUtMDJmOWUxYmY3YjQ2IiwidGVuYW50IjoiMTYwYmFjZWEtNzc2MS00YzgzLWJmYTAtMzU0ZjliMDQ3ZjVhIiwicGVybWlzc2lvbnMiOnsiQWN0aW9ucyI6WyJyZWFkIiwid3JpdGUiLCJkZWxldGUiXSwiTm90QWN0aW9ucyI6bnVsbH0sInJvbGVzIjpbXX0.cOtFYlwhByUNf5vauYSnhJR_t2M2vYofVFhH6UF93o75oMvNPmpYxYVkLfGA7UHa3g7KKTtfDjiYXxxCEFV-vEnnUvvnB_8zv30enSLdZYUBeunUCeYuS04tcQwRma00RXVrh9OlehoU18EPvHmEeseP2rUqnaaTJPAkMj24YRBT9T7dZ5zq0QU1zxQmk5empjx8Grs8nKWUUvX8vEdoVYQ8VOMW_DRQps0a-nDyqbC0lbWs7E1qTkYuvIRWkP6pt5F_3Z5KEjdzccJh5UwoYQTwgAZQIehCEh6duoVn2q2ccaVG6yMJdC9YkjUfrnst00BdbMTp3REpz1afV37Whw",
  "loginServer": "acrhomepage.azurecr.io"
}

---
AKS[aks-cluster-Homepage] 생성하고 ACR[acrHomepage] 붙이기
WARNING: The behavior of this command has been altered by the following extension: aks-preview
ERROR: (ResourceNotFound) The Resource 'Microsoft.ContainerService/managedClusters/aks-cluster-Homepage' under resource group 'rg-skcc1-aks' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix
Code: ResourceNotFound
Message: The Resource 'Microsoft.ContainerService/managedClusters/aks-cluster-Homepage' under resource group 'rg-skcc1-aks' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix
The behavior of this command has been altered by the following extension: aks-preview
AAD role propagation done[############################################]  100.0000%{
  "aadProfile": null,
  "addonProfiles": {
    "httpApplicationRouting": {
      "config": {
        "HTTPApplicationRoutingZoneName": "f21890b84bf34f989ff7.koreacentral.aksapp.io"
      },
      "enabled": true,
      "identity": {
        "clientId": "3c0f32a1-22cb-46dc-80ca-9c9cdbc57018",
        "objectId": "e4ed3132-95d3-4275-ab99-9bf2121623f6",
        "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-Homepage/providers/Microsoft.ManagedIdentity/userAssignedIdentities/httpapplicationrouting-aks-cluster-homepage"
      }
    },
    "omsagent": {
      "config": {
        "logAnalyticsWorkspaceResourceID": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/defaultresourcegroup-se/providers/microsoft.operationalinsights/workspaces/defaultworkspace-9ebb0d63-8327-402a-bdd4-e222b01329a1-se",
        "useAADAuth": "False"
      },
      "enabled": true,
      "identity": {
        "clientId": "8b48b4e4-34dd-4389-9fc5-55dd57a11a5b",
        "objectId": "dbc737f1-9631-4982-84be-8e93a06f7521",
        "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-Homepage/providers/Microsoft.ManagedIdentity/userAssignedIdentities/omsagent-aks-cluster-homepage"
      }
    }
  },
  "agentPoolProfiles": [
    {
      "availabilityZones": [
        "1",
        "2",
        "3"
      ],
      "capacityReservationGroupId": null,
      "count": 3,
      "creationData": null,
      "enableAutoScaling": true,
      "enableEncryptionAtHost": false,
      "enableFips": false,
      "enableNodePublicIp": false,
      "enableUltraSsd": false,
      "gpuInstanceProfile": null,
      "hostGroupId": null,
      "kubeletConfig": null,
      "kubeletDiskType": "OS",
      "linuxOsConfig": null,
      "maxCount": 4,
      "maxPods": 110,
      "messageOfTheDay": null,
      "minCount": 1,
      "mode": "System",
      "name": "homepage01",
      "nodeImageVersion": "AKSUbuntu-1804gen2containerd-2022.02.07",
      "nodeLabels": null,
      "nodePublicIpPrefixId": null,
      "nodeTaints": null,
      "orchestratorVersion": "1.21.9",
      "osDiskSizeGb": 128,
      "osDiskType": "Ephemeral",
      "osSku": "Ubuntu",
      "osType": "Linux",
      "podSubnetId": null,
      "powerState": {
        "code": "Running"
      },
      "provisioningState": "Succeeded",
      "proximityPlacementGroupId": null,
      "scaleDownMode": null,
      "scaleSetEvictionPolicy": null,
      "scaleSetPriority": null,
      "spotMaxPrice": null,
      "tags": {
        "owner": "SeoTaeYeol environment=Dev serviceTitle=Homepage personalInformation=No"
      },
      "type": "VirtualMachineScaleSets",
      "upgradeSettings": null,
      "vmSize": "Standard_DS3_v2",
      "vnetSubnetId": null,
      "workloadRuntime": "OCIContainer"
    }
  ],
  "apiServerAccessProfile": null,
  "autoScalerProfile": {
    "balanceSimilarNodeGroups": "false",
    "expander": "random",
    "maxEmptyBulkDelete": "10",
    "maxGracefulTerminationSec": "600",
    "maxNodeProvisionTime": "15m",
    "maxTotalUnreadyPercentage": "45",
    "newPodScaleUpDelay": "0s",
    "okTotalUnreadyCount": "3",
    "scaleDownDelayAfterAdd": "10m",
    "scaleDownDelayAfterDelete": "10s",
    "scaleDownDelayAfterFailure": "3m",
    "scaleDownUnneededTime": "10m",
    "scaleDownUnreadyTime": "20m",
    "scaleDownUtilizationThreshold": "0.5",
    "scanInterval": "30s",
    "skipNodesWithLocalStorage": "false",
    "skipNodesWithSystemPods": "true"
  },
  "autoUpgradeProfile": null,
  "azurePortalFqdn": "aks-cluste-rg-skcc1-aks-9ebb0d-86cd84f1.portal.hcp.koreacentral.azmk8s.io",
  "currentKubernetesVersion": "1.21.9",
  "disableLocalAccounts": false,
  "diskEncryptionSetId": null,
  "dnsPrefix": "aks-cluste-rg-skcc1-aks-9ebb0d",
  "enableNamespaceResources": null,
  "enablePodSecurityPolicy": false,
  "enableRbac": true,
  "extendedLocation": null,
  "fqdn": "aks-cluste-rg-skcc1-aks-9ebb0d-86cd84f1.hcp.koreacentral.azmk8s.io",
  "fqdnSubdomain": null,
  "httpProxyConfig": null,
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-skcc1-aks/providers/Microsoft.ContainerService/managedClusters/aks-cluster-Homepage",
  "identity": {
    "principalId": "ccc33073-20b5-4827-a305-56e251a32326",
    "tenantId": "160bacea-7761-4c83-bfa0-354f9b047f5a",
    "type": "SystemAssigned",
    "userAssignedIdentities": null
  },
  "identityProfile": {
    "kubeletidentity": {
      "clientId": "2c27de1a-0174-46dc-94f2-7f821d041625",
      "objectId": "966623e8-a18a-46e7-990b-46813641e50e",
      "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-Homepage/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aks-cluster-Homepage-agentpool"
    }
  },
  "kubernetesVersion": "1.21.9",
  "linuxProfile": {
    "adminUsername": "azureuser",
    "ssh": {
      "publicKeys": [
        {
          "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJNVXjKgWVZpKhJDwzD6RGxbZcteGxnRIjV/taGzxJrtGM6ko9v5GT0nkf3Vt72huams3tiDP55yc9RdJyE/jNtyWdgREwaXwdaQr4syvLsgLlb+wMffg4wwCQPOQDKvlBALRZjct7EsYk3gfoVzT7v6xeiH48uXW9W3D+5yS30Z07j5DLYxkh83aqnrJbk9ZUFHDoIz1dA0W1aLuJLVfDIOsba6jyUUNzUIA0/5gijPbcp8i9soCsHGPetLPuichqAjeTcZfJOCbq0NJ5x22F7I6V8LnoCOMt43QW+Fm5Z3KJcyA9OKTNksKtpsNZIWPX5texh70OjPB7PKVmRGkz6x1uCu8okqtXJ8u2yXNhISZjmi9G8czUcIt5Y7kvjwzhldNmIkYmxkSMi1LD+xEkRdH+WrwWGDrK0ek+w2j93iIu3Nv5fDHwALLUoRK6uoKZ0h47GtqtZi4LIAAZ75H+dkOOuKqldv/XOHbd9pi+fxqRpsOzHsv10Ai9RnR5nz5Y8GagvOaYs/ShWxrnmBR7DBy7uybWQoo0XSdrZ4YkSNAWZJQIIBL8Iz70x2Vwh/IYVO+2Flu4XCCJJgq+sflPHKMuwmMqGqllG7bB4yPHns6smx10g/JIcMIOjfgEMe6cIHSAIdtQWpD39OOgp4I64IiayjemHbCHcIIRFTrHpQ== taeey@DESKTOP-QR555PR\n"
        }
      ]
    }
  },
  "location": "koreacentral",
  "maxAgentPools": 100,
  "name": "aks-cluster-Homepage",
  "networkProfile": {
    "dnsServiceIp": "10.0.0.10",
    "dockerBridgeCidr": "172.17.0.1/16",
    "ipFamilies": [
      "IPv4"
    ],
    "loadBalancerProfile": {
      "allocatedOutboundPorts": null,
      "effectiveOutboundIPs": [
        {
          "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aks-cluster-Homepage/providers/Microsoft.Network/publicIPAddresses/e76efbab-fe4e-4693-94ae-0952e312786e",     
          "resourceGroup": "rg-aks-cluster-Homepage"
        }
      ],
      "enableMultipleStandardLoadBalancers": null,
      "idleTimeoutInMinutes": null,
      "managedOutboundIPs": {
        "count": 1,
        "countIpv6": null
      },
      "outboundIPs": null,
      "outboundIpPrefixes": null
    },
    "loadBalancerSku": "Standard",
    "natGatewayProfile": null,
    "networkMode": null,
    "networkPlugin": "kubenet",
    "networkPolicy": "calico",
    "outboundType": "loadBalancer",
    "podCidr": "10.244.0.0/16",
    "podCidrs": [
      "10.244.0.0/16"
    ],
    "serviceCidr": "10.0.0.0/16",
    "serviceCidrs": [
      "10.0.0.0/16"
    ]
  },
  "nodeResourceGroup": "rg-aks-cluster-Homepage",
  "oidcIssuerProfile": {
    "enabled": false,
    "issuerUrl": null
  },
  "podIdentityProfile": null,
  "powerState": {
    "code": "Running"
  },
  "privateFqdn": null,
  "privateLinkResources": null,
  "provisioningState": "Succeeded",
  "publicNetworkAccess": null,
  "resourceGroup": "rg-skcc1-aks",
  "securityProfile": null,
  "servicePrincipalProfile": {
    "clientId": "msi",
    "secret": null
  },
  "sku": {
    "name": "Basic",
    "tier": "Free"
  },
  "tags": {
    "owner": "SeoTaeYeol environment=Dev serviceTitle=Homepage personalInformation=No"
  },
  "type": "Microsoft.ContainerService/ManagedClusters",
  "windowsProfile": null
}
Name                  Location      ResourceGroup    KubernetesVersion    ProvisioningState    Fqdn
--------------------  ------------  ---------------  -------------------  -------------------  ------------------------------------------------------------------
aks-cluster-Homepage  koreacentral  rg-skcc1-aks     1.21.9               Succeeded            aks-cluste-rg-skcc1-aks-9ebb0d-86cd84f1.hcp.koreacentral.azmk8s.io

---
aks-cluster-Homepage 접속
The behavior of this command has been altered by the following extension: aks-preview
A different object named aks-cluster-Homepage already exists in your kubeconfig file.
Overwrite? (y/n): y
A different object named clusterUser_rg-skcc1-aks_aks-cluster-Homepage already exists in your kubeconfig file.
Overwrite? (y/n): y
Merged "aks-cluster-Homepage" as current context in C:\Users\taeey\.kube\config

---
Kubernetes 정보 보기
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.1", GitCommit:"86ec240af8cbd1b60bcc4c03c20da9b98005b92e", GitTreeState:"clean", BuildDate:"2021-12-16T11:41:01Z", GoVersion:"go1.17.5", Compiler:"gc", Platform:"windows/amd64"}
Server Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.9", GitCommit:"88ccc7584c4460cf46e4180be83e7c4ab7a8ffb4", GitTreeState:"clean", BuildDate:"2022-01-30T02:57:18Z", GoVersion:"go1.16.12", Compiler:"gc", Platform:"linux/amd64"}
WARNING: version difference between client (1.23) and server (1.21) exceeds the supported minor version skew of +/-1

---
node 보기
NAME                                 STATUS   ROLES   AGE   VERSION
aks-homepage01-25024596-vmss000000   Ready    agent   90s   v1.21.9
aks-homepage01-25024596-vmss000001   Ready    agent   81s   v1.21.9
aks-homepage01-25024596-vmss000002   Ready    agent   84s   v1.21.9

---
pod 보기
NAMESPACE         NAME                                                              READY   STATUS    RESTARTS   AGE
calico-system     calico-kube-controllers-658ffc6ff5-2q8j4                          1/1     Running   2          74s
calico-system     calico-node-4tpd8                                                 1/1     Running   0          74s
calico-system     calico-node-4zvj2                                                 1/1     Running   0          74s
calico-system     calico-node-g89vv                                                 1/1     Running   0          74s
calico-system     calico-typha-7c5ccd85f9-mcvwz                                     1/1     Running   0          75s
calico-system     calico-typha-7c5ccd85f9-nmdsn                                     1/1     Running   0          66s
kube-system       addon-http-application-routing-external-dns-5b5db467f9-qchkn      1/1     Running   0          3m4s
kube-system       addon-http-application-routing-nginx-ingress-controller-fcm7mmh   1/1     Running   0          3m4s
kube-system       coredns-845757d86-75g2k                                           1/1     Running   0          48s
kube-system       coredns-845757d86-ptndf                                           1/1     Running   0          3m4s
kube-system       coredns-autoscaler-5f85dc856b-bt6xp                               1/1     Running   0          2m54s
kube-system       csi-azuredisk-node-tmf86                                          3/3     Running   0          85s
kube-system       csi-azuredisk-node-w692z                                          3/3     Running   0          91s
kube-system       csi-azuredisk-node-zlbwp                                          3/3     Running   0          82s
kube-system       csi-azurefile-node-424vn                                          3/3     Running   0          82s
kube-system       csi-azurefile-node-z8wt2                                          3/3     Running   0          85s
kube-system       csi-azurefile-node-zkx5p                                          3/3     Running   0          91s
kube-system       kube-proxy-7cv6z                                                  1/1     Running   0          82s
kube-system       kube-proxy-q955z                                                  1/1     Running   0          85s
kube-system       kube-proxy-shvqh                                                  1/1     Running   0          91s
kube-system       metrics-server-774f99dbf4-6q5ws                                   0/1     Running   0          3m4s
kube-system       omsagent-6s7zd                                                    2/2     Running   0          85s
kube-system       omsagent-jqnhs                                                    2/2     Running   0          91s
kube-system       omsagent-r44gg                                                    2/2     Running   0          82s
kube-system       omsagent-rs-7999d7c64b-sdvnr                                      1/1     Running   0          3m3s
kube-system       tunnelfront-dc99c586d-h4l4c                                       1/1     Running   0          2m58s
tigera-operator   tigera-operator-6d446685b7-qnwfk                                  1/1     Running   0          2m59s
---
AKS Update 가능 버전 보기
The behavior of this command has been altered by the following extension: aks-preview
Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  --------------
default  rg-skcc1-aks     1.21.9           1.22.4, 1.22.6
```