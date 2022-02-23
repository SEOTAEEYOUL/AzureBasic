# AKS Monitoring
- aks 의 경우 addons monitoring 을 배포해야 monitor 의 insights 의 container 로 AKS 를 모니터링 할 수 있음.

## AKS 상의 Agent 배포 확인
kubectl get ds omsagent -n kube-system
```
PS C:\bin> kubectl get ds omsagent -n kube-system
NAME       DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
omsagent   1         1         1       1            1           <none>          19h
PS C:\bin> 
```

## 배포된 AKS Cluster 구성 보기
### 목록 보기
az aks list -o table
```
PS C:\workspace\AzureBasic\2.AKS> az aks list -o table
Name                  Location      ResourceGroup    KubernetesVersion    ProvisioningState    Fqdn
--------------------  ------------  ---------------  -------------------  -------------------  ------------------------------------------------------------------
aks-cluster-Homepage  koreacentral  rg-skcc1-aks     1.21.9               Succeeded            aks-cluste-rg-skcc1-aks-9ebb0d-53587e16.hcp.koreacentral.azmk8s.io
PS C:\workspace\AzureBasic\2.AKS> 
```
### 간략히 보기
az aks show -g rg-skcc1-aks -n aks-cluster-Homepage -o table
```
PS C:\workspace\AzureBasic\2.AKS> az aks show -g rg-skcc1-aks -n aks-cluster-Homepage -o table
The behavior of this command has been altered by the following extension: aks-preview
Name                  Location      ResourceGroup    KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
--------------------  ------------  ---------------  -------------------  --------------------------  -------------------  ------------------------------------------------------------------        
aks-cluster-Homepage  koreacentral  rg-skcc1-aks     1.21.9               1.21.9                      Succeeded            aks-cluste-rg-skcc1-aks-9ebb0d-53587e16.hcp.koreacentral.azmk8s.io        
PS C:\workspace\AzureBasic\2.AKS> 
```

### 상세 보기
- addonsProfiles
  - KubeDashboard
  - httpApplicationRouting
  - omsagent
    - logAnalyticsWorkspaceResourceID
az aks show -g rg-skcc1-aks -n aks-cluster-Homepage
```
PS C:\workspace\AzureBasic\2.AKS> az aks show -g rg-skcc1-aks -n aks-cluster-Homepage
The behavior of this command has been altered by the following extension: aks-preview
{
  "aadProfile": null,
  "addonProfiles": {
    "httpApplicationRouting": {
      "config": {
        "HTTPApplicationRoutingZoneName": "22d948da130d47c4a231.koreacentral.aksapp.io"
      },
      "enabled": true,
      "identity": {
        "clientId": "91e8b22c-e25b-43b2-a8ca-774633a4b502",
        "objectId": "0d5bd6e0-43bb-4aa2-8c6d-44aac4b43bbb",
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
        "clientId": "f88c8a7d-902c-49bb-9792-01ab344e680a",
        "objectId": "7c1f6610-20d5-463e-9351-764b69c5c424",
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
      "count": 1,
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
  "azurePortalFqdn": "aks-cluste-rg-skcc1-aks-9ebb0d-53587e16.portal.hcp.koreacentral.azmk8s.io",
  "currentKubernetesVersion": "1.21.9",
  "disableLocalAccounts": false,
  "diskEncryptionSetId": null,
  "dnsPrefix": "aks-cluste-rg-skcc1-aks-9ebb0d",
  "enableNamespaceResources": null,
  "enablePodSecurityPolicy": false,
  "enableRbac": true,
  "extendedLocation": null,
  "fqdn": "aks-cluste-rg-skcc1-aks-9ebb0d-53587e16.hcp.koreacentral.azmk8s.io",
  "fqdnSubdomain": null,
  "httpProxyConfig": null,
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourcegroups/rg-skcc1-aks/providers/Microsoft.ContainerService/managedClusters/aks-cluster-Homepage",
  "identity": {
    "principalId": "ca0865c3-2df1-4141-942c-c66a56154b99",
    "tenantId": "160bacea-7761-4c83-bfa0-354f9b047f5a",
    "type": "SystemAssigned",
    "userAssignedIdentities": null
  },
  "identityProfile": {
    "kubeletidentity": {
      "clientId": "9d5f5204-e501-45c2-8597-ff8ed7fb54a3",
      "objectId": "4e0f5660-c714-48cf-83f9-440d7dcf2e84",
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
          "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aks-cluster-Homepage/providers/Microsoft.Network/publicIPAddresses/41c72c2f-b7a9-4dd0-a953-366dc38e8140",     
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
    "clientId": "msi"
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
PS C:\workspace\AzureBasic\2.AKS> 
```

## AKS Monitor 에서 보기 
### aks-cluster-Homepage > 모니터링 | Insights
- Azure Monitor 선택
  - Insights
    - Container 선택
      > 모니터링되는 클러스터
