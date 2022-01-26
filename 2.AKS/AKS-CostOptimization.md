# AKS(Azure Kubernetes Service) 컴퓨팅 비용 최적화

## Overview 
1. 더 많은 Transaction 처리 필요
2. 더 많은 Application 배포 필요
   * AKS에서 크기가 0으로 조정된 노드 풀을 사용하여 비용 최적화
   * AKS에서 자동으로 크기가 조정된 스폿 노드 풀을 사용하여 비용 최적화
   * AKS에서 Azure Policy를 사용하여 비용 관리

## 사용자 Node Pool 을 구성 하고 Node 수를 0으로 조정하는 방법

### 가정
1. GPU 기반 주중 특정일에 실행되는 예측 모델 서비스가 있음
2. 하루 몇 시간 동안만 실행되는 서비스가 있음

### Node Pool
AKS Cluster 에서 동일한 구성으로 이루어진 노드 그룹으로 System Node Pool 과 User Node Pool 이 있음

1. System Node Pool  
   Control Plain 을 구성하는 중요한 시스템 Pod 를 호스팅
   Node 당 최소 Pod 수 : 30

2. User Node Pool  
   사용자 지정 workload 실행을 위한 호스팅
   Pool 의 Node 수를 0으로 설정 가능

3. Node Pool 의 노드 수  
   100 개의 노드를 구성 가능  
  - "az aks node pool add" 의 **--node-vm-size** 로 Node Pool 크기 설정
  ```
  az aks nodepool add \
    --resource-group resourceGroup \
    --cluster-name aksCluster \
    --name gpunodepool \
    --node-count 1 \
    --node-vm-size Standard_NC6 \
    --no-wait
  ```

  - **az aks nodepool scale** 명령의 **--node-count**을 사용하여 Node Pool 크기 0으로 조정  
  ```
  az aks nodepool scale \
    --resource-group resourceGroup \
    --cluster-name aksCluster \
    --name gpunodepool \
    --node-count 0
  ```

## 자동으로 크기 가 조정된 Spot Node Pool 을 사용하여 비용 최적화
Cluster 의 크기를 자동으로 조정하여 workload 크기를 조정

### Horizontal Pod Autoscaler (HPA)
Kubernetes 의 리소스 수요를 모니터링하여 workload 복제본 수를 자동 조정

### Cluster Auto Scaler
기존 Node 에 Pod 를 예약할 수 없는 경우 리소스 제약 조건이 적용 되어 Cluster 크기가 자동 조정됨

## AKS 에서 Azure Policy 를 사용하여 비용 관리