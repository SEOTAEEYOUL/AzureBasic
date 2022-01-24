# ACR 및 AKS 클러스터 생성하기

사전 준비
```
az feature register --namespace "Microsoft.ContainerService" --name "EnableAzureRBACPreview"
az provider register --namespace Microsoft.OperationsManagement
az provider register --namespace Microsoft.OperationalInsights
```

ACR 생성하고 로그인하기
```
az acr create --resource-group RG-ChatOps --name acrChatOps --sku Basic
az acr list -o table
az acr login --name acrChatOps
```

AKS 생성하고 ACR 붙이기
```
az aks create \
  --tags environment=ChatOps personalinformation=no servicetitle=ChatOps \
  --resource-group RG-ChatOps \
  --name aks-cluster-ChatOps \
  --node-resource-group rg-aks-cluster-ChatOps \
  --aks-custom-headers CustomizedUbuntu=aks-ubuntu-1804,ContainerRuntime=containerd \
  --node-osdisk-type Ephemeral \
  --nodepool-name chatops01 \
  --nodepool-tags owner=ChatOps environment=ChatOps personalinformation=no servicetitle=ChatOps \
  --node-vm-size Standard_DS3_v2 \
  --node-count 1 \
  --vm-set-type VirtualMachineScaleSets \
  --load-balancer-sku standard \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 4 \
  --cluster-autoscaler-profile scan-interval=30s \
  --network-plugin kubenet \
  --network-policy calico \
  --service-cidr 10.0.0.0/16 \
  --dns-service-ip 10.0.0.10 \
  --pod-cidr 10.244.0.0/16 \
  --docker-bridge-address 172.17.0.1/16 \
  --enable-addons http_application_routing,monitoring \
  --generate-ssh-keys \
  --attach-acr acrChatOps
 ``` 

Attach만 따로 업데이트를 할 때 사용하는 명령어
```
az aks update -n aks-cluster-ChatOps -g RG-ChatOps --attach-acr acrChatOps
```

AKS 업데이트
```
az aks get-upgrades --resource-group RG-ChatOps --name aks-cluster-ChatOps -o table
az aks upgrade -g RG-ChatOps -n aks-cluster-ChatOps --kubernetes-version 1.20.5
```

Kubectrl과 AKS 클러스터와 다시 연결하기
```
az aks get-credentials --resource-group RG-ChatOps --name aks-cluster-ChatOps
kubectl get nodes
```

AKS 중지
```
az aks list -o table                                # 이건 확인하기 위해서
az aks stop -g RG-ChatOps -n aks-cluster-ChatOps    # node group의 크기를 0으로 줄임
```

## 주의

- 게스트로 초대된 사용자는 AD 접속 권한이 없어 위의 명령 수행 시 특히 ```--attach-acr``` 옵션 수행 중에 에러가 발생합니다.  
  이는 사용자가 '소유자' 권한을 얻었더라도 같은 결과가 나옵니다.
  이를 피하기 위해서는 다음 작업이 필요합니다:
  * Azure Active Directory에 그룹 추가
  * 추가한 그룹에 '소유자' 권한 할당
  * 같은 그룹에 사용자 추가 ( user_id@creatoridskcom.onmicrosoft.com 같은 형태로 만들어짐 )
  * 이후 사용자들은 2차 인증은 각자 설정 (자기 email을 등록하든지)
  * 기존에 게스트로 초대된 사용자를 승격하는 방법은 아직 모릅니다. 2021-05-21 현재 기존 사용자는 권한을 박탈했습니다.


