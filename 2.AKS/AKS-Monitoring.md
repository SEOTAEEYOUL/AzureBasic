# AKS Monitoring
- aks 의 경우 addons monitoring 을 배포해야 monitor 의 insights 의 container 로 AKS 를 모니터링 할 수 있음.

## AKS 상의 Agent 배포 확인

```
 kubectl get ds omsagent -n kube-system
NAME       DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
omsagent   3         3         3       3            3           <none>          28m
```

## 배포된 AKS Cluster 구성 보기
### 간략히 보기
```
az aks show -g rg-aks -n aks-cluster-taeeyoul -o table
Name                  Location      ResourceGroup    KubernetesVersion    ProvisioningState    Fqdn
--------------------  ------------  ---------------  -------------------  -------------------  ------------------------------------------------------------
aks-cluster-taeeyoul  koreacentral  rg-aks           1.17.13              Succeeded            aks-cluste-rg-aks-cafbe4-acad8595.hcp.koreacentral.azmk8s.io
```

### 상세 보기
- addonsProfiles
  - KubeDashboard
  - httpApplicationRouting
  - omsagent
    - logAnalyticsWorkspaceResourceID
```
az aks show -g rg-aks -n aks-cluster-taeeyoul
{
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
      "vmSize": "Standard_DS2_v2"
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
    "serviceCidr": "10.0.0.0/16"
  },
  "nodeResourceGroup": "MC_rg-aks_aks-cluster-taeeyoul_koreacentral",
  "privateFqdn": null,
  "provisioningState": "Succeeded",
  "resourceGroup": "rg-aks",
  "servicePrincipalProfile": {
    "clientId": "744daeb9-ed97-45a6-889f-3fd1acf89262"
  },
  "sku": {
    "name": "Basic",
    "tier": "Free"
  },
  "type": "Microsoft.ContainerService/ManagedClusters",
  "windowsProfile": null
}
```

## AKS Monitor 에서 보기
- Azure Monitor 선택
  - Insights
    - Container 선택
      > 모니터링되는 클러스터
