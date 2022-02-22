# Azure Kubernetes Service 구성
AKS Cluster 설계 및 생성, 로깅, 모니터링 하기
- 3 tier 를 Pod 롤 배포하기
- CDN, mysql(Managed, DaemonSet) 구성
- Ingress Controller 구성
- DNS 에 등록 외부에서 접근하기

## [AKS(Azure Kubernetes Service)](./AKS.md)  
- Azure에서 관리되는 Kubernetes 클러스터 배포를 단순화  
- Azure에서 Kubernetes Master 를 관리  
- 상태 모니터링 및 유지 관리 같은 중요 작업을 처리  
- Worker Node(Agent(kubelet) Node) 에 대해서 비용 지불  
### [AKS Ingress Controller](./AKS-IngressController.md)  
HTTP(S) 기반의 L7 로드밸런싱 기능을 제공하는 컴포넌트  

### [AKS Storage Class](./AKS-SC.md)  
Pod 에서 사용하는 스토리지  

### [AKS Monitoring](./AKS-Monitoring.md)  
- AKS agent 보기
- Cluster 보기

### [AKS(Azure Kubernetes Service) 컴퓨팅 비용 최적화](./AKS-CostOptimization.md)  
- 비용 최적화 방안 확인  
### [Pod 배포하기](./AKS-Pod.md) 
- container image build
- container registory 에 넣기
- pod 를 위한 manifest 작성
- kubectl 를 사용한 배포