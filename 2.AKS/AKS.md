# AKS

- 일반적으로 1.18 설치 (2021-04-19)
- perview 버전 설치를 지정해야 1.18 설치 가능 (OS Image 중요)
  - 기본은 1.17 설치되며, Upgrade 가능 버전에 1.18 이 나오며 선택해서 설치함
  - 빠른 Node 사용 설정(EnableEphemeralOSDiskPreview)
- 가용영역은 한국 미지원으로 현재 Region 에서는  사용 불가(오류 발생)
- 클러스터의 pod 간에 트래픽이 흐르는 방법에 최소 권한 원칙(Network Policy)은 현재 적용 않음
  - 적용시 pod 레이블을 기준으로 인바운드 트래픽 허용
- VMSS 를 설정할 경우 'az aks stop' 이 아닌 'az vmss stop' 사용
- Cloud Shell 을 쓸 경우는 자동으로 인증이 됨

[AKS(Azure Kubernetes Service)](https://docs.microsoft.com/ko-kr/azure/aks/)  
[AKS 클러스터 구성](https://docs.microsoft.com/ko-kr/azure/aks/cluster-configuration)
[HTTP 애플리케이션 라우팅](https://docs.microsoft.com/ko-kr/azure/aks/http-application-routing)   
[이미 배포 된 AKS (Azure Kubernetes Service) 클러스터의 모니터링 사용](https://docs.microsoft.com/ko-kr/azure/azure-monitor/insights/container-insights-enable-existing-clusters)
[자습서: AKS(Azure Kubernetes Service)에 대한 애플리케이션 준비](https://docs.microsoft.com/ko-kr/azure/aks/tutorial-kubernetes-prepare-app)

> [AKS Monitoring](AKSMonitoring.md)  
> [ACR](RepositoryService.md)   

![CRI-O](./img/containerd-cri.png)

## AKS Perview(EnableAzureRBACPreview) 기능 플래그 사용 설정
### Azure RBAC 사용 설정
```
az feature register --namespace "Microsoft.ContainerService" --name "EnableAzureRBACPreview"
Once the feature 'EnableAzureRBACPreview' is registered, invoking 'az provider register -n Microsoft.ContainerService' is required to get the change propagated
{
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/providers/Microsoft.Features/providers/Microsoft.ContainerService/features/EnableAzureRBACPreview",
  "name": "Microsoft.ContainerService/EnableAzureRBACPreview",
  "properties": {
    "state": "Registering"
  },
  "type": "Microsoft.Features/providers/features"
}
```

### Azure 사용자 지정 노드구성 설정
```bash
az feature register --namespace "Microsoft.ContainerService" --name "CustomNodeConfigPreview"
Once the feature 'CustomNodeConfigPreview' is registered, invoking 'az provider register -n Microsoft.ContainerService' is required to get the change propagated
{
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/providers/Microsoft.Features/providers/Microsoft.ContainerService/features/CustomNodeConfigPreview",
  "name": "Microsoft.ContainerService/CustomNodeConfigPreview",
  "properties": {
    "state": "Registered"
  },
  "type": "Microsoft.Features/providers/features"
}
```



### 설정확인
```
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/EnableAzureRBACPreview')].{Name:name,State:properties.state}"
Name                                               State
-------------------------------------------------  -----------
Microsoft.ContainerService/EnableAzureRBACPreview  Registering
```
#### 사용자 지정 노드 구성 설정 조회
```bash
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/CustomNodeConfigPreview')].{Name:name,State:properties.state}"
Name                                                State
--------------------------------------------------  ----------
Microsoft.ContainerService/CustomNodeConfigPreview  Registered
```

### az provider register 명령을 사용하여 ContainerService 리소스 공급자 등록을 새로 고침
```
az provider register --namespace Microsoft.ContainerService
```
### aks-preview 설치
```
# Install the aks-preview extension
az extension add --name aks-preview

# Update the extension to make sure you have the latest version installed
az extension update --name aks-preview
```

### 18.04 LTS 사용 설정

```
# Register the preview feature flag
az feature register --name UseCustomizedUbuntuPreview --namespace Microsoft.ContainerService
Once the feature 'UseCustomizedUbuntuPreview' is registered, invoking 'az provider register -n Microsoft.ContainerService' is required to get the change propagated
{
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/providers/Microsoft.Features/providers/Microsoft.ContainerService/features/UseCustomizedUbuntuPreview",
  "name": "Microsoft.ContainerService/UseCustomizedUbuntuPreview",
  "properties": {
    "state": "Registering"
  },
  "type": "Microsoft.Features/providers/features"
}
```


## Azure Cloud login
### Azure Login
```
PS D:\workspace\SKT Azure Landing Zone> az login

You have logged in. Now let us find all the subscriptions to which you have access...
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "9515311f-d116-4323-8ed0-cf4b816d5cf0",
    "id": "f1dcf39e-3a7d-4e26-be60-d784138e1ad2",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Landing Zone Staging",
    "state": "Enabled",
    "tenantId": "9515311f-d116-4323-8ed0-cf4b816d5cf0",
    "user": {
      "name": "taeeyoul@gmail.com",
      "type": "user"
    }
  },
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "488c43cb-891e-4986-8b6b-40c2e5c7b87f",
    "id": "6da41482-181c-4758-9ec4-79ea38643a52",
    "isDefault": false,
    "managedByTenants": [],
    "name": "Landing Zone",
    "state": "Enabled",
    "tenantId": "488c43cb-891e-4986-8b6b-40c2e5c7b87f",
    "user": {
      "name": "taeeyoul@gmail.com",
      "type": "user"
    }
  },
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "488c43cb-891e-4986-8b6b-40c2e5c7b87f",
    "id": "2f9c3604-2d58-41ac-9a64-62c35205957a",
    "isDefault": false,
    "managedByTenants": [],
    "name": "Landing Zone Staging",
    "state": "Enabled",
    "tenantId": "488c43cb-891e-4986-8b6b-40c2e5c7b87f",
    "user": {
      "name": "taeeyoul@gmail.com",
      "type": "user"
    }
  }
]
PS D:\workspace\SKT Azure Landing Zone>
```  

### Azure Tenant 보기  
```
]
PS D:\workspace\SKT Azure Landing Zone> az account tenant list

Command group 'account tenant' is experimental and not covered by customer support. Please use with discretion.[
  {
    "id": "/tenants/9515311f-d116-4323-8ed0-cf4b816d5cf0",
    "tenantId": "9515311f-d116-4323-8ed0-cf4b816d5cf0"
  },
  {
    "id": "/tenants/488c43cb-891e-4986-8b6b-40c2e5c7b87f",
    "tenantId": "488c43cb-891e-4986-8b6b-40c2e5c7b87f"
  }
]
```  

#### 명령 실행시 확장팩이 없을 경우 자동 설치함
```
PS F:\workspace\SKT%20Azure%20Landing%20Zone> az account list -o table
Name          CloudName    SubscriptionId                        State    IsDefault
------------  -----------  ------------------------------------  -------  -----------
SVC-taeeyoul  AzureCloud   cafbe447-3ee0-4523-89e3-67c483a935c5  Enabled  True
PS F:\workspace\SKT%20Azure%20Landing%20Zone> az account tenant list -o table
The command requires the extension account. Do you want to install it now? The command will continue to run after the extension is installed. (Y/n): y
Run 'az config set extension.use_dynamic_install=yes_without_prompt' to allow installing extensions without prompt.
The installed extension 'account' is experimental and not covered by customer support. Please use with discretion.
Command group 'account tenant' is experimental and not covered by customer support. Please use with discretion.
TenantId
------------------------------------
488c43cb-891e-4986-8b6b-40c2e5c7b87f
```
#### tenant id 만 보기(-o table)
```
PS F:\workspace\SKT%20Azure%20Landing%20Zone> az account tenant list -o table
Command group 'account tenant' is experimental and not covered by customer support. Please use with discretion.
TenantId
------------------------------------
488c43cb-891e-4986-8b6b-40c2e5c7b87f
PS F:\workspace\SKT%20Azure%20Landing%20Zone> 
```

### subscription 보기 및 변경 설정  
```
PS D:\workspace\SKT Azure Landing Zone> az account list --output table

Name                  CloudName    SubscriptionId                        State    IsDefault
--------------------  -----------  ------------------------------------  -------  -----------
Landing Zone Staging  AzureCloud   f1dcf39e-3a7d-4e26-be60-d784138e1ad2  Enabled  True
Landing Zone          AzureCloud   6da41482-181c-4758-9ec4-79ea38643a52  Enabled  False
Landing Zone Staging  AzureCloud   2f9c3604-2d58-41ac-9a64-62c35205957a  Enabled  False
PS D:\workspace\SKT Azure Landing Zone> az account set --subscription "Landing Zone"

PS D:\workspace\SKT Azure Landing Zone> az account list --output table

Name                  CloudName    SubscriptionId                        State a   IsDefault
--------------------  -----------  ------------------------------------  -------  -----------
Landing Zone Staging  AzureCloud   f1dcf39e-3a7d-4e26-be60-d784138e1ad2  Enabled  False
Landing Zone          AzureCloud   6da41482-181c-4758-9ec4-79ea38643a52  Enabled  True
Landing Zone Staging  AzureCloud   2f9c3604-2d58-41ac-9a64-62c35205957a  Enabled  False
```

## 생성 명령

### 자원그룹 생성&삭제  
```
PS D:\workspace\SKT Azure Landing Zone> az group create --name rg-aks-taeyeol --location koreacentral

{
  "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-aks",
  "location": "koreacentral",
  "managedBy": null,
  "name": "rg-aks-taeyeol",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}

PS D:\workspace\SKT Azure Landing Zone> az group delete --name AKSTEST

Are you sure you want to perform this operation? (y/n): y
PS D:\workspace\SKT Azure Landing Zone> az account set --subscription "Landing Zone"
PS D:\workspace\SKT Azure Landing Zone> az group create --name AKSTEST --location koreacentral

{
  "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/AKSTEST",
  "location": "koreacentral",
  "managedBy": null,
  "name": "AKSTEST",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
```

```
az group list -o table
Name                               Location       Status
---------------------------------  -------------  ---------
cloud-shell-storage-southeastasia  southeastasia  Succeeded
DefaultResourceGroup-SE            koreacentral   Succeeded
NetworkWatcherRG                   koreacentral   Succeeded
rg-function-app-taeeyoul           koreacentral   Succeeded
rg-aks                             koreacentral   Succeeded
```

- tag  달기
```
resource=$(az group show -g rg-aks  --query "id" --output tsv)
az tag create --resource-id rg-aks --tags environment=poc personalinformation=no  servicetitle=aks
```

- 자원 그룹(rg-aks) 에 tag 달기
```
az tag create --resource-id "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-aks" --tags environment=poc personalinformation=no  servicetitle=aks
{
  "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-aks/providers/Microsoft.Resources/tags/default",
  "name": "default",
  "properties": {
    "tags": {
      "environment": "poc",
      "personalinformation": "no",
      "servicetitle": "aks"
    }
  },
  "resourceGroup": "rg-aks",
  "type": "Microsoft.Resources/tags"
}
```

- Storage Account  에 tag 달기
```
az storage account list -o table
AccessTier    AllowBlobPublicAccess    CreationTime                      EnableHttpsTrafficOnly    Kind       Location       MinimumTlsVersion    Name                 PrimaryLocation    ProvisioningState  
  ResourceGroup                      StatusOfPrimary
------------  -----------------------  --------------------------------  ------------------------  ---------  -------------  -------------------  -------------------  -----------------  -------------------  ---------------------------------  -----------------
Hot           False                    2020-11-17T06:19:28.577439+00:00  True                      StorageV2  southeastasia  TLS1_2               cs110032000f8f3347f  southeastasia      Succeeded
  cloud-shell-storage-southeastasia  available
Hot                                    2020-11-23T10:37:43.811022+00:00  True                      StorageV2  koreacentral                        sktsharedstorage     koreacentral       Succeeded
  rg-function-app-taeeyoul           available
PS F:\workspace\SKT%20Azure%20Landing%20Zone\webfrontend> az storage account list --query "[].id"
[
  "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/cloud-shell-storage-southeastasia/providers/Microsoft.Storage/storageAccounts/cs110032000f8f3347f",
]
```

```
PS F:\workspace\SKT%20Azure%20Landing%20Zone\webfrontend> az tag create --resource-id "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-function-app-taeeyoul/providers/Microsoft.Storage/storageAccounts/sktsharedstorage" --tags environment=poc personalinformation=no  servicetitle=aks
{
  "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-function-app-taeeyoul/providers/Microsoft.Storage/storageAccounts/sktsharedstorage/providers/Microsoft.Resources/tags/default",
  "name": "default",
  "properties": {
    "tags": {
      "environment": "poc",
      "personalinformation": "no",
      "servicetitle": "aks"
    }
  },
  "resourceGroup": "rg-function-app-taeeyoul",
  "type": "Microsoft.Resources/tags"
}
```

```
az group list --query  "[].id"
[
  "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/cloud-shell-storage-southeastasia",
  "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/DefaultResourceGroup-SE",
  "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/NetworkWatcherRG",
  "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-function-app-taeeyoul",
  "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-aks",
  "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-aks-cluster-taeeyoul"
]
```



### AKS 클러스터 생성


#### Azure Monitor 사용 설정
- 컨테이너에 대한 Azure Monitor는 --enable-addons monitoring 매개 변수를 사용하여 설정
- 구독에서 Microsoft.OperationsManagement 및 Microsoft.OperationalInsights를 등록해야 함

#### AKS에 대한 Azure Policy 추가 기능 설치
```
# Provider register: Register the Azure Policy provider
az provider register --namespace Microsoft.PolicyInsights
```

#### 구독 등록 확인
```
PS D:\workspace\SKT Azure Landing Zone> az provider show -n Microsoft.OperationsManagement -o table

Namespace                       RegistrationPolicy    RegistrationState
------------------------------  --------------------  -------------------
Microsoft.OperationsManagement  RegistrationRequired  Registered
PS D:\workspace\SKT Azure Landing Zone> az provider show -n Microsoft.OperationalInsights -o table

Namespace                      RegistrationPolicy    RegistrationState
-----------------------------  --------------------  -------------------
Microsoft.OperationalInsights  RegistrationRequired  Registered
```
#### 구독 등록
```
PS D:\workspace\SKT Azure Landing Zone> az provider register --namespace Microsoft.OperationalInsights

Registering is still on-going. You can monitor using 'az provider show -n Microsoft.OperationalInsights'
PS D:\workspace\SKT Azure Landing Zone> az provider register --namespace Microsoft.OperationsManagement

Registering is still on-going. You can monitor using 'az provider show -n Microsoft.OperationsManagement'
```

```PowerShell
az provider register --namespace Microsoft.Network
az provider register --namespace Microsoft.Compute
```

#### 클라이언트 설치
```
az aks install-cli
Downloading client to "C:\Users\Administrator\.azure-kubectl\kubectl.exe" from "https://storage.googleapis.com/kubernetes-release/release/v1.20.4/bin/windows/amd64/kubectl.exe"
Please add "C:\Users\Administrator\.azure-kubectl" to your search PATH so the `kubectl.exe` can be found. 2 options: 
    1. Run "set PATH=%PATH%;C:\Users\Administrator\.azure-kubectl" or "$env:path += 'C:\Users\Administrator\.azure-kubectl'" for PowerShell. This is good for the current command session.
    2. Update system PATH environment variable by following "Control Panel->System->Advanced->Environment Variables", and re-open the command window. You only need to do it once
Downloading client to "C:\Users\ADMINI~1\AppData\Local\Temp\tmpkxqp3fya\kubelogin.zip" from "https://github.com/Azure/kubelogin/releases/download/v0.0.8/kubelogin.zip"
Please add "C:\Users\Administrator\.azure-kubelogin" to your search PATH so the `kubelogin.exe` can be found. 2 options: 
    1. Run "set PATH=%PATH%;C:\Users\Administrator\.azure-kubelogin" or "$env:path += 'C:\Users\Administrator\.azure-kubelogin'" for PowerShell. This is good for the current command session.
    2. Update system PATH environment variable by following "Control Panel->System->Advanced->Environment Variables", and re-open the command window. You only need to do it once
```

#### AKS Cluster 생성
- AKS 생성시 고려 사항

| 옵션 | 내용 |
|:---:|:---:|
| Network | Calico |
| 추가 기능 | Monitoring |
| AutoScaler | Node AutoScaler |
| 가용영역 설정 | zone |
| 가상 노드 | Node AutoScale 시간을 줄여 줌 |
| Stroage | Dynamic Provisioning |

#### AKS Cluster 생성시 기능 추가 옵션
- 아래와 같이 AKS 생성 시 추가 옵션을 넣거나
  ```
  --enable-addons http_application_routing,monitoring
  ```
- AKS 생성 후 추가로 옵션을 활성화 할 수 있음
  ```
  az aks enable-addons --resource-group rg-aks --name aks-cluster-taeeyoul --addons http_application_routing,monitoring
  ```  
  - 실행 로그
  ```
  az aks enable-addons --resource-group rg-aks --name aks-cluster-taeeyoul --addons 
  http_application_routing,monitoring
  The behavior of this command has been altered by the following extension: aks-preview
  AAD role propagation done[############################################]  100.0000%{
    "aadProfile": null,
    "addonProfiles": {
      "KubeDashboard": {
        "config": null,
        "enabled": true,
        "identity": null
      },
      "httpApplicationRouting": {
        "config": {
          "HTTPApplicationRoutingZoneName": "a0e75b1961f3408fbb0a.koreacentral.aksapp.io"
        },
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
        "count": 1,
        "enableAutoScaling": true,
        "enableNodePublicIp": false,
        "kubeletConfig": null,
        "linuxOsConfig": null,
        "maxCount": 3,
        "maxPods": 110,
        "minCount": 1,
        "mode": "System",
        "name": "nodepool1",
        "nodeImageVersion": "AKSUbuntu-1804-2020.10.28",
        "nodeLabels": {},
        "nodeTaints": null,
        "orchestratorVersion": "1.17.13",
        "osDiskSizeGb": 128,
        "osDiskType": "Ephemeral",
        "osType": "Linux",
        "podSubnetId": null,
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
    "autoScalerProfile": {
      "balanceSimilarNodeGroups": "false",
      "expander": "random",
      "maxEmptyBulkDelete": "10",
      "maxGracefulTerminationSec": "600",
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
    "diskEncryptionSetId": null,
    "dnsPrefix": "aks-cluste-rg-aks-cafbe4",
    "enablePodSecurityPolicy": false,
    "enableRbac": true,
    "fqdn": "aks-cluste-rg-aks-cafbe4-106ea688.hcp.koreacentral.azmk8s.io",
    "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourcegroups/rg-aks/providers/Microsoft.ContainerService/managedClusters/aks-cluster-taeeyoul",
    "identity": null,
    "identityProfile": null,
    "kubernetesVersion": "1.17.13",
    "linuxProfile": {
      "adminUsername": "azureuser",
      "ssh": {
        "publicKeys": [
          {
            "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHmEru6BIlxI04XuBgQhD5+kv00+qJ3OK1gZ4Ai67DYY1oP4PXUNiqYfYcpx1JUatTBPxXs/tD8pdk2odIUYA1nvO/E+GNMo889nMrr08G82YZZ3/E8ntOZUkdZ1X0QNhRsE2ABvjluLmxcjaG1FEaaZZoo1DvvIfhVOLxNweVYd3YQhzajohTcgzsBNqwN/mjDd0+ZF0C9U9ZPZonYgdTzDZT5jf70PcJKpoMn0p5Ekj4mikkYU5BfHxXdKkUSpZBFCAfdBJPLELDn3KUAtFzbG0/rNMxMh0Hc6fE8qTxtQj5JbggUXEGDTiBQSywhStFA2xmDFf26aseYHV6HKwL"
          }
        ]
      }
    },
    "location": "koreacentral",
    "maxAgentPools": 10,
    "name": "aks-cluster-taeeyoul",
    "networkProfile": {
      "dnsServiceIp": "10.0.0.10",
      "dockerBridgeCidr": "172.17.0.1/16",
      "loadBalancerProfile": {
        "allocatedOutboundPorts": null,
        "effectiveOutboundIps": [
          {
            "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/rg-aks-cluster-taeeyoul/providers/Microsoft.Network/publicIPAddresses/7795c852-b8eb-4eba-a76d-b66df5ae7654",
            "resourceGroup": "rg-aks-cluster-taeeyoul"
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
    "nodeResourceGroup": "rg-aks-cluster-taeeyoul",
    "podIdentityProfile": null,
    "powerState": {
      "code": "Running"
    },
    "privateFqdn": null,
    "provisioningState": "Succeeded",
    "resourceGroup": "rg-aks",
    "servicePrincipalProfile": {
      "clientId": "9371bd6b-f995-479c-81ce-7259a91be042",
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
  ```

  - pod 확인
  ```
  kubectl get pod -n kube-system
  NAME                                                              READY   STATUS    RESTARTS   AGE  
  addon-http-application-routing-default-http-backend-6d6dbcbnfw6   1/1     Running   0          2m25s
  addon-http-application-routing-external-dns-74896f5bb4-c764b      1/1     Running   0          2m25s
  addon-http-application-routing-nginx-ingress-controller-66ggvnq   1/1     Running   0          2m25s
  coredns-79766dfd68-6fpnv                                          1/1     Running   0          94m  
  coredns-79766dfd68-vtf2f                                          1/1     Running   0          92m  
  coredns-autoscaler-66c578cddb-qbnp2                               1/1     Running   0          94m  
  dashboard-metrics-scraper-6f5fb5c4f-xkbfm                         1/1     Running   0          94m  
  kube-proxy-p46ks                                                  1/1     Running   0          93m  
  kubernetes-dashboard-849d5c99ff-jbr5n                             1/1     Running   0          94m  
  metrics-server-7f5b4f6d8c-24585                                   1/1     Running   1          94m  
  omsagent-4dvwd                                                    1/1     Running   0          2m25s
  omsagent-rs-67b7f574bd-dtk7l                                      1/1     Running   0          2m25s
  tunnelfront-5bfb4dc788-8lw5d                                      1/1     Running   0          94m
  ```

- AKS CLuster 생성
  - [Cluster Autoscaler 사용](https://docs.microsoft.com/ko-kr/azure/aks/cluster-autoscaler)
  - [사용자 지정 노드 구성(preview)](https://docs.microsoft.com/ko-kr/azure/aks/custom-node-configuration)  
  - [kubenet 사용](https://docs.microsoft.com/ko-kr/azure/aks/configure-kubenet)  
    - 직접 pod 주소 지정은 지원 되지 않음  
    - 간단한 /24 IP 주소 범위 하나로 클러스터의 노드를 최대 251 개 지원할 수 있습니다(각 Azure Virtual Network 서브넷은 관리 작업을 위해 처음 3개의 IP 주소를 예약함).
    - 이 노드 수로 최대 27,610 개의 pod를 지원할 수 있습니다(kubenet 을 사용할 경우 노드당 최대 pod 기본값이 110개임).
    ![kubenet-overview.png](./img/kubenet-overview.png)
  - Monitoring, Http Application Routing 추가
  - ACR (acrTaeyeol01) 추가




  ```
  az aks create `
    --tags environment=poc personalinformation=no servicetitle=aks `
    --resource-group rg-aks-taeyeol `
    --name aks-cluster-taeyeol `
    --node-resource-group rg-aks-cluster-taeyeol `
    --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd `
    --node-osdisk-type Ephemeral `
    --nodepool-name taeyeol01 `
    --nodepool-tags owner=taeyeol environment=poc personalinformation=no servicetitle=aks `
    --node-vm-size Standard_DS3_v2 `
    --node-count 1 `
    --vm-set-type VirtualMachineScaleSets `
    --load-balancer-sku standard `
    --enable-cluster-autoscaler `
    --min-count 1 `
    --max-count 4 `
    --cluster-autoscaler-profile scan-interval=30s `
    --network-plugin kubenet `
    --network-policy calico `
    --service-cidr 10.0.0.0/16 `
    --dns-service-ip 10.0.0.10 `
    --pod-cidr 10.244.0.0/16 `
    --docker-bridge-address 172.17.0.1/16 `
    --enable-addons http_application_routing,monitoring `
    --generate-ssh-keys `
    --attach-acr acrTaeyeol01
    

    --zone 1 2 3 # 한국 미지원 -- 2021.03.09 현재 오류 아님
    --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd 
    --aks-custom-headers EnableAzureDiskFileCSIDriver=true`
  ```

  ![rg-aks-cluster-taeyeol](./img/rg-aks-cluster-taeyeol.png)

  ### Cluster 에 접속
  ```
  $ az aks get-credentials -g rg-aks-taeyeol -n aks-cluster-taeyeol
  The behavior of this command has been altered by the following extension: aks-preview
  A different object named aks-cluster-taeyeol already exists in your kubeconfig file.
  Overwrite? (y/n): y
  A different object named clusterUser_rg-aks-taeyeol_aks-cluster-taeyeol already exists in your kubeconfig file.
  Overwrite? (y/n): y
  Merged "aks-cluster-taeyeol" as current context in C:\Users\Administrator\.kube\config
  ```

  - 이미 생성된 Cluster 에 AutoScale 기능 추가하기
  ```
  az aks update `
    --resource-group rs-aks `
    --name aks-cluster-taeeyoul `
    --update-cluster-autoscaler `
    --min-count 1 `
    --max-count 3 `
    --cluster-autoscaler-profile scan-interval=30s
  ```

  - Cluster 에 Node 추가하기
  ```
  az aks scale `
    --resource-name rg-aks `
    --name aks-cluster-taeeyoul `
    --node-count 5
  ```

  ```
  kubectl describe nodes | grep -e "Name:" -e "failure-domain.beta.kubernetes.io/zone"
  ```

  ```
  kubectl get nodes -o custom-columns=NAME:'{.metadata.name}',REGION:'{.metadata.labels.topology\.kubernetes\.io/region}',ZONE:'{metadata.labels.topology\.kubernetes\.io/zone}'
  ```

  - Cluster  의 Node Pool 에 자동  크기 조정 사용 설정하기
  ```
  az aks nodepool update `
    --resource-group rs-aks `
    --cluster-name aks-cluster-taeeyoul `
    --name aks-cluster-taeeyoul-nodepool `
    --enable-cluster-autoscaler `
    --min-count 1 `
    --max-count 3
  ```

- Cluster 생성 로그
  ```
  PS D:\workspace\SKT Azure Landing Zone> az aks create --resource-group rg-aks --name aks-cluster-taeeyoul --node-count 1 --enable-addons http_application_routing,monitoring --generate-ssh-keys --attach-acr acrAKS01


  SSH key files 'C:\Users\Administrator\.ssh\id_rsa' and 'C:\Users\Administrator\.ssh\id_rsa.pub' have been generated under ~/.ssh to allow SSH access to the VM. If using machines without permanent storage like Azure Cloud Shell without an attached file share, back up your keys to a safe location
  Finished service principal creation[##################################]  100.0000%
  - Running ..
  -generate-ssh-keys
  AAD role propagation done[############################################]  100.0000%{
    "aadProfile": null,
    "addonProfiles": {
      "KubeDashboard": {
        "config": null,
        "enabled": true,
        "identity": null
      },
      "httpApplicationRouting": {
        "config": {
          "HTTPApplicationRoutingZoneName": "739d488eed144acb8318.koreacentral.aksapp.io"
        },
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
        "nodeImageVersion": "AKSUbuntu-1604-2020.10.28",
        "nodeLabels": {},
        "nodeTaints": null,
        "orchestratorVersion": "1.17.13",
        "osDiskSizeGb": 128,
        "osDiskType": "Managed",
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
        "vmSize": "Standard_DS2_v2",
        "vnetSubnetId": null
      }
    ],
    "apiServerAccessProfile": null,
    "autoScalerProfile": null,
    "diskEncryptionSetId": null,
    "dnsPrefix": "aks-cluste-rg-aks-cafbe4",
    "enablePodSecurityPolicy": null,
    "enableRbac": true,
    "fqdn": "aks-cluste-rg-aks-cafbe4-acad8595.hcp.koreacentral.azmk8s.io",
    "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourcegroups/rg-aks/providers/Microsoft.ContainerService/managedClusters/aks-cluster-taeeyoul",
    "identity": null,
    "identityProfile": null,
    "kubernetesVersion": "1.17.13",
    "linuxProfile": {
      "adminUsername": "azureuser",
      "ssh": {
        "publicKeys": [
          {
            "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHmEru6BIlxI04XuBgQhD5+kv00+qJ3OK1gZ4Ai67DYY1oP4PXUNiqYfYcpx1JUatTBPxXs/tD8pdk2odIUYA1nvO/E+GNMo889nMrr08G82YZZ3/E8ntOZUkdZ1X0QNhRsE2ABvjluLmxcjaG1FEaaZZoo1DvvIfhVOLxNweVYd3YQhzajohTcgzsBNqwN/mjDd0+ZF0C9U9ZPZonYgdTzDZT5jf70PcJKpoMn0p5Ekj4mikkYU5BfHxXdKkUSpZBFCAfdBJPLELDn3KUAtFzbG0/rNMxMh0Hc6fE8qTxtQj5JbggUXEGDTiBQSywhStFA2xmDFf26aseYHV6HKwL"
          }
        ]
      }
    },
    "location": "koreacentral",
    "maxAgentPools": 10,
    "name": "aks-cluster-taeeyoul",
    "networkProfile": {
      "dnsServiceIp": "10.0.0.10",
      "dockerBridgeCidr": "172.17.0.1/16",
      "loadBalancerProfile": {
        "allocatedOutboundPorts": null,
        "effectiveOutboundIps": [
          {
            "id": "/subscriptions/cafbe447-3ee0-4523-89e3-67c483a935c5/resourceGroups/MC_rg-aks_aks-cluster-taeeyoul_koreacentral/providers/Microsoft.Network/publicIPAddresses/759d12cd-8f9a-4c8d-a0b1-f5300aafdfee",
            "resourceGroup": "MC_rg-aks_aks-cluster-taeeyoul_koreacentral"
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
    "nodeResourceGroup": "MC_rg-aks_aks-cluster-taeeyoul_koreacentral",
    "powerState": {
      "code": "Running"
    },
    "privateFqdn": null,
    "provisioningState": "Succeeded",
    "resourceGroup": "rg-aks",
    "servicePrincipalProfile": {
      "clientId": "744daeb9-ed97-45a6-889f-3fd1acf89262",
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
  ```

- OS Image 로 인한 생성 실패
```
az aks create `
>> --resource-group rg-aks `
>> --node-resource-group rg-aks-cluster-taeeyoul `
>> --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd `
>> --node-osdisk-type Ephemeral `
>> --node-count 1 `
>> --vm-set-type VirtualMachineScaleSets `
>> --load-balancer-sku standard `
>> --enable-cluster-autoscaler `
>> --min-count 1 `
>> --max-count 4 `
>> --zone 1 2 `
>> --cluster-autoscaler-profile scan-interval=30s `
>> --generate-ssh-keys `
>> --attach-acr acrAKS01 `
>> --name aks-cluster-taeeyoul
The behavior of this command has been altered by the following extension: aks-preview
dard_DS2_v2 has a cache size of 92341796864 bytes, but the OS disk requires 137438953472 bytes. Use a VM size with larger cache or disable ephemeral OS.
```

- 가용영역  설정으로 인한 실패(koreacenteral 은 지원 않음)
```
az aks create `
>> --resource-group rg-aks `
>> --node-resource-group rg-aks-cluster-taeeyoul `
>> --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd `
>> --node-osdisk-type Ephemeral `
>> --node-count 1 `
>> --vm-set-type VirtualMachineScaleSets `
>> --load-balancer-sku standard `
>> --enable-cluster-autoscaler `
>> --min-count 1 `
>> --max-count 4 `
>> --zone 1 2 `
>> --cluster-autoscaler-profile scan-interval=30s `
>> --generate-ssh-keys `
>> --attach-acr acrAKS01 `
>> --name aks-cluster-taeeyoul `
>> -s Standard_DS3_v2
The behavior of this command has been altered by the following extension: aks-preview
AAD role propagation done[############################################]  100.0000%BadRequestError: Operation failed with status: 'Bad Request'. Details: Availability zone is not supported in this region.
```

- preview  기능 사용 설치
```
az aks create `
>>   --tags owner=taeyeol environment=poc personalinformation=no servicetitle=aks `
>>   --resource-group rg-taeyeol `
>>   --name aks-cluster-taeyeol `
>>   --node-resource-group rg-aks-cluster-taeyeol `
>>   --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804 `
>>   --node-osdisk-type Ephemeral `
>>   --nodepool-name taeyeol01 `
>>   --nodepool-tags owner=taeyeol environment=poc personalinformation=no servicetitle=aks `
>>   --node-vm-size Standard_DS3_v2 `
>>   --node-count 1 `
>>   --vm-set-type VirtualMachineScaleSets `
>>   --load-balancer-sku standard `
>>   --enable-cluster-autoscaler `
>>   --min-count 1 `
>>   --max-count 4 `
>>   --cluster-autoscaler-profile scan-interval=30s `
>>   --enable-addons http_application_routing,monitoring `
>>   --generate-ssh-keys `
>>   --attach-acr acrTaeyeol01
The behavior of this command has been altered by the following extension: aks-preview
AAD role propagation done[############################################]  100.0000%{
  "aadProfile": null,
  "addonProfiles": {
    "KubeDashboard": {
      "config": null,
      "enabled": false,
      "identity": null
    },
    "httpApplicationRouting": {
      "config": {
        "HTTPApplicationRoutingZoneName": "11e23a1c517142fca905.koreacentral.aksapp.io"
      },
      "enabled": true,
      "identity": {
        "clientId": "1e40731f-400f-4e18-9b3c-fa93f4931609",
        "objectId": "2e2fed31-fb3b-40f3-8ea7-904f4e1433f0",
        "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/httpapplicationrouting-aks-cluster-taeyeol"
      }
    },
    "omsagent": {
      "config": {
        "logAnalyticsWorkspaceResourceID": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/defaultresourcegroup-se/providers/microsoft.operationalinsights/workspaces/defaultworkspace-9ebb0d63-8327-402a-bdd4-e222b01329a1-se"
      },
      "enabled": true,
      "identity": {
        "clientId": "3d10d874-69a7-4014-8be9-b5d7e753be57",
        "objectId": "24c2d1a5-b58c-4092-9ad2-7edb1b8392cf",
        "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/omsagent-aks-cluster-taeyeol"
      }
    }
  },
  "agentPoolProfiles": [
    {
      "availabilityZones": null,
      "count": 1,
      "enableAutoScaling": true,
      "enableEncryptionAtHost": false,
      "enableNodePublicIp": false,
      "kubeletConfig": null,
      "kubeletDiskType": "OS",
      "linuxOsConfig": null,
      "maxCount": 4,
      "maxPods": 110,
      "minCount": 1,
      "mode": "System",
      "name": "taeyeol01",
      "nodeImageVersion": "AKSUbuntu-1804gen2-2021.02.24",
      "nodeLabels": {},
      "nodePublicIpPrefixId": null,
      "nodeTaints": null,
      "orchestratorVersion": "1.18.14",
      "osDiskSizeGb": 128,
      "osDiskType": "Ephemeral",
      "osType": "Linux",
      "podSubnetId": null,
      "powerState": {
        "code": "Running"
      },
      "provisioningState": "Succeeded",
      "proximityPlacementGroupId": null,
      "scaleSetEvictionPolicy": null,
      "scaleSetPriority": null,
      "spotMaxPrice": null,
      "tags": {
        "environment": "poc",
        "owner": "taeyeol",
        "personalinformation": "no",
        "servicetitle": "aks"
      },
      "type": "VirtualMachineScaleSets",
      "upgradeSettings": null,
      "vmSize": "Standard_DS3_v2",
      "vnetSubnetId": null
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
  "azurePortalFqdn": "aks-cluste-rg-taeyeol-9ebb0d-33d148df.portal.hcp.koreacentral.azmk8s.io",
  "diskEncryptionSetId": null,
  "dnsPrefix": "aks-cluste-rg-taeyeol-9ebb0d",
  "enablePodSecurityPolicy": false,
  "enableRbac": true,
  "fqdn": "aks-cluste-rg-taeyeol-9ebb0d-33d148df.hcp.koreacentral.azmk8s.io",
  "fqdnSubdomain": null,
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-taeyeol/providers/Microsoft.ContainerService/managedClusters/aks-cluster-taeyeol",
  "identity": {
    "principalId": "5cf2e91e-a60a-49a0-8f5c-494813c575e2",
    "tenantId": "160bacea-7761-4c83-bfa0-354f9b047f5a",
    "type": "SystemAssigned",
    "userAssignedIdentities": null
  },
  "identityProfile": {
    "kubeletidentity": {
      "clientId": "9a1b758e-7ba9-44ba-9435-18e8e3d7a785",
      "objectId": "ecc3a68d-561d-4493-96e2-1cdedc720c2c",
      "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aks-cluster-taeyeol-agentpool"
    }
  },
  "kubernetesVersion": "1.18.14",
  "linuxProfile": {
    "adminUsername": "azureuser",
    "ssh": {
      "publicKeys": [
        {
          "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6lazCoGwgA0/8VJ/wtpSB6PRiPasVqDiJn6zwpRyvplw2V7X5kS0izKI/VFOrWBuaVBmC40Zx1VFnkXZqc5uynSGqC2jDaBlkkxNuNvce9Uy1D05kJI63yyI/ObsJT4XHpHe4O8bZwl2oOzt1qdRwomE7APGOa6uK0y5pJ4Hn4TIbF1JjKsJAJl1WplBUtpvqSXusB3iwtaGyy6w6Akti8kHCbEN9CmAU3CQViCCGDvuFhGCT4GrJ61Lm6uhrLPGqML5tvofwg5XvD0sKwCeev1muB7rUejZTx2TrlWiUhyzSvQ4sGb9A6OVLnv/s+tC0dgQ8IhbDl7gISXBcfwP+KuuXAxr8tjNVMWLwMNCEKG3n0uxVcfZlB2AKAIsrynpNyfI5GxYBl9wfRr5xW1CHPo/UQLGEvhoePducJdpXfhNPKsCIhZpRGaA6lvn3Gb16lzl9uWzNTdbYd9ygSFSRWboWajoHAq8SqvruqPtMP+qjgogyynz8huIWMnJKnSM= generated-by-azure"
        }
      ]
    }
  },
  "location": "koreacentral",
  "maxAgentPools": 10,
  "name": "aks-cluster-taeyeol",
  "networkProfile": {
    "dnsServiceIp": "10.0.0.10",
    "dockerBridgeCidr": "172.17.0.1/16",
    "loadBalancerProfile": {
      "allocatedOutboundPorts": null,
      "effectiveOutboundIps": [
        {
          "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aks-cluster-taeyeol/providers/Microsoft.Network/publicIPAddresses/654030dd-c8f5-4bb9-8c61-88e7cb384288",
          "resourceGroup": "rg-aks-cluster-taeyeol"
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
  "nodeResourceGroup": "rg-aks-cluster-taeyeol",
  "podIdentityProfile": null,
  "powerState": {
    "code": "Running"
  },
  "privateFqdn": null,
  "provisioningState": "Succeeded",
  "resourceGroup": "rg-taeyeol",
  "servicePrincipalProfile": {
    "clientId": "msi",
    "secret": null
  },
  "sku": {
    "name": "Basic",
    "tier": "Free"
  },
  "tags": {
    "environment": "poc",
    "personalinformation": "no",
    "servicetitle": "aks"
  },
  "type": "Microsoft.ContainerService/ManagedClusters",
  "windowsProfile": null
}
}
```


### AKS client 설치  
  ```
  PS D:\workspace\SKT Azure Landing Zone> az aks install-cli

  Downloading client to "C:\Users\Administrator\.azure-kubectl\kubectl.exe" from "https://storage.googleapis.com/kubernetes-release/release/v1.19.4/bin/windows/amd64/kubectl.exe"
  Please add "C:\Users\Administrator\.azure-kubectl" to your search PATH so the `kubectl.exe` can be found. 2 options: 
      1. Run "set PATH=%PATH%;C:\Users\Administrator\.azure-kubectl" or "$env:path += 'C:\Users\Administrator\.azure-kubectl'" for PowerShell. This is good for the current command session.
      2. Update system PATH environment variable by following "Control Panel->System->Advanced->Environment Variables", and re-open the command window. You only need to do it once
  Downloading client to "C:\Users\ADMINI~1\AppData\Local\Temp\tmp8t4lx58q\kubelogin.zip" from "https://github.com/Azure/kubelogin/releases/download/v0.0.7/kubelogin.zip"
  Please add "C:\Users\Administrator\.azure-kubelogin" to your search PATH so the `kubelogin.exe` can be found. 2 options: 
      1. Run "set PATH=%PATH%;C:\Users\Administrator\.azure-kubelogin" or "$env:path += 'C:\Users\Administrator\.azure-kubelogin'" for PowerShell. This is good for the current command session.
      2. Update system PATH environment variable by following "Control Panel->System->Advanced->Environment Variables", and re-open the command window. You only need to do it once
  ```  


### AKS Cluster 연결
- 'az aks-credentials' 로 자격증명 받으면 연결이 됨
- AZ CLI 명령 (그룹명과 Cluster 명을 주고 자격증명을 받음)
  ```
  az aks get-credentials --resource-group rg-aks-taeyeol --name aks-cluster-taeyeol
  ```
- 처음 받을 때 출력 결과
  ```
  Merged "aks-cluster-taeeyoul" as current context in C:\Users\taeey\.kube\config
  ```

- 새로 만들고 다시 받을 때 출력 결과
  ```
  The behavior of this command has been altered by the following extension: aks-preview
  A different object named aks-cluster-taeeyoul already exists in your kubeconfig file.
  Overwrite? (y/n): y
  A different object named clusterUser_rg-aks_aks-cluster-taeeyoul already exists in your kubeconfig file.
  Overwrite? (y/n): y
  Merged "aks-cluster-taeeyoul" as current context in C:\Users\taeey\.kube\config
  ```
#### 자격 증명이 틀릴 때 나는 오류
- 이럴 경우 다시 받아야 함
```
kubectl get node
Unable to connect to the server: dial tcp: lookup myaksclust-rgaks-cafbe4-c05d88f0.hcp.koreacentral.azmk8s.io on 168.63.129.16:53: no such host
```

```
kubectl config view --raw -o jsonpath="{.clusters[?(@.name == 'aks-cluster-taeeyoul')].cluster.certificate-authority-data}" | base64 -d | openssl x509 -text | grep -A2 Validity
unable to load certificate
139948568286872:error:0906D06C:PEM routines:PEM_read_bio:no start line:pem_lib.c:701:Expecting: TRUSTED CERTIFICATE
```

#### 환경 설정
```
PS D:\workspace\SKT Azure Landing Zone> $env:path += 'C:\Users\Administrator\.azure-kubectl'
```

#### node 정보 가져오기
```
kubectl get node
NAME                                STATUS   ROLES   AGE   VERSION
aks-taeeyoul1-16504745-vmss000000   Ready    agent   5m    v1.18.10
```
#### Pod 정보 가져오기
```
kubectl get pod --all-namespaces 
NAMESPACE     NAME                                                              READY   STATUS    RESTARTS   AGE
kube-system   addon-http-application-routing-default-http-backend-554cd5ntj4b   1/1     Running   0          6m30s
kube-system   addon-http-application-routing-external-dns-678d544db6-n5qgg      1/1     Running   0          6m30s
kube-system   addon-http-application-routing-nginx-ingress-controller-5cn9bpz   1/1     Running   0          6m29s
kube-system   coredns-748cdb7bf4-4xnl6                                          1/1     Running   0          6m30s
kube-system   coredns-748cdb7bf4-zhfth                                          1/1     Running   0          5m21s
kube-system   coredns-autoscaler-868b684fd4-8b5gw                               1/1     Running   0          6m27s
kube-system   kube-proxy-kwqgp                                                  1/1     Running   0          5m45s
kube-system   metrics-server-58fdc875d5-w6248                                   1/1     Running   0          6m29s
kube-system   omsagent-rs-55b5d8d889-q284p                                      1/1     Running   0          6m29s
kube-system   omsagent-wgj57                                                    1/1     Running   0          5m45s
kube-system   tunnelfront-566d89747b-whdfm                                      1/1     Running   0          6m27
```

#### Azure Portal 화명
![Azure Portal - AKS](img/AKS%20-%20myAKSCluster.png)
![AKS 부하분산 장치](img/AKS%20-%20부하분산장치.png)

#### azure vote 배포 하기
```
PS D:\workspace\SKT Azure Landing Zone> kubectl apply -f azure-vote.yaml

deployment.apps/azure-vote-back created
service/azure-vote-back created
deployment.apps/azure-vote-front created
service/azure-vote-front created
PS D:\workspace\SKT Azure Landing Zone>
```
#### Namespace 확인
```
kubectl get ns
NAME              STATUS   AGE
default           Active   8m44s
kube-node-lease   Active   8m46s
kube-public       Active   8m46s
kube-system       Active   8m46s
```
### 애플리케이션 테스트

#### 모니터링
```
PS D:\workspace\SKT Azure Landing Zone> kubectl get service azure-vote-front --watch

NAME               TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
azure-vote-front   LoadBalancer   10.0.127.69   20.39.185.246   80:31388/TCP   48s
PS D:\workspace\SKT Azure Landing Zone> kubectl get pod

NAME                                READY   STATUS    RESTARTS   AGE
azure-vote-back-5b47678576-6crt4    1/1     Running   0          96s
azure-vote-front-744c74db99-8fjr5   1/1     Running   0          95s
```

#### 전체 Pod 정보 확인
```
PS D:\workspace\SKT Azure Landing Zone> kubectl get pod --all-namespaces ;

NAMESPACE     NAME                                        READY   STATUS    RESTARTS   AGE
default       azure-vote-back-5b47678576-6crt4            1/1     Running   0          6m52s
default       azure-vote-front-744c74db99-8fjr5           1/1     Running   0          6m51s
kube-system   coredns-869cb84759-js9dr                    1/1     Running   0          16m
kube-system   coredns-869cb84759-qgjb6                    1/1     Running   0          18m
kube-system   coredns-autoscaler-5b867494f-5zvxm          1/1     Running   0          18m
kube-system   dashboard-metrics-scraper-6f5fb5c4f-qjdf8   1/1     Running   0          18m
kube-system   kube-proxy-rjlhh                            1/1     Running   0          17m
kube-system   kubernetes-dashboard-849d5c99ff-44p2c       1/1     Running   0          18m
kube-system   metrics-server-5f4c878d8-px64w              1/1     Running   0          18m
kube-system   omsagent-mp8qb                              1/1     Running   0          17m
kube-system   omsagent-rs-64dbd8958d-rz69l                1/1     Running   0          18m
kube-system   tunnelfront-5665c55f54-2wxrx                1/1     Running   0          18m
```

#### Pod 동작 화면
[Azure Voing App Yaml](azure-vote.yaml)  
![Azure Voting App](./img/AKS%20-%20Azure%20Voting%20App.png) ![Azure Voting App 동작](./img/AKS%20-%20Azure%20Voting%20App%20동작.png)

#### Pod log 보기

```
PS D:\workspace\SKT Azure Landing Zone> kubectl logs -f azure-vote-front-744c74db99-8fjr5

Checking for script in /app/prestart.sh
Running script /app/prestart.sh
Running inside /app/prestart.sh, you could add migrations to this file, e.g.:

#! /usr/bin/env bash

# Let the DB start
sleep 10;
# Run migrations
alembic upgrade head

/usr/lib/python2.7/dist-packages/supervisor/options.py:298: UserWarning: Supervisord is running as root and it is searching for its configuration file in default locations (including its current working directory); you probably want to specify a "-c" argument specifying an absolute path to a configuration file for improved security.
  'Supervisord is running as root and it is searching '
2020-11-13 06:39:16,499 CRIT Supervisor running as root (no user in config file)
2020-11-13 06:39:16,499 INFO Included extra file "/etc/supervisor/conf.d/supervisord.conf" during parsing
2020-11-13 06:39:16,508 INFO RPC interface 'supervisor' initialized
2020-11-13 06:39:16,509 CRIT Server 'unix_http_server' running without any HTTP authentication checking
2020-11-13 06:39:16,509 INFO supervisord started with pid 6
2020-11-13 06:39:17,511 INFO spawned: 'nginx' with pid 9
2020-11-13 06:39:17,513 INFO spawned: 'uwsgi' with pid 10
[uWSGI] getting INI configuration from /app/uwsgi.ini
[uWSGI] getting INI configuration from /etc/uwsgi/uwsgi.ini
*** Starting uWSGI 2.0.15 (64bit) on [Fri Nov 13 06:39:17 2020] ***
compiled with version: 6.3.0 20170516 on 14 December 2017 18:49:24
os: Linux-4.15.0-1098-azure #109~16.04.1-Ubuntu SMP Wed Sep 30 18:53:14 UTC 2020
nodename: azure-vote-front-744c74db99-8fjr5
machine: x86_64
clock source: unix
pcre jit disabled
detected number of CPU cores: 2
current working directory: /app
detected binary path: /usr/local/bin/uwsgi
your memory page size is 4096 bytes
detected max file descriptor number: 1048576
lock engine: pthread robust mutexes
thunder lock: disabled (you can enable it with --thunder-lock)
uwsgi socket 0 bound to UNIX address /tmp/uwsgi.sock fd 3
uWSGI running as root, you can use --uid/--gid/--chroot options
*** WARNING: you are running uWSGI as root !!! (use the --uid flag) ***
Python version: 3.6.3 (default, Dec 12 2017, 16:37:57)  [GCC 6.3.0 20170516]
*** Python threads support is disabled. You can enable it with --enable-threads ***
Python main interpreter initialized at 0x55cd64c6c100
your server socket listen backlog is limited to 100 connections
your mercy for graceful operations on workers is 60 seconds
mapped 1237056 bytes (1208 KB) for 16 cores
*** Operational MODE: preforking ***
2020-11-13 06:39:18,609 INFO success: nginx entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2020-11-13 06:39:18,609 INFO success: uwsgi entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
WSGI app 0 (mountpoint='') ready in 1 seconds on interpreter 0x55cd64c6c100 pid: 10 (default app)
*** uWSGI is running in multiple interpreter mode ***
spawned uWSGI master process (pid: 10)
spawned uWSGI worker 1 (pid: 13, cores: 1)
spawned uWSGI worker 2 (pid: 14, cores: 1)
[pid: 14|app: 0|req: 1/1] 10.244.0.1 () {40 vars in 782 bytes} [Fri Nov 13 06:40:45 2020] GET / => generated 950 bytes in 22 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:40:45 +0000] "GET / HTTP/1.1" 200 950 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
10.244.0.1 - - [13/Nov/2020:06:40:45 +0000] "GET /static/default.css HTTP/1.1" 200 1626 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
10.244.0.1 - - [13/Nov/2020:06:40:45 +0000] "GET /favicon.ico HTTP/1.1" 404 233 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 2/2] 10.244.0.1 () {40 vars in 721 bytes} [Fri Nov 13 06:40:45 2020] GET /favicon.ico => generated 233 bytes in 10 msecs (HTTP/1.1 404)
2 headers in 72 bytes (1 switches on core 0)
[pid: 14|app: 0|req: 3/3] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:25 2020] POST / => generated 950 bytes in 2 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:25 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 4/4] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:26 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:26 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 13|app: 0|req: 1/5] 10.244.0.1 () {50 vars in 1001 bytes} [Fri Nov 13 06:48:27 2020] POST / => generated 950 bytes in 16 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:27 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 13|app: 0|req: 2/6] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:27 2020] POST / => generated 950 bytes in 2 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:27 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 5/7] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:28 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:28 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 6/8] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:29 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:29 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 7/9] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:30 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:30 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 13|app: 0|req: 3/10] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:30 2020] POST / => generated 950 bytes in 2 msecs (HTTP/1.1 200) 2 headers
in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:30 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 8/11] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:31 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers
in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:31 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 13|app: 0|req: 4/12] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:31 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers
in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:31 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 9/13] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:31 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers
in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:31 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 10/14] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:31 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:31 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 11/15] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:32 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:32 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 12/16] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:32 2020] POST / => generated 950 bytes in 2 msecs (HTTP/1.1 200) 2 headers in 80 bytes (2 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:32 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 13/17] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:32 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:32 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 14/18] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:33 2020] POST / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:33 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 15/19] 10.244.0.1 () {50 vars in 999 bytes} [Fri Nov 13 06:48:33 2020] POST / => generated 950 bytes in 2 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:48:33 +0000] "POST / HTTP/1.1" 200 950 "http://20.39.185.246/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36" "-"
[pid: 14|app: 0|req: 16/20] 10.244.0.1 () {40 vars in 1853 bytes} [Fri Nov 13 06:50:42 2020] POST /index.do => generated 233 bytes in 0 msecs (HTTP/1.1 404)
2 headers in 72 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:06:50:42 +0000] "POST /index.do HTTP/1.1" 404 233 "-" "Auto Spider 1.0" "-"
[pid: 14|app: 0|req: 17/21] 10.244.0.1 () {30 vars in 312 bytes} [Fri Nov 13 07:05:49 2020] GET / => generated 950 bytes in 1 msecs (HTTP/1.0 200) 2 headers
in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:07:05:49 +0000] "GET / HTTP/1.0" 200 950 "-" "-" "-"
10.244.0.1 - - [13/Nov/2020:07:23:44 +0000] "\x01A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" 400 173 "-" "-" "-"[pid: 14|app: 0|req: 18/22] 10.244.0.1 () {32 vars in 441 bytes} [Fri Nov 13 08:23:19 2020] GET / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers
in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:08:23:19 +0000] "GET / HTTP/1.1" 200 950 "-" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36" "-"
[pid: 14|app: 0|req: 19/23] 10.244.0.1 () {32 vars in 441 bytes} [Fri Nov 13 08:39:44 2020] GET / => generated 950 bytes in 1 msecs (HTTP/1.1 200) 2 headers
in 80 bytes (1 switches on core 0)
10.244.0.1 - - [13/Nov/2020:08:39:44 +0000] "GET / HTTP/1.1" 200 950 "-" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" "-"
PS D:\workspace\SKT Azure Landing Zone> ^C
PS D:\workspace\SKT Azure Landing Zone>
```

### Kubernest Dashboard 사용
활성화 시켜서 사용함
```
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
```

- 브라우저로 띄우기
```
az aks browse --resource-group rg-aks --name aks-cluster-taeeyoul
The behavior of this command has been altered by the following extension: aks-preview
Merged "aks-cluster-taeeyoul" as current context in C:\Users\taeey\AppData\Local\Temp\tmp68rei1x4
Proxy running on http://127.0.0.1:8001/
Press CTRL+C to close the tunnel...
```

### Kubernest 사용 Disk - Dynamic Provisioning

### AKS 클러스터 삭제
- 자원 그룹을 지우는 방법과 클러스터를 지우는 방법이 있음

#### Azure Cluster 삭제
- 조회
  ```
  az aks list -o table
  Name                  Location      ResourceGroup    KubernetesVersion    ProvisioningState    Fqdn
  --------------------  ------------  ---------------  -------------------  -------------------  ------------------------------------------------------------
  aks-cluster-taeeyoul  koreacentral  rg-aks           1.17.13              Succeeded            aks-cluste-rg-aks-cafbe4-acad8595.hcp.koreacentral.azmk8s.io
  ```

- 삭제
  ```
  az aks delete -n aks-cluster-taeeyoul -g rg-aks
  Are you sure you want to perform this operation? (y/n): y
  ```

#### Azure 자원 그룹 조회
```
PS D:\workspace\SKT Azure Landing Zone> az group list

[
  {
    "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/rg-log-archive-prd",
    "location": "koreacentral",
    "managedBy": null,
    "name": "rg-log-archive-prd",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": {
      "environment": "prd"
    },
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/AKSTEST",
    "location": "koreacentral",
    "managedBy": null,
    "name": "AKSTEST",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": null,
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/DefaultResourceGroup-SE",
    "location": "koreacentral",
    "managedBy": null,
    "name": "DefaultResourceGroup-SE",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": null,
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/MC_AKSTEST_myAKSCluster_koreacentral",
    "location": "koreacentral",
    "managedBy": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourcegroups/AKSTEST/providers/Microsoft.ContainerService/managedClusters/myAKSCluster",
    "name": "MC_AKSTEST_myAKSCluster_koreacentral",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": {},
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/NetworkWatcherRG",
    "location": "koreacentral",
    "managedBy": null,
    "name": "NetworkWatcherRG",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": null,
    "type": "Microsoft.Resources/resourceGroups"
  }
]
```
#### 그룹 목록 보기
```
az group list -o table
Name                                         Location       Status
-------------------------------------------  -------------  ---------
cloud-shell-storage-southeastasia            southeastasia  Succeeded
DefaultResourceGroup-SE                      koreacentral   Succeeded
NetworkWatcherRG                             koreacentral   Succeeded
rg-function-app-taeeyoul                     koreacentral   Succeeded
rg-aks                                       koreacentral   Succeeded
MC_rg-aks_aks-cluster-taeeyoul_koreacentral  koreacentral   Succeeded
```

#### Cluster 에 HTTP Application 라우팅 사용
##### 기존 AKS Cluster 에 추가하기
```
PS D:\workspace\SKT Azure Landing Zone> az aks enable-addons --resource-group rg-aks --name aks-cluster-taeeyoul --addons http_application_routing

AAD role propagation done[############################################]  100.0000%{
  "aadProfile": null,
  "addonProfiles": {
    "KubeDashboard": {
      "config": null,
      "enabled": true,
      "identity": null
    },
    "httpApplicationRouting": {
      "config": {
        "HTTPApplicationRoutingZoneName": "9a437d8329ab4b9aa5c6.koreacentral.aksapp.io"
      },
      "enabled": true,
      "identity": null
    },
    "omsagent": {
      "config": {
        "logAnalyticsWorkspaceResourceID": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourcegroups/defaultresourcegroup-se/providers/microsoft.operationalinsights/workspaces/defaultworkspace-6da41482-181c-4758-9ec4-79ea38643a52-se"
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
      "nodeImageVersion": "AKSUbuntu-1604-2020.10.28",
      "nodeLabels": {},
      "nodeTaints": null,
      "orchestratorVersion": "1.17.13",
      "osDiskSizeGb": 128,
      "osDiskType": "Managed",
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
      "vmSize": "Standard_DS2_v2",
      "vnetSubnetId": null
    }
  ],
  "apiServerAccessProfile": null,
  "autoScalerProfile": null,
  "diskEncryptionSetId": null,
  "dnsPrefix": "myAKSClust-AKSTEST-6da414",
  "enablePodSecurityPolicy": null,
  "enableRbac": true,
  "fqdn": "myaksclust-akstest-6da414-6e1b8ce1.hcp.koreacentral.azmk8s.io",
  "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourcegroups/AKSTEST/providers/Microsoft.ContainerService/managedClusters/myAKSCluster",
  "identity": null,
  "identityProfile": null,
  "kubernetesVersion": "1.17.13",
  "linuxProfile": {
    "adminUsername": "azureuser",
    "ssh": {
      "publicKeys": [
        {
          "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2a3eHS3QEzhEhIHtdwTqZUUIyWnezZ2zA2ZLsFfaBHnYroeMWorJ+W2IKU0o0hTc2/e3fOm+63dPzIzBcyEtT8s2zwEel5yRkJHd3IPtovbqS/sqY5XjwTK6StFVzjFZuyy+FZlV/Y459H/LnH0Yib8ynuf1/ISBDF/FF3qlFANvUqX0aGXRUk6Z8RJmJAjjOLO098xg8nkHQHQUqxpFXCPGyvMJXuCl2txdaHywLWaFKG42ILQTNmCLjdWeAzfbG3n9cPGje9qQ5f89eeyq8lDwcY4lAGAs1QcAcBTsJ2Dhd7mChnwz2yDbeXPQUmbAZ/bEfb0gFW9KKOgvlKwLH"
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
          "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/MC_AKSTEST_myAKSCluster_koreacentral/providers/Microsoft.Network/publicIPAddresses/738ad900-7289-41e5-a426-d72113751c52",
          "resourceGroup": "MC_AKSTEST_myAKSCluster_koreacentral"
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
  "nodeResourceGroup": "MC_AKSTEST_myAKSCluster_koreacentral",
  "powerState": {
    "code": "Running"
  },
  "privateFqdn": null,
  "provisioningState": "Succeeded",
  "resourceGroup": "AKSTEST",
  "servicePrincipalProfile": {
    "clientId": "53d2a135-4c08-420f-9bea-9cf22e2d7f50",
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
PS D:\workspace\SKT Azure Landing Zone>
```

#### AKS 을 만든 자원 그룹 삭제
* 명령 수행에 10 분 이상 소요됨
```
PS D:\workspace\SKT Azure Landing Zone> az group delete --name rg-aks

Are you sure you want to perform this operation? (y/n): y
 - Running ..
```
.
.
.
```
```

#### AKS 자원 그룹 삭제 후 조회
* "rg-ask" 삭제시 같이 삭제됨 자원 그룹
  * **"MC_rg-aks_aks-cluster-taeeyoul_koreacentral"**
* "rg-aks" 삭제 후에 남은 자원 그룹
  * **"DefaultResourceGroup-SE"** : "Solution", "Log Analystics workspace" 가 있음
  * **"NetworkWatcherRG"** - Network Watcher 가 있음
```
PS D:\workspace\SKT Azure Landing Zone> az group list

[
  {
    "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/rg-log-archive-prd",
    "location": "koreacentral",
    "managedBy": null,
    "name": "rg-log-archive-prd",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": {
      "environment": "prd"
    },
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/DefaultResourceGroup-SE",
    "location": "koreacentral",
    "managedBy": null,
    "name": "DefaultResourceGroup-SE",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": null,
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/6da41482-181c-4758-9ec4-79ea38643a52/resourceGroups/NetworkWatcherRG",
    "location": "koreacentral",
    "managedBy": null,
    "name": "NetworkWatcherRG",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": null,
    "type": "Microsoft.Resources/resourceGroups"
  }
]
PS D:\workspace\SKT Azure Landing Zone> az aks show --resource-group AKSTEST --name myAKSCluster --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName -o table

Result
-------------------------------------------
9a437d8329ab4b9aa5c6.koreacentral.aksapp.io
```
#### HTTP Routing 사용
- yaml 에 아래와 같이 기술하여 사용
```
annotations:
  kubernetes.io/ingress.class: addon-http-application-routing
```

## Ingress Controller
- 수신 컨트롤러는 역방향 프록시, 구성 가능한 트래픽 라우팅, Kubernetes 서비스에 대한 TLS 종료를 제공하는 소프트웨어입니다.
- Kubernetes 수신 리소스는 개별 Kubernetes 서비스에 대한 수신 규칙 및 라우팅을 구성하는 데 사용됩니다. 수신 컨트롤러 및 수신 규칙을 사용하면 단일 IP 주소를 사용하여 Kubernetes 클러스터의 여러 서비스에 트래픽을 라우팅할 수 있습니다.

### 작업 스크립
```
kubectl create ns ingress-basic

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm install nginx-ingress ingress-nginx/ingress-nginx `
 --namespace ingress-basic `
 --set controller.replicaCount=2 `
 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
 --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux `
 --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux

# Use Helm to deploy an NGINX ingress controller
helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux
```
#### Ingress Controller 만들기
```
PS D:\workspace\SKT Azure Landing Zone> kubectl create namespace ingress-basic
namespace/ingress-basic created
PS D:\workspace\SKT Azure Landing Zone> helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
"ingress-nginx" already exists with the same configuration, skipping
PS D:\workspace\SKT Azure Landing Zone> helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "ingress-nginx" chart repository
Update Complete. ⎈Happy Helming!⎈
PS D:\workspace\SKT Azure Landing Zone> helm install nginx-ingress ingress-nginx/ingress-nginx `
>> --namespace ingress-basic `
>> --set controller.replicaCount=2 `
>> --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
>> --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux `
>> --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux
NAME: nginx-ingress
LAST DEPLOYED: Mon Nov 16 12:30:24 2020
NAMESPACE: ingress-basic
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The ingress-nginx controller has been installed.
It may take a few minutes for the LoadBalancer IP to be available.
You can watch the status by running 'kubectl --namespace ingress-basic get services -o wide -w nginx-ingress-ingress-nginx-controller'

An example Ingress that makes use of the controller:

  apiVersion: networking.k8s.io/v1beta1
  kind: Ingress
  metadata:
    annotations:
      kubernetes.io/ingress.class: nginx
    name: example
    namespace: foo
  spec:
    rules:
      - host: www.example.com
        http:
          paths:
            - backend:
                serviceName: exampleService
                servicePort: 80
              path: /
    # This section is only required if TLS is to be enabled for the Ingress
    tls:
        - hosts:
            - www.example.com
          secretName: example-tls

If TLS is enabled for the Ingress, a Secret containing the certificate and key must also be provided:

  apiVersion: v1
  kind: Secret
  metadata:
    name: example-tls
    namespace: foo
  data:
    tls.crt: <base64 encoded cert>
    tls.key: <base64 encoded key>
  type: kubernetes.io/tls
PS D:\workspace\SKT Azure Landing Zone> kubectl --namespace ingress-basic get services -o wide -w nginx-ingress-ingress-nginx-controller
NAME                                     TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                      AGE   SELECTOR
nginx-ingress-ingress-nginx-controller   LoadBalancer   10.0.245.41   40.82.136.246   80:32596/TCP,443:32161/TCP   23s   app.kubernetes.io/component=controller,app.kubernetes.io/instance=nginx-ingress,app.kubernetes.io/name=ingress-nginx
```

### Demo App 배포
```
PS D:\workspace\SKT Azure Landing Zone> kubectl apply -f aks-helloworld-one.yaml --namespace ingress-basic

deployment.apps/aks-helloworld-one created
service/aks-helloworld-one created
PS D:\workspace\SKT Azure Landing Zone> kubectl apply -f aks-helloworld-two.yaml -n ingress-basic

deployment.apps/aks-helloworld-two created
service/aks-helloworld-two created
```

### 수신 경로 만들기
```
PS D:\workspace\SKT Azure Landing Zone> kubectl apply -f hello-world-ingress.yaml

ingress.networking.k8s.io/hello-world-ingress created
ingress.networking.k8s.io/hello-world-ingress-static created
```

### ingress controller 및 resource 삭제
1. 전체 삭제
  - kubectl delete namespace ingress-basic
2. ingress controller 삭제
  - helm uninstall nginx-ingress --namespace ingress-basic
3. 응용 프로그램 삭제
  - kubectl delete -f aks-helloworld-one.yaml --namespace ingress-basic
  - kubectl delete -f aks-helloworld-two.yaml --namespace ingress-basic
4. ingress 삭제
   - kubectl delete -f hello-world-ingress.yaml
5. namespace 삭제
   - kubectl delete namespace ingress-basic


## az aks stop 사용을 위한 **"az aks-preview 설치"**
### azs-review 설치
```
az extension add --name aks-previes
Traceback (most recent call last):
```

### aks-preview update
```
az extension update --name aks-preview
```

### start, stop  기능 등록

#### 기능 등록
```
az provider register -n Microsoft.ContainerService
```

```
az feature register --namespace "Microsoft.ContainerService" --name "StartStopPreview"
Once the feature 'StartStopPreview' is registered, invoking 'az provider register -n Microsoft.ContainerService' is required to get the change propagated
{
  "properties": {
    "state": "Registering"
  },
  "type": "Microsoft.Features/providers/features"
}
```

#### 등록 확인
```
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/StartStopPreview')].{Name:name,State:properties.state}"
Name                                         State
-------------------------------------------  -----------
Microsoft.ContainerService/StartStopPreview  Registering
```

#### ContainerService 리소스 공급자 등록
```
az provider register --namespace Microsoft.ContainerService
```

#### ContainerService 등록 상태 보기
```
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService')].{Name:name,State:properties.state}"                 
Name                                                                State        
------------------------------------------------------------------  -------------
Microsoft.ContainerService/AAD                                      NotRegistered
Microsoft.ContainerService/ACS-EUAP                                 NotRegistered
Microsoft.ContainerService/ACSVNext                                 NotRegistered
Microsoft.ContainerService/AddContainerInsightsSolution             NotRegistered
Microsoft.ContainerService/AKS-AzurePolicyAutoApprove               NotRegistered
Microsoft.ContainerService/AKS-CanadaCentral                        NotRegistered
Microsoft.ContainerService/AKS-CanadaEast                           NotRegistered
Microsoft.ContainerService/AKS-CentralUS                            NotRegistered
Microsoft.ContainerService/AKS-EastUS                               NotRegistered
Microsoft.ContainerService/AKS-EnableAzureDataPlanePolicy           NotRegistered
Microsoft.ContainerService/AKS-INT                                  NotRegistered
Microsoft.ContainerService/AKS-RegionEarlyAccess                    NotRegistered
Microsoft.ContainerService/AKS-UKWest                               NotRegistered
Microsoft.ContainerService/AKSAuditLog                              NotRegistered
Microsoft.ContainerService/AKS-WestUS2                              NotRegistered
Microsoft.ContainerService/AksBypassRegionWritesDisabled            NotRegistered
Microsoft.ContainerService/AKSAzureStandardLoadBalancer             NotRegistered
Microsoft.ContainerService/AKSHTTPCustomFeatures                    NotRegistered
Microsoft.ContainerService/AksBypassServiceGate                     NotRegistered
Microsoft.ContainerService/AKSLockingDownEgressPreview              NotRegistered
Microsoft.ContainerService/AKSImage                                 NotRegistered
Microsoft.ContainerService/AllowPreReleaseRegions                   NotRegistered
Microsoft.ContainerService/AKSPrivateLinkPreview                    NotRegistered
Microsoft.ContainerService/AllowSwarmWindowsAgent                   NotRegistered
Microsoft.ContainerService/AllowValidationRegions                   NotRegistered
Microsoft.ContainerService/APIServerSecurityPreview                 NotRegistered
Microsoft.ContainerService/AROGA                                    NotRegistered
Microsoft.ContainerService/ARORemoteGateway                         NotRegistered
Microsoft.ContainerService/AvailabilityZonePreview                  NotRegistered
Microsoft.ContainerService/ControlPlaneUnderlay                     NotRegistered
Microsoft.ContainerService/DockerEngineImage                        NotRegistered
Microsoft.ContainerService/EnableCCPMutatingWebhook                 NotRegistered
Microsoft.ContainerService/EnableNetworkPolicy                      NotRegistered
Microsoft.ContainerService/EnableSingleIPPerCCP                     NotRegistered
Microsoft.ContainerService/HTTP-Application-Routing                 NotRegistered
Microsoft.ContainerService/EnableXTablesLock                        NotRegistered
Microsoft.ContainerService/ManagedCluster                           NotRegistered
Microsoft.ContainerService/LowPriorityPoolPreview                   NotRegistered
Microsoft.ContainerService/MSIPreview                               NotRegistered
Microsoft.ContainerService/MobyImage                                NotRegistered
Microsoft.ContainerService/MultiAgentpoolPreview                    NotRegistered
Microsoft.ContainerService/NodePublicIPPreview                      NotRegistered
Microsoft.ContainerService/OpenVPN                                  NotRegistered
Microsoft.ContainerService/OpenshiftManagedCluster                  NotRegistered
Microsoft.ContainerService/OSABypassMarketplace                     NotRegistered
Microsoft.ContainerService/OSAInProgressFeature                     NotRegistered
Microsoft.ContainerService/PodSecurityPolicyPreview                 NotRegistered
Microsoft.ContainerService/RBAC                                     NotRegistered
Microsoft.ContainerService/V20180331API                             NotRegistered
Microsoft.ContainerService/SaveOSATestConfig                        NotRegistered
Microsoft.ContainerService/WindowsPreview                           NotRegistered
Microsoft.ContainerService/VMSSPreview                              NotRegistered
Microsoft.ContainerService/PrivateClusters                          NotRegistered
Microsoft.ContainerService/AROPrivateClusters                       NotRegistered
Microsoft.ContainerService/AAD-V2                                   NotRegistered
Microsoft.ContainerService/AKSNetworkModePreview                    NotRegistered
Microsoft.ContainerService/SpotPoolPreview                          NotRegistered
Microsoft.ContainerService/AKS-NewAPIVersion                        NotRegistered
Microsoft.ContainerService/OSANewUnderlayTesting                    NotRegistered
Microsoft.ContainerService/NodeImageUpgradePreview                  NotRegistered
Microsoft.ContainerService/AKS-IngressApplicationGatewayAddon       NotRegistered
Microsoft.ContainerService/Gen2VMPreview                            NotRegistered
Microsoft.ContainerService/MaxSurgePreview                          NotRegistered
Microsoft.ContainerService/OpenShiftSupportGate                     NotRegistered
Microsoft.ContainerService/EnableAzureRBACPreview                   NotRegistered
Microsoft.ContainerService/ProximityPlacementGroupPreview           NotRegistered
Microsoft.ContainerService/EnableEncryptionAtHostPreview            NotRegistered
Microsoft.ContainerService/EnableAzureDiskFileCSIDriver             NotRegistered
Microsoft.ContainerService/useContainerd                            NotRegistered
Microsoft.ContainerService/ContainerRuntime                         NotRegistered
Microsoft.ContainerService/GPUDedicatedVHDPreview                   NotRegistered
Microsoft.ContainerService/AKS-OMSAppMonitoring                     NotRegistered
Microsoft.ContainerService/UserAssignedIdentityPreviewInternalTest  NotRegistered
Microsoft.ContainerService/EnableUltraSSD                           NotRegistered
Microsoft.ContainerService/UserAssignedIdentityPreview              NotRegistered
Microsoft.ContainerService/AKS-GitOps                               NotRegistered
Microsoft.ContainerService/AKS-ConfidentialComputingAddon           NotRegistered
Microsoft.ContainerService/UseCustomizedUbuntuPreview               Registered
Microsoft.ContainerService/UseCustomizedContainerRuntime            Registered
Microsoft.ContainerService/EnableEphemeralOSDiskPreview             Registered
Microsoft.ContainerService/StartStopPreview                         Registered
```

### az aks stop 수행
#### az aks stop -g rg-aks-taeyeol -n aks-cluster-taeyeol
```
BadRequestError: Operation failed with status: 'Bad Request'. Details: Client Error: Stopping a cluster is not supported when autoscaling is turned on. Please turn 
off autoscaling, then try again.
```

#### az aks list -o table
```
Name                 Location      ResourceGroup    KubernetesVersion    ProvisioningState    Fqdn
-------------------  ------------  ---------------  -------------------  -------------------  --------------------------------------------------------------------
aks-cluster-taeyeol  koreacentral  rg-aks-taeyeol   1.20.5               Succeeded            aks-cluste-rg-aks-taeyeol-9ebb0d-086edc6b.hcp.koreacentral.azmk8s.io
```

#### VMSS 보기
```
az vmss list -g rg-aks-cluster-taeyeol -o table
Name                         ResourceGroup           Location      Zones    Capacity    Overprovision    UpgradePolicy
---------------------------  ----------------------  ------------  -------  ----------  ---------------  ---------------
aks-taeyeol01-13907612-vmss  rg-aks-cluster-taeyeol  koreacentral           0           False            Manual
```
#### 확장 집합의 VM 인스턴스에 연결할 주소와 포트를 나열
- Node Pool 이 private ip 를 부여 받아 조회가 안됨
```
az vmss list-instance-connection-info `
>> --resource-group rg-aks-cluster-taeeyoul `
>> --name aks-taeeyoul1-16504745-vmss
No load balancer exists to retrieve public IP address
```

### vmss stop
- vmss 내의 vm 을 정지시킴
az vmss stop -n aks-taeyeol01-13907612-vmss -g rg-aks-cluster-taeyeol
```
az vmss stop -n aks-taeyeol01-13907612-vmss -g rg-aks-cluster-taeyeol
About to power off the VMSS instances...
They will continue to be billed. To deallocate VMSS instances, run: az vmss deallocate.
 - Running ..
```
.  
.  
.  
```
About to power off the VMSS instances...
They will continue to be billed. To deallocate VMSS instances, run: az vmss deallocate.
```
```
kubectl get node
NAME                                STATUS     ROLES   AGE     VERSION
aks-taeeyoul1-16504745-vmss000000   NotReady   agent   3h12m   v1.19.3
```

### vmss start
- vmss 내의 vm 을 시작함
  ```
  az vmss start -n aks-taeyeol01-13907612-vmss -g rg-aks-cluster-taeyeol
  ```


  ```
  kubectl get node
  NAME                                STATUS   ROLES   AGE     VERSION
  aks-taeeyoul1-16504745-vmss000000   Ready    agent   3h13m   v1.19.3
  ```

### AKS Upgrade
#### Upgrade 가능 버전 조회
```
az aks get-upgrades --resource-group rg-aks-taeyeol --name aks-cluster-taeyeol
```


```
az aks get-upgrades --resource-group rg-aks-taeyeol --name aks-cluster-taeyeol -o table
```
```
The behavior of this command has been altered by the following extension: aks-preview
Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  ---------------
default  rg-aks           1.17.13          1.18.8, 1.18.10
```
```
The behavior of this command has been altered by the following extension: aks-preview
Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  --------------
default  rg-aks           1.18.10          1.19.1, 1.19.3
```

```
The behavior of this command has been altered by the following extension: aks-preview
Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  --------------
default  rg-aks-taeyeol   1.19.9           1.20.2, 1.20.5
```

- upgrade 후 조회하면 다음 버전을 upgrade 가능하다고 표시함(1 단계씩 Upgrade 가능)
  - 새로 설치했을 때 초기 버전이 1.18.10 이었음
```
Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  --------------
default  rg-aks           1.18.10          1.19.1, 1.19.3
```



#### Upgrade
- 1.19.9 -> 1.20.2 으로 upgrade 요청
  ```
  az aks upgrade -g rg-aks-taeyeol -n aks-cluster-taeyeol --kubernetes-version 1.20.2
  ```

  ```
  az aks upgrade -g rg-aks-taeyeol -n aks-cluster-taeyeol --kubernetes-version 1.20.2
  The behavior of this command has been altered by the following extension: aks-preview
  Kubernetes may be unavailable during cluster upgrades.
   Are you sure you want to perform this operation? (y/N): y
  Since control-plane-only argument is not specified, this will upgrade the control plane AND all nodepools to version 1.20.2. Continue? (y/N): y
  ```
  ```
  - Running ..
  ```

  ```
    {
      "aadProfile": null,
      "addonProfiles": {
        "httpApplicationRouting": {
          "config": {
            "HTTPApplicationRoutingZoneName": "7d6c077c815e4b9d9c6f.koreacentral.aksapp.io"
          },
          "enabled": true,
          "identity": {
            "clientId": "06d62d8a-3932-4a2f-ae93-a9053b6221be",
            "objectId": "4a616583-013a-480d-934a-5267e3fcc7cb",
            "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/httpapplicationrouting-aks-cluster-taeyeol"
          }
        },
        "omsagent": {
          "config": {
            "logAnalyticsWorkspaceResourceID": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/defaultresourcegroup-se/providers/microsoft.operationalinsights/workspaces/defaultworkspace-9ebb0d63-8327-402a-bdd4-e222b01329a1-se"
          },
          "enabled": true,
          "identity": {
            "clientId": "196afb73-a9fe-4bc7-b612-7698b306544d",
            "objectId": "8924596b-1a54-4851-8b27-09e833224f77",
            "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/omsagent-aks-cluster-taeyeol"
          }
        }
      },
      "agentPoolProfiles": [
        {
          "availabilityZones": null,
          "count": 1,
          "enableAutoScaling": true,
          "enableEncryptionAtHost": false,
          "enableNodePublicIp": false,
          "kubeletConfig": null,
          "kubeletDiskType": "OS",
          "linuxOsConfig": null,
          "maxCount": 4,
          "maxPods": 110,
          "minCount": 1,
          "mode": "System",
          "name": "taeyeol01",
          "nodeImageVersion": "AKSUbuntu-1804gen2containerd-2021.03.31",
          "nodeLabels": {},
          "nodePublicIpPrefixId": null,
          "nodeTaints": null,
          "orchestratorVersion": "1.20.2",
          "osDiskSizeGb": 128,
          "osDiskType": "Ephemeral",
          "osType": "Linux",
          "podSubnetId": null,
          "powerState": {
            "code": "Running"
          },
          "provisioningState": "Succeeded",
          "proximityPlacementGroupId": null,
          "scaleSetEvictionPolicy": null,
          "scaleSetPriority": null,
          "spotMaxPrice": null,
          "tags": {
            "environment": "poc",
            "owner": "taeyeol",
            "personalinformation": "no",
            "servicetitle": "aks"
          },
          "type": "VirtualMachineScaleSets",
          "upgradeSettings": null,
          "vmSize": "Standard_DS3_v2",
          "vnetSubnetId": null
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
      "azurePortalFqdn": "aks-cluste-rg-aks-taeyeol-9ebb0d-086edc6b.portal.hcp.koreacentral.azmk8s.io",
      "diskEncryptionSetId": null,
      "dnsPrefix": "aks-cluste-rg-aks-taeyeol-9ebb0d",
      "enablePodSecurityPolicy": false,
      "enableRbac": true,
      "fqdn": "aks-cluste-rg-aks-taeyeol-9ebb0d-086edc6b.hcp.koreacentral.azmk8s.io",
      "fqdnSubdomain": null,
      "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-taeyeol/providers/Microsoft.ContainerService/managedClusters/aks-cluster-taeyeol",
      "identity": {
        "principalId": "40041465-caa8-4813-b03b-5205e3a6980c",
        "tenantId": "160bacea-7761-4c83-bfa0-354f9b047f5a",
        "type": "SystemAssigned",
        "userAssignedIdentities": null
      },
      "identityProfile": {
        "kubeletidentity": {
          "clientId": "65b8ad09-dcb5-4029-8862-1f7f9e929f73",
          "objectId": "b064c9bf-9670-43a8-92b6-1aa526f69b86",
          "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aks-cluster-taeyeol-agentpool"
        }
      },
      "kubernetesVersion": "1.20.2",
      "linuxProfile": {
        "adminUsername": "azureuser",
        "ssh": {
          "publicKeys": [
            {
              "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRvT0lklSoA2kpgrwPJ7o8xPZUDIomRAw6nFnoItrfa9/x9JIBd7phRCitB/dU4gAgHMorAxTZwg6kkOEc5yVJtWClbgV/lkcl+CL9KugerYsrZv2D3TiExCPEbOfnsIESXJYKlQSmaUU8HcZV89RKo1dJoCJhHTj0GNyTf0JgeWBEuu5gquAIVpQ/wXqWLb2I1B0KVoFqoSD5hJ4DOVZr7BycPeiY18MGN68RwuVBcEUEEh5V/bR7Pz/YnEt8QdOCpXEGRN1QJ57/hN6p6B+6Ru0p9o6G+u7+Itn8nph5K5xuwk2sJ6v6ADslCUudBnNhtn6XQhYKsX2a1UHWBF/P"
            }
          ]
        }
      },
      "location": "koreacentral",
      "maxAgentPools": 100,
      "name": "aks-cluster-taeyeol",
      "networkProfile": {
        "dnsServiceIp": "10.0.0.10",
        "dockerBridgeCidr": "172.17.0.1/16",
        "loadBalancerProfile": {
          "allocatedOutboundPorts": null,
          "effectiveOutboundIps": [
            {
              "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aks-cluster-taeyeol/providers/Microsoft.Network/publicIPAddresses/aa570c02-8bf2-45ed-9911-67394ba2050c",
              "resourceGroup": "rg-aks-cluster-taeyeol"
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
        "networkPolicy": "calico",
        "outboundType": "loadBalancer",
        "podCidr": "10.244.0.0/16",
        "serviceCidr": "10.0.0.0/16"
      },
      "nodeResourceGroup": "rg-aks-cluster-taeyeol",
      "podIdentityProfile": null,
      "powerState": {
        "code": "Running"
      },
      "privateFqdn": null,
      "provisioningState": "Succeeded",
      "resourceGroup": "rg-aks-taeyeol",
      "servicePrincipalProfile": {
        "clientId": "msi",
        "secret": null
      },
      "sku": {
        "name": "Basic",
        "tier": "Free"
      },
      "tags": {
        "environment": "poc",
        "personalinformation": "no",
        "servicetitle": "aks"
      },
      "type": "Microsoft.ContainerService/ManagedClusters",
      "windowsProfile": null{
    "aadProfile": null,
    "addonProfiles": {
      "httpApplicationRouting": {
        "config": {
          "HTTPApplicationRoutingZoneName": "6345dc0bdc7e4bbba459.koreacentral.aksapp.io"
        },
        "enabled": true,
        "identity": {
          "clientId": "d34a9b9f-a271-4fc4-bb9c-48c2cd8eda3e",
          "objectId": "be2460b1-6c9c-47f4-8fb4-2081c787b9fc",
          "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/httpapplicationrouting-aks-cluster-taeyeol"
        }
      },
      "omsagent": {
        "config": {
          "logAnalyticsWorkspaceResourceID": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/defaultresourcegroup-se/providers/microsoft.operationalinsights/workspaces/defaultworkspace-9ebb0d63-8327-402a-bdd4-e222b01329a1-se"
        },
        "enabled": true,
        "identity": {
          "clientId": "69fcb727-036f-4730-9cac-4abaa6584545",
          "objectId": "29fcf0c1-3482-4549-abcb-296e76c9553d",
          "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/omsagent-aks-cluster-taeyeol"
        }
      }
    },
    "agentPoolProfiles": [
      {
        "availabilityZones": null,
        "count": 1,
        "enableAutoScaling": true,
        "enableEncryptionAtHost": false,
        "enableFips": false,
        "enableNodePublicIp": false,
        "gpuInstanceProfile": null,
        "kubeletConfig": null,
        "kubeletDiskType": "OS",
        "linuxOsConfig": null,
        "maxCount": 4,
        "maxPods": 110,
        "minCount": 1,
        "mode": "System",
        "name": "taeyeol01",
        "nodeImageVersion": "AKSUbuntu-1804gen2containerd-2021.04.27",
        "nodeLabels": {},
        "nodePublicIpPrefixId": null,
        "nodeTaints": null,
        "orchestratorVersion": "1.20.2",
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
        "scaleSetEvictionPolicy": null,
        "scaleSetPriority": null,
        "spotMaxPrice": null,
        "tags": {
          "environment": "poc",
          "owner": "taeyeol",
          "personalinformation": "no",
          "servicetitle": "aks"
        },
        "type": "VirtualMachineScaleSets",
        "upgradeSettings": null,
        "vmSize": "Standard_DS3_v2",
        "vnetSubnetId": null
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
    "azurePortalFqdn": "aks-cluste-rg-aks-taeyeol-9ebb0d-4845387c.portal.hcp.koreacentral.azmk8s.io",
    "disableLocalAccounts": null,
    "diskEncryptionSetId": null,
    "dnsPrefix": "aks-cluste-rg-aks-taeyeol-9ebb0d",
    "enablePodSecurityPolicy": false,
    "enableRbac": true,
    "extendedLocation": null,
    "fqdn": "aks-cluste-rg-aks-taeyeol-9ebb0d-4845387c.hcp.koreacentral.azmk8s.io",
    "fqdnSubdomain": null,
    "httpProxyConfig": null,
    "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-taeyeol/providers/Microsoft.ContainerService/managedClusters/aks-cluster-taeyeol",
    "identity": {
      "principalId": "ef03aaaa-59e4-4a69-b93d-31800b87c50d",
      "tenantId": "160bacea-7761-4c83-bfa0-354f9b047f5a",
      "type": "SystemAssigned",
      "userAssignedIdentities": null
    },
    "identityProfile": {
      "kubeletidentity": {
        "clientId": "8c109d7d-e9a6-4b90-b0f6-99ee9a6dd4fd",
        "objectId": "ac3af60e-840a-49a9-b3bb-50a5d173a326",
        "resourceId": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-aks-cluster-taeyeol/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aks-cluster-taeyeol-agentpool"
      }
    },
    "kubernetesVersion": "1.20.2",
    "linuxProfile": {
      "adminUsername": "azureuser",
      "ssh": {
        "publicKeys": [
          {
            "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6lazCoGwgA0/8VJ/wtpSB6PRiPasVqDiJn6zwpRyvplw2V7X5kS0izKI/VFOrWBuaVBmC40Zx1VFnkXZqc5uynSGqC2jDaBlkkxNuNvce9Uy1D05kJI63yyI/ObsJT4XHpHe4O8bZwl2oOzt1qdRwomE7APGOa6uK0y5pJ4Hn4TIbF1JjKsJAJl1WplBUtpvqSXusB3iwtaGyy6w6Akti8kHCbEN9CmAU3CQViCCGDvuFhGCT4GrJ61Lm6uhrLPGqML5tvofwg5XvD0sKwCeev1muB7rUejZTx2TrlWiUhyzSvQ4sGb9A6OVLnv/s+tC0dgQ8IhbDl7gISXBcfwP+KuuXAxr8tjNVMWLwMNCEKG3n0uxVcfZlB2AKAIsrynpNyfI5GxYBl9wfRr5xW1CHPo/UQLGEvhoePducJdpXfhNPKsCIhZpRGaA6lvn3Gb16lzl9uWzNTdbYd9ygSFSRWboWajoHAq8SqvruqPtMP+qjgogyynz8huIWMnJKnSM= generated-by-azure"
          }
        ]
      }
    },
    "location": "koreacentral",
    "maxAgentPools": 100,
    "name": "aks-cluster-taeyeol",
    "networkProfile": {
      "dnsServiceIp": "10.0.0.10",
      "dockerBridgeCidr": "172.17.0.1/16",
      "loadBalancerProfile": {
        "allocatedOutboundPorts": null,
        "effectiveOutboundIps": [
          {
            "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aks-cluster-taeyeol/providers/Microsoft.Network/publicIPAddresses/06abe34d-09e9-435c-a7a6-89707f949cb6",
            "resourceGroup": "rg-aks-cluster-taeyeol"
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
      "networkPolicy": "calico",
      "outboundType": "loadBalancer",
      "podCidr": "10.244.0.0/16",
      "serviceCidr": "10.0.0.0/16"
    },
    "nodeResourceGroup": "rg-aks-cluster-taeyeol",
    "podIdentityProfile": null,
    "powerState": {
      "code": "Running"
    },
    "privateFqdn": null,
    "privateLinkResources": null,
    "provisioningState": "Succeeded",
    "resourceGroup": "rg-aks-taeyeol",
    "servicePrincipalProfile": {
      "clientId": "msi",
      "secret": null
    },
    "sku": {
      "name": "Basic",
      "tier": "Free"
    },
    "tags": {
      "environment": "poc",
      "personalinformation": "no",
      "servicetitle": "aks"
    },
    "type": "Microsoft.ContainerService/ManagedClusters",
    "windowsProfile": null
  }
  ```

  ```
  kubectl get node
  NAME                                STATUS   ROLES   AGE   VERSION
  aks-taeyeol01-13907612-vmss000000   Ready    agent   5m4s   v1.20.2
  ```

  ```
  az aks get-upgrades -g rg-aks-taeyeol --name aks-cluster-taeyeol  -o table
  The behavior of this command has been altered by the following extension: aks-preview
  Name     ResourceGroup    MasterVersion    Upgrades
  -------  ---------------  ---------------  ----------
  default  rg-aks-taeyeol   1.20.2           1.20.5
  ```

  ```
  az aks upgrade -g rg-aks-taeyeol -n aks-cluster-taeyeol --kubernetes-version 1.20.5
  kubectl get node
  NAME                                STATUS   ROLES   AGE    VERSION
  aks-taeyeol01-13907612-vmss000000   Ready    agent   4m3s   v1.20.5
  ```
#### AKS 상태 보기
```
az aks list | jq .[].powerState.code
"Running"
```
```
az aks show -n aks-cluster-taeyeol -g  rg-aks-taeyeol  | jq .powerState.code
WARNING: The behavior of this command has been altered by the following extension: aks-preview
"Running"
```

### AKS 삭제
#### 삭제 대상 조회
```
az aks list -o table
Name                 Location      ResourceGroup    KubernetesVersion    ProvisioningState    Fqdn
-------------------  ------------  ---------------  -------------------  -------------------  --------------------------------------------------------------------
aks-cluster-taeyeol  koreacentral  rg-aks-taeyeol   1.20.5               Succeeded            aks-cluste-rg-aks-taeyeol-9ebb0d-4845387c.hcp.koreacentral.azmk8s.io
```
#### AKS 삭제
```
az aks delete -n aks-cluster-taeyeol -g rg-aks-taeyeol
Are you sure you want to perform this operation? (y/n): y
```

#### 삭제 결과 조회
```
az aks list -o table
```

