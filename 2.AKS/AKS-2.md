# AKS - Azure Cloud Shell 사용

## Azure Login  
### Login  
- Azure Cloud Shell 사용시는 로그인이 필요 없고, 
- 필수 Utility 는 설치 되어 있음  
  | 설명 |  명칭 |
  | :--- | :---: |
  | Azure CLI | az |
  | Kubernetes CLI | kubectl |
  | Helm Client | helm |

### 조회하기
```
taeeyoul77@Azure:~$ az account list --output table
Name          CloudName    SubscriptionId                        State    IsDefault
------------  -----------  ------------------------------------  -------  -----------
SVC-taeeyoul  AzureCloud   cafbe447-3ee0-4523-89e3-67c483a935c5  Enabled  True
```

## Management Group
### 만들기
```
taeeyoul77@Azure:~$ az account management-group create --name 'AKS' --display-name 'AKS'
{- Finished ..
  "id": "/providers/Microsoft.Management/managementGroups/AKS",
  "name": "AKS",
  "properties": {
    "details": {
      "parent": {
        "displayName": "Tenant Root Group",
        "id": "/providers/Microsoft.Management/managementGroups/488c43cb-891e-4986-8b6b-40c2e5c7b87f",
        "name": "488c43cb-891e-4986-8b6b-40c2e5c7b87f"
      },
      "updatedBy": "bb34ae27-0906-48c0-ac67-76be82e0d7ba",
      "updatedTime": "2020-11-17T06:48:39.3637997Z",
      "version": 3
    },
    "displayName": "AKS",
    "tenantId": "488c43cb-891e-4986-8b6b-40c2e5c7b87f"
  },
  "status": "Succeeded",
  "type": "/providers/Microsoft.Management/managementGroups"
}
```

### 삭제하기
```
taeeyoul77@Azure:~$ az account management-group delete --name AKS
{- Finished ..
  "id": "/providers/Microsoft.Management/managementGroups/AKS",
  "name": "AKS",
  "provisioningState": null,
  "status": "Succeeded",
  "type": "/providers/Microsoft.Management/managementGroups"
}
```

### 조회하기
```
taeeyoul77@Azure:~$ az account management-group list --output table
DisplayName    Name    TenantId
-------------  ------  ------------------------------------
AKS            AKS     488c43cb-891e-4986-8b6b-40c2e5c7b87f
```

## 자원그룹 만들기
- AKS 를 만들기 위한 그룹 생성
```
taeeyoul77@Azure:~$ az group create --name rg_AKS --location koreacentral
{
  "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg_AKS",
  "location": "koreacentral",
  "managedBy": null,
  "name": "rg_AKS",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
taeeyoul77@Azure:~$ az group list --output table
Name                               Location       Status
---------------------------------  -------------  ---------
cloud-shell-storage-southeastasia  southeastasia  Succeeded
rg_AKS                             koreacentral   Succeeded
```

## AKS (컨테이너) 에 대한 Azure Monitor 사용 권한 확인 및 부여
### Azure Monitor 사용 권한 확인
```
taeeyoul77@Azure:~$ az provider show -n Microsoft.OperationsManagement -o table
Namespace                       RegistrationPolicy    RegistrationState
------------------------------  --------------------  -------------------
Microsoft.OperationsManagement  RegistrationRequired  NotRegistered
taeeyoul77@Azure:~$ az provider show -n Microsoft.OperationalInsights -o table
Namespace                      RegistrationPolicy    RegistrationState
-----------------------------  --------------------  -------------------
Microsoft.OperationalInsights  RegistrationRequired  NotRegistered
```
### Azure Monitor 사용 권한 부여
```
taeeyoul77@Azure:~$ az provider register --namespace Microsoft.OperationsManagement
Registering is still on-going. You can monitor using 'az provider show -n Microsoft.OperationsManagement'
taeeyoul77@Azure:~$ az provider register --namespace Microsoft.OperationalInsights
Registering is still on-going. You can monitor using 'az provider show -n Microsoft.OperationalInsights'
```

### Azure Monitor 사용 권한이 부여됨 확인
```
taeeyoul77@Azure:~$ az provider show -n Microsoft.OperationsManagement -o table
Namespace                       RegistrationPolicy    RegistrationState
------------------------------  --------------------  -------------------
Microsoft.OperationsManagement  RegistrationRequired  Registering
taeeyoul77@Azure:~$ az provider show -n Microsoft.OperationalInsights -o table
Namespace                      RegistrationPolicy    RegistrationState
-----------------------------  --------------------  -------------------
Microsoft.OperationalInsights  RegistrationRequired  Registering
```

## Azure Container Repository 만들기

### ACR 만들기(acrAKS77)
```
taeeyoul77@Azure:~$ az acr create --resource-group rg_AKS --name acrAKS77 --sku Basic
{- Finished ..
  "adminUserEnabled": false,
  "creationDate": "2020-11-17T07:29:53.922468+00:00",
  "dataEndpointEnabled": false,
  "dataEndpointHostNames": [],
  "encryption": {
    "keyVaultProperties": null,
    "status": "disabled"
  },
  "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg_AKS/providers/Microsoft.ContainerRegistry/registries/acrAKS77",
  "identity": null,
  "location": "koreacentral",
  "loginServer": "acraks77.azurecr.io",
  "name": "acrAKS77",
  "networkRuleSet": null,
  "policies": {
    "quarantinePolicy": {
      "status": "disabled"
    },
    "retentionPolicy": {
      "days": 7,
      "lastUpdatedTime": "2020-11-17T07:29:56.309814+00:00",
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
  "resourceGroup": "rg_AKS",
  "sku": {
    "name": "Basic",
    "tier": "Basic"
  },
  "status": null,
  "storageAccount": null,
  "systemData": {
    "createdAt": "2020-11-17T07:29:53.9224686+00:00",
    "createdBy": "taeeyoul77@gmail.com",
    "createdByType": "User",
    "lastModifiedAt": "2020-11-17T07:29:53.9224686+00:00",
    "lastModifiedBy": "taeeyoul77@gmail.com",
    "lastModifiedByType": "User"
  },
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries"
}
```

### ACR "acrAKS77" 생성 확인
```
taeeyoul77@Azure:~$ az acr list --output table
NAME      RESOURCE GROUP    LOCATION      SKU    LOGIN SERVER         CREATION DATE         ADMIN ENABLED
--------  ----------------  ------------  -----  -------------------  --------------------  ---------------
acrAKS77  rg_AKS            koreacentral  Basic  acraks77.azurecr.io  2020-11-17T07:29:53Z  Falseㅁ
```

### ACR "acrAKS77" token 을 얻은 후 로그인 하기
- Cloude Shell 에서는 docker daemon 이 없어 바로 로그인 안됨
- token 을 얻은 후 로그인 하는 형태를 취함
### Cloud Shell 에서 login 시 오류 메시지
```
taeeyoul77@Azure:~$ az acr login --name acrAKS77
This command requires running the docker daemon, which is not supported in Azure Cloud Shell. You may want to use 'az acr login -n acrAKS77 --expose-token' to get an access token, which does not require Docker to be installed.
```

### token 얻기
```
taeeyoul77@Azure:~$ az acr login --name acrAKS77 --expose-token
You can perform manual login using the provided access token below, for example: 'docker login loginServer -u 00000000-0000-0000-0000-000000000000 -p accessToken'
{
  "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjZLQUM6RUVIUDpUVlpGOk5CNEg6VjdCRzoyQlc0OkxWQk46MlhJWjpWVzNWOlA0RTI6N09GMzpFQlpMIn0.eyJqdGkiOiIxZmU3OTFiZC0zOWZjLTRlODYtODJlNy1hZDc3YTZkYjRiMmYiLCJzdWIiOiJsaXZlLmNvbSN0YWVleW91bDc3QGdtYWlsLmNvbSIsIm5iZiI6MTYwNTU5Nzc2NCwiZXhwIjoxNjA1NjA5NDY0LCJpYXQiOjE2MDU1OTc3NjQsImlzcyI6IkF6dXJlIENvbnRhaW5lciBSZWdpc3RyeSIsImF1ZCI6ImFjcmFrczc3LmF6dXJlY3IuaW8iLCJ2ZXJzaW9uIjoiMS4wIiwiZ3JhbnRfdHlwZSI6InJlZnJlc2hfdG9rZW4iLCJ0ZW5hbnQiOiI0ODhjNDNjYi04OTFlLTQ5ODYtOGI2Yi00MGMyZTVjN2I4N2YiLCJwZXJtaXNzaW9ucyI6eyJhY3Rpb25zIjpbInJlYWQiLCJ3cml0ZSIsImRlbGV0ZSJdLCJub3RBY3Rpb25zIjpudWxsfSwicm9sZXMiOltdfQ.M4GQeVDurttkRmlP-8FfuGXwrAfh73STjmWGsEQBsy05V5pEStXKXunng24SD3dMpHpFJ0sBohTg12CRIhJlJyqLlYNDgxJrWncKubanKPfKOaeVcaNUJx1XCu-KYfHPuD8hTQiFQahV-O4mPCnsLC6UXiqb6_MDepmApYIR8-QhxnHFkOYwA662xqQO5TlJMH8-IQL2kN2BPi5QSd2M_5N2ZZJGCR0HutgYejKXJ1TO8jLXw_nz0iOhs4qSNOziR7vzS60pWMD9Ggm9x_dOupelRnzvSksweR377y7H2zfeEjcTEK9Qj265gdZizJjEXKfLU3TGr9DRehP9DlL1jw",
  "loginServer": "acraks77.azurecr.io"
}
```

### admin 활성화하기
```
taeeyoul77@Azure:~$ az acr update -n acrAKS77 --admin-enabled true
{
  "adminUserEnabled": true,
  "creationDate": "2020-11-17T07:29:53.922468+00:00",
  "dataEndpointEnabled": false,
  "dataEndpointHostNames": [],
  "encryption": {
    "keyVaultProperties": null,
    "status": "disabled"
  },
  "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg_AKS/providers/Microsoft.ContainerRegistry/registries/acrAKS77",
  "identity": null,
  "location": "koreacentral",
  "loginServer": "acraks77.azurecr.io",
  "name": "acrAKS77",
  "networkRuleSet": null,
  "policies": {
    "quarantinePolicy": {
      "status": "disabled"
    },
    "retentionPolicy": {
      "days": 7,
      "lastUpdatedTime": "2020-11-17T07:29:56.309814+00:00",
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
  "resourceGroup": "rg_AKS",
  "sku": {
    "name": "Basic",
    "tier": "Basic"
  },
  "status": null,
  "storageAccount": null,
  "systemData": {
    "createdAt": "2020-11-17T07:29:53.9224686+00:00",
    "createdBy": "taeeyoul77@gmail.com",
    "createdByType": "User",
    "lastModifiedAt": "2020-11-17T07:47:18.6248421+00:00",
    "lastModifiedBy": "taeeyoul77@gmail.com",
    "lastModifiedByType": "User"
  },
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries"
}
```

### ACR admin 활성화 확인
```
taeeyoul77@Azure:~$ az acr list --output table
NAME      RESOURCE GROUP    LOCATION      SKU    LOGIN SERVER         CREATION DATE         ADMIN ENABLED
--------  ----------------  ------------  -----  -------------------  --------------------  ---------------
acrAKS77  rg_AKS            koreacentral  Basic  acraks77.azurecr.io  2020-11-17T07:29:53Z  True
```

### login 서버 주소 얻기
```
taeeyoul77@Azure:~$ az acr list --resource-group rg_AKS --query "[].{acrLoginServer:loginServer}" --output table
AcrLoginServer
-------------------
acraks77.azurecr.io
```

### login 하기
```
taeeyoul77@Azure:~$ docker login acraks77.azurecr.io -u 00000000-0000-0000-0000-000000000000 -p "$ACR_ACCESS_TOKEN"
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
Login Succeeded
```

### login 스크립트
```
cat docker-login.sh
#!/bin/bash

export ACR_ACCESS_T0KEN=`az acr login --name acrAKS77 --expose-token | jq '.accessToken' | sed "s/\"//"`
docker login acraks77.azurecr.io -u 00000000-0000-0000-0000-000000000000 -p "$ACR_ACCESS_TOKEN"
```

## AKS Cluster 만들기
### aks-preview 0.4.35 확장
```
taeeyoul77@Azure:~$ az extension add --name aks-preview
The installed extension 'aks-preview' is in preview.
```

### UseCustomizedUbuntuPreview 기능을 등록
```
taeeyoul77@Azure:~$ az feature register --name UseCustomized\UbuntuPreview --namespace Microsoft.ContainerService
Once the feature 'UseCustomizedUbuntuPreview' is registered, invoking 'az provider register -n Microsoft.ContainerService' is required to get the change propagated
{
  "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/providers/Microsoft.Features/providers/Microsoft.ContainerService/features/UseCustomizedUbuntuPreview",
  "name": "Microsoft.ContainerService/UseCustomizedUbuntuPreview",
  "properties": {
    "state": "Registering"
  },
  "type": "Microsoft.Features/providers/features"
}
```

### 상태 조회
```
taeeyoul77@Azure:~$ az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/UseCustomizedUbuntuPreview')].{Name:name,State:properties.state}"
Name                                                   State
-----------------------------------------------------  ----------
Microsoft.ContainerService/UseCustomizedUbuntuPreview  Registered
taeeyoul77@Azure:~$ az provider register --namespace Microsoft.ContainerService
```

```
taeeyoul77@Azure:~$ az provider show -n Microsoft.ContainerService -o table
Namespace                   RegistrationPolicy    RegistrationState
--------------------------  --------------------  -------------------
Microsoft.ContainerService  RegistrationRequired  Registered
```

### 빠른 Node 사용 설정
- EnableEphemeralOSDiskPreview  
더 빠른 노드 크기 조정 및 클러스터 업그레이드와 함께 읽기/쓰기 대기 시간이 줄어듦
```
taeeyoul77@Azure:~$ az feature register --name EnableEphemeralOSDiskPreview --namespace Microsoft.ContainerService
Once the feature 'EnableEphemeralOSDiskPreview' is registered, invoking 'az provider register -n Microsoft.ContainerService' is required to get the change propagated
{
  "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/providers/Microsoft.Features/providers/Microsoft.ContainerService/features/EnableEphemeralOSDiskPreview",
  "name": "Microsoft.ContainerService/EnableEphemeralOSDiskPreview",
  "properties": {
    "state": "Registering"
  },
  "type": "Microsoft.Features/providers/features"
}
taeeyoul77@Azure:~$ az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/EnableEphemeralOSDiskPreview')].{Name:name,State:properties.state}"
Name                                                     State
-------------------------------------------------------  -----------
Microsoft.ContainerService/EnableEphemeralOSDiskPreview  Registering
```

### Cluster 생성하기
- Cluster Name : myAKSCluster
- Node 리소스 그룹의 사용자 지정 이름을 지정  
  - **az aks create** 명령의 **--node-resource-group** 매개 변수를 사용
  - default value : MC_resourcegroupname_clustername_location  
    예) MC_rg_AKS_myAKSCluster_koreacentral
- **addon** 설정 : **monitoring**
- **임시디스크 설정** : **--node-osdisk-type Ephemeral**
- **이미지 설정** : **Standard_DS3_v2**
- **containerd 사용 설정** : **--aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd**  
- 실행 로그 - 자원이 부족하여 실패한 경우 --> 구독의 해당 자원 증설 요청 필요
  ```
  taeeyoul77@Azure:~$ az aks create --name myAKSCluster --resource-group rg_AKS --node-resource-group myNodeResourceGroup --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd -s Standard_DS3_v2 --node-osdisk-type Ephemeral --node-count 3 --enable-addons monitoring --generate-ssh-keys
  The behavior of this command has been altered by the following extension: aks-preview
  BadRequestError: Operation failed with status: 'Bad Request'. Details: Provisioning of resource(s) for container service myAKSCluster in resource group rg_AKS failed. Message: Operation could not be completed as it results in exceeding approved Total Regional Cores quota. Additional details - Deployment Model: Resource Manager, Location: KoreaCentral, Current Limit: 10, Current Usage: 0, Additional Required: 12, (Minimum) New Limit Required: 12. Submit a request for Quota increase at https://aka.ms/ProdportalCRP/?#create/Microsoft.Support/Parameters/%7B%22subId%22:%22cafbe447-3ee0-4523-89e3-67c483a935c5%22,%22pesId%22:%2206bfd9d3-516b-d5c6-5802-169c800dec89%22,%22supportTopicId%22:%22e12e3d1d-7fa0-af33-c6d0-3c50df9658a3%22%7D by specifying parameters listed in the ‘Details’ section for deployment to succeed. Please read more about quota limits at https://docs.microsoft.com/en-us/azure/azure-supportability/regional-quota-requests.. Details:
  ```  
- vCore 자원 증설 (10 -> 40) 후 실행로그(Success)  
  ```
  taeeyoul77@Azure:~$ az aks create --name myAKSCluster --resource-group rg_AKS --node-resource-group myNodeResourceGroup --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd -s Standard_DS3_v2 --node-osdisk-type Ephemeral --node-count 3 --enable-addons monitoring --generate-ssh-keys
  The behavior of this command has been altered by the following extension: aks-preview
  AAD role propagation done[############################################]  100.0000%{
    "aadProfile": null,
    "addonProfiles": {
      "KubeDashboard": {
        "config": null,
        "enabled": true,
        "identity": null
      },
      "omsagent": {
        "config": {
          "logAnalyticsWorkspaceResourceID": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourcegroups/defaultresourcegroup-se/providers/microsoft.operationalinsights/workspaces/defaultworkspace-cafbe447-3ee0-4523-89e3-67c483a935c5-se"
        },
        "enabled": true,
        "identity": null
      }
    },
    "agentPoolProfiles": [
      {
        "availabilityZones": null,
        "count": 3,
        "enableAutoScaling": null,
        "enableNodePublicIp": false,
        "maxCount": null,
        "maxPods": 110,
        "minCount": null,
        "mode": "System",
        "name": "nodepool1",
        "nodeImageVersion": "AKSUbuntu-1804-2020.10.28",
        "nodeLabels": {},
        "nodeTaints": null,
        "orchestratorVersion": "1.17.13",
        "osDiskSizeGb": 128,
        "osDiskType": "Ephemeral",
        "osType": "Linux",
        "powerState": {
          "code": "Running"
        },
        "provisioningState": "Succeeded",
        "proximityPlacementGroupId": null,
        "scaleSetEvictionPolicy": null,
        "scaleSetPriority": null,
        "spotMaxPrice": null,
        "tags": null,
        "type": "VirtualMachineScaleSets",
        "upgradeSettings": null,
        "vmSize": "Standard_DS3_v2",
        "vnetSubnetId": null
      }
    ],
    "apiServerAccessProfile": null,
    "autoScalerProfile": null,
    "diskEncryptionSetId": null,
    "dnsPrefix": "myAKSClust-rgAKS-cafbe4",
    "enablePodSecurityPolicy": false,
    "enableRbac": true,
    "fqdn": "myaksclust-rgaks-cafbe4-c05d88f0.hcp.koreacentral.azmk8s.io",
    "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourcegroups/rg_AKS/providers/Microsoft.ContainerService/managedClusters/myAKSCluster",
    "identity": null,
    "identityProfile": null,
    "kubernetesVersion": "1.17.13",
    "linuxProfile": {
      "adminUsername": "azureuser",
      "ssh": {
        "publicKeys": [
          {
            "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZA68fT/tcmFcAIgaw1ioO+1x5yL3UEaCmA2OdnMaYRQT3lz+2fYkxr5HHF1549fOKXnJ5tVsfzmuIANkKoFpIHNvH9Rs85fMJIgPxkR+Ax5ynqfPZIaGjIPZdCLCh9xfU5UknEJ7kQ/HOiI7879Jc184IhWq0XwPh5fEhc7rxyE7aCtGmq1FiOA/hjbCQ0JDB2LXaY75uaMPRizy9j3gbvi5OV5yL9Q+hMRAD4/tTlFni1YlYHaa0rbnWSSSYTw3AMbxD8oeLzI0SdUI6vXfMHQSP9Jdro/ge5KXabRj81o1LMDSgIkD52T+uSTFZthDOEKQlaJIsdQvfSuzpvUxN"
          }
        ]
      }
    },
    "location": "koreacentral",
    "maxAgentPools": 10,
    "name": "myAKSCluster",
    "networkProfile": {
      "dnsServiceIp": "10.0.0.10",
      "dockerBridgeCidr": "172.17.0.1/16",
      "loadBalancerProfile": {
        "allocatedOutboundPorts": null,
        "effectiveOutboundIps": [
          {
            "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/myNodeResourceGroup/providers/Microsoft.Network/publicIPAddresses/6edbd0fd-23e0-4c9e-b9d1-1a2d0e74a0c2",
            "resourceGroup": "myNodeResourceGroup"
          }
        ],
        "idleTimeoutInMinutes": null,
        "managedOutboundIps": {
          "count": 1
        },
        "outboundIpPrefixes": null,
        "outboundIps": null
      },
      "loadBalancerSku": "Standard",
      "networkMode": null,
      "networkPlugin": "kubenet",
      "networkPolicy": null,
      "outboundType": "loadBalancer",
      "podCidr": "10.244.0.0/16",
      "serviceCidr": "10.0.0.0/16"
    },
    "nodeResourceGroup": "myNodeResourceGroup",
    "powerState": {
      "code": "Running"
    },
    "privateFqdn": null,
    "provisioningState": "Succeeded",
    "resourceGroup": "rg_AKS",
    "servicePrincipalProfile": {
      "clientId": "f4f5478c-3183-4458-b366-332cff36e8be",
      "secret": null
    },
    "sku": {
      "name": "Basic",
      "tier": "Free"
    },
    "tags": null,
    "type": "Microsoft.ContainerService/ManagedClusters",
    "windowsProfile": null
  }
  taeeyoul77@Azure:~$
  ```  
#### Node Pool 생성 조회하기
```
taeeyoul77@Azure:~$ az aks nodepool list --resource-group rg_AKS --cluster-name myAKSCluster
The behavior of this command has been altered by the following extension: aks-preview
[
  {
    "agentPoolType": "VirtualMachineScaleSets",
    "availabilityZones": null,
    "count": 1,
    "enableAutoScaling": null,
    "enableNodePublicIp": false,
    "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourcegroups/rg_AKS/providers/Microsoft.ContainerService/managedClusters/myAKSCluster/agentPools/nodepool1",
    "maxCount": null,
    "maxPods": 110,
    "minCount": null,
    "mode": "System",
    "name": "nodepool1",
    "nodeImageVersion": "AKSUbuntu-1804-2020.10.28",
    "nodeLabels": {},
    "nodeTaints": null,
    "orchestratorVersion": "1.17.13",
    "osDiskSizeGb": 128,
    "osDiskType": "Ephemeral",
    "osType": "Linux",
    "powerState": {
      "code": "Running"
    },
    "provisioningState": "Succeeded",
    "proximityPlacementGroupId": null,
    "resourceGroup": "rg_AKS",
    "scaleSetEvictionPolicy": null,
    "scaleSetPriority": null,
    "spotMaxPrice": null,
    "tags": null,
    "type": "Microsoft.ContainerService/managedClusters/agentPools",
    "upgradeSettings": null,
    "vmSize": "Standard_DS3_v2",
    "vnetSubnetId": null
  }
]
```

#### NodePool 보기
```
taeeyoul77@Azure:~$ az aks show --resource-group rg_AKS --name myAKSCluster --query agentPoolProfiles
The behavior of this command has been altered by the following extension: aks-preview
[
  {
    "availabilityZones": null,
    "count": 3,
    "enableAutoScaling": null,
    "enableNodePublicIp": false,
    "maxCount": null,
    "maxPods": 110,
    "minCount": null,
    "mode": "System",
    "name": "nodepool1",
    "nodeImageVersion": "AKSUbuntu-1804-2020.10.28",
    "nodeLabels": {},
    "nodeTaints": null,
    "orchestratorVersion": "1.17.13",
    "osDiskSizeGb": 128,
    "osDiskType": "Ephemeral",
    "osType": "Linux",
    "powerState": {
      "code": "Running"
    },
    "provisioningState": "Succeeded",
    "proximityPlacementGroupId": null,
    "scaleSetEvictionPolicy": null,
    "scaleSetPriority": null,
    "spotMaxPrice": null,
    "tags": null,
    "type": "VirtualMachineScaleSets",
    "upgradeSettings": null,
    "vmSize": "Standard_DS3_v2"
  }
]
```  

#### **Credential 가져오기**
```
taeeyoul77@Azure:~$ az aks get-credentials --resource-group rg_AKS --name myAKSCluster
The behavior of this command has been altered by the following extension: aks-preview
Merged "myAKSCluster" as current context in /home/taeeyoul77/.kube/config
taeeyoul77@Azure:~$ kubectl get node
NAME                                STATUS   ROLES   AGE   VERSION
aks-nodepool1-35421499-vmss000000   Ready    agent   46m   v1.17.13
aks-nodepool1-35421499-vmss000001   Ready    agent   46m   v1.17.13
aks-nodepool1-35421499-vmss000002   Ready    agent   46m   v1.17.13
```

#### App 배포 및 동작 조회
```
taeeyoul77@Azure:~$ vi azure-vote.yaml
taeeyoul77@Azure:~$ kubectl apply -f azure-vote.yaml
deployment.apps/azure-vote-back created
service/azure-vote-back created
deployment.apps/azure-vote-front created
service/azure-vote-front created
taeeyoul77@Azure:~$ kubectl get service azure-vote-front --watch
NAME               TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
azure-vote-front   LoadBalancer   10.0.134.69   40.82.136.225   80:31459/TCP   19s
^Ctaeeyoul77@Azure:~$ ^C
taeeyoul77@Azure:~$ kubectl get pod
NAME                                READY   STATUS    RESTARTS   AGE
azure-vote-back-5b47678576-ns2nr    1/1     Running   0          5m35s
azure-vote-front-744c74db99-mcpn6   1/1     Running   0          5m35s
taeeyoul77@Azure:~$ curl http://40.82.136.225/
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="stylesheet" type="text/css" href="/static/default.css">
    <title>Azure Voting App</title>

    <script language="JavaScript">
        function send(form){
        }
    </script>

</head>
<body>
    <div id="container">
        <form id="form" name="form" action="/"" method="post"><center>
        <div id="logo">Azure Voting App</div>
        <div id="space"></div>
        <div id="form">
        <button name="vote" value="Cats" onclick="send()" class="button button1">Cats</button>
        <button name="vote" value="Dogs" onclick="send()" class="button button2">Dogs</button>
        <button name="vote" value="reset" onclick="send()" class="button button3">Reset</button>
        <div id="space"></div>
        <div id="space"></div>
        <div id="results"> Cats - 0 | Dogs - 0 </div>
        </form>
        </div>
    </div>
</body>
</html>taeeyoul77@Azure:~$
```  

#### Node Pool Size 줄이기  
3 -> 1 로 줄이기
- 노드갯수가 3임을 확인
  ```
  taeeyoul77@Azure:~$ kubectl get node
  NAME                                STATUS   ROLES   AGE   VERSION
  aks-nodepool1-35421499-vmss000000   Ready    agent   46m   v1.17.13
  aks-nodepool1-35421499-vmss000001   Ready    agent   46m   v1.17.13
  aks-nodepool1-35421499-vmss000002   Ready    agent   46m   v1.17.13
  ```
- 노드 갯수 1로 줄이기  
  ```
  taeeyoul77@Azure:~$ az aks nodepool scale --name nodepool1 --cluster-name myAKSCluster --resource-group rg_AKS --node-count 1
  The behavior of this command has been altered by the following extension: aks-preview
  {- Finished ..
    "agentPoolType": "VirtualMachineScaleSets",
    "availabilityZones": null,
    "count": 1,
    "enableAutoScaling": null,
    "enableNodePublicIp": false,
    "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourcegroups/rg_AKS/providers/Microsoft.ContainerService/managedClusters/myAKSCluster/agentPools/nodepool1",
    "maxCount": null,
    "maxPods": 110,
    "minCount": null,
    "mode": "System",
    "name": "nodepool1",
    "nodeImageVersion": "AKSUbuntu-1804-2020.10.28",
    "nodeLabels": {},
    "nodeTaints": null,
    "orchestratorVersion": "1.17.13",
    "osDiskSizeGb": 128,
    "osDiskType": "Ephemeral",
    "osType": "Linux",
    "powerState": {
      "code": "Running"
    },
    "provisioningState": "Succeeded",
    "proximityPlacementGroupId": null,
    "resourceGroup": "rg_AKS",
    "scaleSetEvictionPolicy": null,
    "scaleSetPriority": null,
    "spotMaxPrice": null,
    "tags": null,
    "type": "Microsoft.ContainerService/managedClusters/agentPools",
    "upgradeSettings": null,
    "vmSize": "Standard_DS3_v2",
    "vnetSubnetId": null
  }
  ```  

- 노드 개수 1임을 확인  
  ```
  taeeyoul77@Azure:~$ kubectl get node
  NAME                                STATUS   ROLES   AGE   VERSION
  aks-nodepool1-35421499-vmss000000   Ready    agent   89m   v1.17.13
  ```  
