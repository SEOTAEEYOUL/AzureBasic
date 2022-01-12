# Azure Cloud 3 Tier (AKS 기반)

> [AKS 클러스터 구성](https://docs.microsoft.com/ko-kr/azure/aks/cluster-configuration)  
> [AKS(Azure Kubernetes Service)에서 애플리케이션 수요에 맞게 자동으로 클러스터 크기 조정](https://docs.microsoft.com/ko-kr/azure/aks/cluster-autoscaler)  
> [가용성 영역을 사용하는 AKS(Azure Kubernetes Service) 클러스터 만들기](https://docs.microsoft.com/ko-kr/azure/aks/availability-zones)

### Kubernetes 에 최적화된 VM
- --node-vm-size Standard_DS3_v2
-  --node-osdisk-type Ephemeral 
-  --nodepool-tags owner=ChatOps environment=ChatOps personalinformation=no servicetitle=ChatOp
-  --vm-set-type VirtualMachineScaleSets \
-  UltraDisk 
  - 상태 저장 응용 프로그램에 대해 높은 처리량, 높은 IOPS 및 일관 된 짧은 대기 시간 디스크 저장소를 제공
  - --aks-custom-headers EnableUltraSSD=true : 
