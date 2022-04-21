# [Azure Container Instance](https://docs.microsoft.com/ko-kr/azure/container-instances/container-instances-overview)    
- ACI Private VNet 배포의 경우 'koreacentral'로 잘 안만들어지는 경우가 발생함(location 'eastus' 변경하면 잘 만들어짐)  
- ACI Public 은 한국중부(koreacentral) 에서도 잘 만들어짐  
- [Azure Container Instances에서 Azure 파일 공유 탑재](https://docs.microsoft.com/ko-kr/azure/container-instances/container-instances-volume-azure-files)

> [Azure 지역의 Azure Container Instances에 대한 리소스 가용성](https://docs.microsoft.com/ko-kr/azure/container-instances/container-instances-region-availability)  
> [Azure Container Instances 할당량 및 제한](https://docs.microsoft.com/ko-kr/azure/container-instances/container-instances-quotas)  

**http://aci-springmysql.koreacentral.azurecontainer.io:8080/**  
![springmysql.koreacentral.azurecontainer.io-8080.png](./img/springmysql.koreacentral.azurecontainer.io-8080.png)  

## 환경
| 구분 | 내용 |
|:---|:---|
| O/S | Windows | |
| Shell | PowerShell | 7.2.2 |  
| Command | az | Azure CLI |  
| image | mcr.microsoft.com/azuredocs/aci-helloworld:latest | 1 CPU, 1.5 GiB |  
| registry-login-server | acrhomeeee.azurecr.io | |
| registry-username | acrHomeeee | |
| registry-password | Ax2BMk0y828RhmnGQyxOhH=H2Ggun1bt | |
| image | acrhomeeee.azurecr.io/springmysql:0.2.2 | springboot | 
| os-type | linux | default value |  
| cpu | 1 | default value |  
| memory | 1.5 | default value |  
| ports | 8080 | default 80 |  
| dns-name | springmysql | public 일 경우만 사용 |  
| vnet | vnet-skcc7-dev |  |  
| vnet-address-prefix | 10.0.0.0/16  | default value : 10.0.0.0/16 |  
| subnet | snet-skcc7-dev-frontend | |
| subnet-address-prefix | '10.0.0.0/24' | default value : '10.0.0.0/24' |

### Container 정보
| 구분 | 내용 |
|:---|:---|
| Container Registry | acrHomeeee |  
| Container Repository | springmysql |  
| Container Image Tag | 0.3.1 |  
| Container Instance | aci-springmysql |  
| Container Listen Port | 8080 |

## Group 생성
```powershell
$groupName = "rg-aci"
# $location = "koreacentral"
$location = "eastus"
$aciName = "aci-springmysql"
$acrName = "acrHomeeee"
$loginServer = "acrhomeeee.azurecr.io"
$user = "acrHomeeee"
$password = 'Ax2BMk0y828RhmnGQ***hH=******' # ACR 의 Access Key 의 것 사용
$repositoryName="springmysql"
$tag='0.2.2'

az group create `
  --name $groupName `
  --location $location


az acr repository show-tags -o table -n $acrName --repository ${repositoryName}
```

## 컨테이너 만들기 
### Private IP 및 Linux 사용
- private network, subnet 에 대한 설정이 있음
- dns 에 대한 설정이 없음

```powershell
$location = 'koreacentral'
az container create `
  --resource-group $groupName `
  --name $aciName `
  --registry-login-server $loginServer `
  --registry-username $user `
  --registry-password $password `
  --image acrhomeeee.azurecr.io/springmysql:0.2.2 `
  --ip-address Private `
  --location $location `
  --os-type linux `
  --cpu 1 `
  --memory 1.5 `
  --vnet vnet-skcc7-dev `
  --vnet-address-prefix '10.0.0.0/16' `
  --subnet snet-skcc7-dev-frontend `
  --subnet-address-prefix '10.0.0.0/24' `
  --restart-policy Always `
  --environment-variables NumWords=3 MinLength=5 `
  --ports 8080 `
  --protocol TCP
```

#### 오류로그
- 버그 인것 같은데 azure 에서 종종 나타나는 현상처럼 보임
- [Azure Container Instances VNET Error](https://docs.microsoft.com/en-us/answers/questions/31325/azure-container-instances-vnet-error.html)
```
(ServiceUnavailable) The requested resource is not available in the location 'koreacentral' at this moment. Please retry with a different resource request or in another location. Resource requested: '1' CPU '1.5' GB memory 'Linux' OS virtual network
Code: ServiceUnavailable
Message: The requested resource is not available in the location 'koreacentral' at this moment. Please retry with a different resource request or in another location. Resource requested: '1' CPU '1.5' GB memory 'Linux' OS virtual network
```

#### 'eastus' 에 vnet 만들고 재 실행  

| 항목 | 값 | 비고 |  
|:---|:---|:---|
| location | eastus | 한국 중부에서 오류 발생하여 안 만들어질 경우 사용 |
| VNet | vnet-aci | 10.2.0.0/16 |  
| subnet | snet-aci-dev-frontend | 10.2.1.0/24 |  

```
$location = 'eastus'

az container create `
    --resource-group $groupName `
    --name $aciName `
    --registry-login-server $loginServer `
    --registry-username $user `
    --registry-password $password `
    --image acrhomeeee.azurecr.io/springmysql:0.2.2 `
    --ip-address private `
    --location $location `
    --os-type linux `
    --cpu 1 `
    --memory 1.5 `
    --vnet vnet-aci `
    --vnet-address-prefix '10.2.0.0/16' `
    --subnet snet-aci-dev-frontend `
    --subnet-address-prefix '10.2.1.0/24' `
    --restart-policy Always `
    --environment-variables NumWords=3 MinLength=5 `
    --ports 8080 `
    --protocol TCP
```

### 실행 결과
```
PS D:\workspace\SpringBootMySQL> az network vnet list -g rg-aci -o table
Name            ResourceGroup    Location      NumSubnets    Prefixes     DnsServers    DDOSProtection
--------------  ---------------  ------------  ------------  -----------  ------------  ----------------
vnet-aci        rg-aci           eastus        2             10.2.0.0/16                False
vnet-skcc7-dev  rg-aci           koreacentral  1             10.0.0.0/16                False
PS D:\workspace\SpringBootMySQL> az container create `
>>     --resource-group rg-aci `
>>     --name aci-springmysql `
>>     --registry-login-server 'acrhomeeee.azurecr.io' `
>>     --registry-username 'acrHomeeee' `
>>     --registry-password 'Ax2BMk0y828RhmnGQyxOhH=H2Ggun1bt' `
>>     --image acrhomeeee.azurecr.io/springmysql:0.2.2 `
>>     --ip-address private `
>>     --location 'eastus' `
>>     --os-type linux `
>>     --cpu 1 `
>>     --memory 1.5 `
>>     --vnet vnet-aci `
>>     --vnet-address-prefix '10.2.0.0/16' `
>>     --subnet snet-aci-dev-frontend `
>>     --subnet-address-prefix '10.2.1.0/24' `
>>     --restart-policy Always `
>>     --environment-variables NumWords=3 MinLength=5 `
>>     --ports 8080 `
>>     --protocol TCP
{
  "containers": [
    {
      "command": null,
      "environmentVariables": [
        {
          "name": "NumWords",
          "secureValue": null,
          "value": "3"
        },
        {
          "name": "MinLength",
          "secureValue": null,
          "value": "5"
        }
      ],
      "image": "acrhomeeee.azurecr.io/springmysql:0.2.2",
      "instanceView": {
        "currentState": {
          "detailStatus": "",
          "exitCode": null,
          "finishTime": null,
          "startTime": "2022-04-16T08:14:22+00:00",
          "state": "Running"
        },
        "events": [
          {
            "count": 1,
            "firstTimestamp": "2022-04-16T08:13:44+00:00",
            "lastTimestamp": "2022-04-16T08:13:44+00:00",
            "message": "Pulling image \"acrhomeeee.azurecr.io/springmysql:0.2.2\"",
            "name": "Pulling",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2022-04-16T08:14:21+00:00",
            "lastTimestamp": "2022-04-16T08:14:21+00:00",
            "message": "Successfully pulled image \"acrhomeeee.azurecr.io/springmysql:0.2.2\" in 36.539967124s",
            "name": "Pulled",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2022-04-16T08:14:21+00:00",
            "lastTimestamp": "2022-04-16T08:14:21+00:00",
            "message": "Created container aci-springmysql",
            "name": "Created",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2022-04-16T08:14:22+00:00",
            "lastTimestamp": "2022-04-16T08:14:22+00:00",
            "message": "Started container aci-springmysql",
            "name": "Started",
            "type": "Normal"
          }
        ],
        "previousState": null,
        "restartCount": 0
      },
      "livenessProbe": null,
      "name": "aci-springmysql",
      "ports": [
        {
          "port": 8080,
          "protocol": "TCP"
        }
      ],
      "readinessProbe": null,
      "resources": {
        "limits": null,
        "requests": {
          "cpu": 1.0,
          "gpu": null,
          "memoryInGb": 1.5
        }
      },
      "volumeMounts": null
    }
  ],
  "diagnostics": null,
  "dnsConfig": null,
  "encryptionProperties": null,
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aci/providers/Microsoft.ContainerInstance/containerGroups/aci-springmysql",
  "identity": null,
  "imageRegistryCredentials": [
    {
      "identity": null,
      "identityUrl": null,
      "password": null,
      "server": "acrhomeeee.azurecr.io",
      "username": "acrHomeeee"
    }
  ],
  "initContainers": [],
  "instanceView": {
    "events": [
      {
        "count": 1,
        "firstTimestamp": "2022-04-16T08:12:23+00:00",
        "lastTimestamp": "2022-04-16T08:12:23+00:00",
        "message": "Prepare network succeeded.",
        "name": "PrepareNetwork",
        "type": "Normal"
      },
      {
        "count": 1,
        "firstTimestamp": "2022-04-16T08:13:08+00:00",
        "lastTimestamp": "2022-04-16T08:13:08+00:00",
        "message": "Join network failed for \"25451599-9383-4fb1-98d0-986abf78abb5\": Timeout.",
        "name": "JoinNetwork",
        "type": "Warning"
      },
      {
        "count": 1,
        "firstTimestamp": "2022-04-16T08:13:30+00:00",
        "lastTimestamp": "2022-04-16T08:13:30+00:00",
        "message": "Join network succeeded.",
        "name": "JoinNetwork",
        "type": "Normal"
      },
      {
        "count": 1,
        "firstTimestamp": "2022-04-16T08:13:31+00:00",
        "lastTimestamp": "2022-04-16T08:13:31+00:00",
        "message": "Delegate subnet succeeded.",
        "name": "DelegateSubnet",
        "type": "Normal"
      },
      {
        "count": 1,
        "firstTimestamp": "2022-04-16T08:13:34+00:00",
        "lastTimestamp": "2022-04-16T08:13:34+00:00",
        "message": "Provision network interface succeeded.",
        "name": "ProvisionNetworkInterface",
        "type": "Normal"
      }
    ],
    "state": "Running"
  },
  "ipAddress": {
    "autoGeneratedDomainNameLabelScope": "Unsecure",
    "dnsNameLabel": null,
    "fqdn": null,
    "ip": "10.2.1.4",
    "ports": [
      {
        "port": 8080,
        "protocol": "TCP"
      }
    ],
    "type": "Private"
  },
  "location": "eastus",
  "name": "aci-springmysql",
  "osType": "Linux",
  "provisioningState": "Succeeded",
  "resourceGroup": "rg-aci",
  "restartPolicy": "Always",
  "sku": "Standard",
  "subnetIds": [
    {
      "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aci/providers/Microsoft.Network/virtualNetworks/vnet-aci/subnets/snet-aci-dev-frontend",
      "name": null,
      "resourceGroup": "rg-aci"
    }
  ],
  "tags": {},
  "type": "Microsoft.ContainerInstance/containerGroups",
  "volumes": null,
  "zones": null
}
PS D:\workspace\SpringBootMySQL> 
```


### public ip 를 가진 container 만들기 (잘됨)
- private network, subnet 에 대한 설정이 없음
- dns 에 대한 설정이 있음

#### 명령어
```
$aciName = 'springmysql'
$location = "koreacentral"

az container create `
  --resource-group $groupName `
  --name $aciName `
  --registry-login-server $loginServer `
  --registry-username $user `
  --registry-password $password `
  --location $location' `
  --os-type linux `
  --cpu 1 `
  --memory 1.5 `
  --restart-policy Always `
  --dns-name-label $aciName `
  --restart-policy Always `
  --environment-variables NumWords=3 MinLength=5 `
  --ports 8080 `
  --protocol TCP
```

#### 실행결과
```
PS C:\workspace\AzureBasic> $groupName = "rg-aci"
PS C:\workspace\AzureBasic> $location = "koreacentral"
PS C:\workspace\AzureBasic> $containerName = "aci-springmysql"
PS C:\workspace\AzureBasic> $acrName = "acrHomeeee"
PS C:\workspace\AzureBasic> az group create `
>>   --name $groupName `
>>   --location $location
{
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aci",
  "location": "koreacentral",
  "managedBy": null,
  "name": "rg-aci",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
PS C:\workspace\AzureBasic> 
PS C:\workspace\AzureBasic> az acr login -n $acrName --expose-token
You can perform manual login using the provided access token below, for example: 'docker login loginServer -u 00000000-0000-0000-0000-000000000000 -p accessToken'
{
  "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ikk3QjY6NlQ0QTpUWlYzOllJT046Rk9ESjpOWlRDOjVVUFk6M0JWMzpGRlhPOlE1NEs6M0JCSzpHVFgzIn0.eyJqdGkiOiJjOTAxOGU5My0yNDc4LTQwMDAtOWEzZS0zMjU2ODkzMjQ3MDEiLCJzdWIiOiJjYTA3NDU2QHNrdGRhLm9ubWljcm9zb2Z0LmNvbSIsIm5iZiI6MTY0Nzg0NDE4MywiZXhwIjoxNjQ3ODU1ODgzLCJpYXQiOjE2NDc4NDQxODMsImlzcyI6IkF6dXJlIENvbnRhaW5lciBSZWdpc3RyeSIsImF1ZCI6ImFjcmhvbWVlZWUuYXp1cmVjci5pbyIsInZlcnNpb24iOiIxLjAiLCJyaWQiOiJmYmQ3MmViZGNiNGE0YWI4YjM2N2ZlNjljNGMwZTRlZiIsImdyYW50X3R5cGUiOiJyZWZyZXNoX3Rva2VuIiwiYXBwaWQiOiIwNGIwNzc5NS04ZGRiLTQ2MWEtYmJlZS0wMmY5ZTFiZjdiNDYiLCJ0ZW5hbnQiOiIxNjBiYWNlYS03NzYxLTRjODMtYmZhMC0zNTRmOWIwNDdmNWEiLCJwZXJtaXNzaW9ucyI6eyJBY3Rpb25zIjpbInJlYWQiLCJ3cml0ZSIsImRlbGV0ZSJdLCJOb3RBY3Rpb25zIjpudWxsfSwicm9sZXMiOltdfQ.biPkMwnhXPVxBdzaNGxNgIZv1HDnETRLTdeSw0TnBFNW3BCCDo7BDIlO1-DG2-JovY5wwWOdxDQCubM7JQ0b0V9AKsbkm_l_kkC1NDUBQOUOsFGOrlhey7r2EAwSM92xewWql2fexTi-LiYI73BILB_rHeyYRKbJIH0dfJijglaGjnIQsJuLsE-j_7x2wxWKYq7CukOYXwVttLljPwPmcjQB9DGhFeg5WwybIDU_wRbrz8DS7vI0Az0FU-UsHGPtqs4h99B0VDNdh9TFbt5noqhiCb8WAWcgD2FVgsloYmOq44ayUzqWceaCGCl9D0ZOmfnGS2iYW539cqt6URSAjw",
  "loginServer": "acrhomeeee.azurecr.io"
}
PS C:\workspace\AzureBasic> 



PS C:\workspace\AzureBasic> az container logs `
>>   --resource-group $groupName `
>>   --name $containerName
listening on port 80
::ffff:10.92.0.10 - - [21/Mar/2022:07:17:45 +0000] "GET / HTTP/1.1" 200 1663 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36"
::ffff:10.92.0.11 - - [21/Mar/2022:07:17:46 +0000] "GET /favicon.ico HTTP/1.1" 404 150 "http://aci-springmysql.koreacentral.azurecontainer.io/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36"
::ffff:10.92.0.11 - - [21/Mar/2022:07:17:46 +0000] "GET / HTTP/1.1" 200 1663 "http://221.145.1.102/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36"

PS C:\workspace\AzureBasic> az container attach `
>>   --resource-group $groupName `
>>   --name $containerName
Container 'aci-springmysql' is in state 'Running'...

Start streaming logs:
listening on port 80
::ffff:10.92.0.10 - - [21/Mar/2022:07:17:45 +0000] "GET / HTTP/1.1" 200 1663 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36"
::ffff:10.92.0.11 - - [21/Mar/2022:07:17:46 +0000] "GET /favicon.ico HTTP/1.1" 404 150 "http://aci-springmysql.koreacentral.azurecontainer.io/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36"
::ffff:10.92.0.11 - - [21/Mar/2022:07:17:46 +0000] "GET / HTTP/1.1" 200 1663 "http://221.145.1.102/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36"

일괄 작업을 끝내시겠습니까 (Y/N)? y
PS C:\workspace\AzureBasic>
PS C:\workspace\AzureBasic> az container list `
>>   --resource-group $groupName `
>>   --output table
Name             ResourceGroup    Status     Image                                       IP:ports           Network    CPU/Memory       OsType    Location
---------------  ---------------  ---------  ------------------------------------------  -----------------  ---------  ---------------  --------  ------------
aci-springmysql  rg-aci           Succeeded  mcr.microsoft.com/azuredocs/aci-helloworld  20.196.238.248:80  Public     1.0 core/1.5 gb  Linux     koreacentral
PS C:\workspace\AzureBasic> 
```

## 컨테이너 운영 명령어
### 컨테이너 보기
```powershell
az container show `
  --resource-group $groupName `
  --name $containerName `
  --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" `
  --out table
```
```
PS D:\workspace\AzureBasic> az container show `
>>   --resource-group $groupName `
>>   --name $containerName `
>>   --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" `
>>   --out table
FQDN                                            ProvisioningState
----------------------------------------------  -------------------
aci-springmysql.koreacentral.azurecontainer.io  Succeeded
PS D:\workspace\AzureBasic> 
```

### 컨테이너 목록 보기
```
az container list  -g rg-aci  -o table 
```


### 컨테이너 로그 보기
```powershell
az container logs `
  --resource-group $groupName `
  --name $containerName
```

### 출력 스트림 연결
```powershell
az container attach `
  --resource-group $groupName `
  --name $containerName
```

## 리소스 정리
```powershell
az container list `
  --resource-group $groupName `
  --output table

az group delete `
  --name $groupName
```
