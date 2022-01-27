# Azure01 아키텍처 구성을 위한 기본

3-tier 구성의 웹 전환을 대상으로 할 때 Azure 구독 획득 후 해야 할 일에 대한 설명
구독, RBAC, 자원그룹, Vnet, subnet, VM, disk, Storage Account, PaaS, SaaS 구성 및 배포 방법

- Naming Rule 및 필수 Label 포함
아키텍처 작성, Azure 계산기 를 사용하여 비용 산출하기
- Network 설계서 및 Infra Hybrid Cloud 자료 참조


## 용어와 개념
### 지리(Geography)
- 2개 이상의 지역을 포함
- 데이터와 애플리케이션을 동일한 지리적 위치에 유지해야 하는 데이터 유지 및 규정 준수의 경계

### 지역(Region)
- 최상의 성능과 보안을 제공하기 위해 고속 네트워크로 연결된 데이터센터의 집합을 뜻함
- 일정한 대기시간(< 2ms) 을 정의한 경계 
- 중부, 남부

### 지역 쌍(Region Pair)
- 일반적으로 동일한 지리적 위치 내에 있는 2개의 지역
- 비즈니스의 연속성 데이터의 손실 방지를 통한 서비스 중단 가능성 최소화


### 영역(Zone)
- 하나 이상의 데이터센터를 가진 지역 내의 물리적인 별도 위치를 말함
- 데이터센터의 오류나 손상을 대비해 서비스의 논리적 결리와 중복성, 내결함성을 보장
- 각 영역의 대기시간은 2ms 이하를 보장

### 데이터센터
- 독립적인 전원 및 냉각 장치, 네트워크를 갖춘 별도의 시설을 말함
- 한국 남부와 중부의 LG U+와 KT 의 데이터센터를 임차해 사용 중

---
### 구독(Subscription)  
- Azure Resource 의 논리적인 서비스 단위
- 리소스 사용에 대한 리포트, 과금, 청구에 대한 제어

### Account
- Subscription 을 관리하고 사용하는 단위
- Tenant, Directory 라고도 함


### 리소스(Resource)
- 가상 머신, 데이터베이스, 가상 네트워크, 스토리지 계정 등의 구성요소를 리소스라고 함

### 리소스 그룹
- 동일한 수명, 동일한 프로젝트에 속하는 리소를 함께 그룹으로 묶은 논리적인 그룹
- 리소스는 하나의 리소스 그룹에 속해야 하면 이동할 수 있음
- 역할 기반 액세스 제어(RBAC) 로 라이프사이클 관리 지원

### 리소스 공급자(Resoruce Provider)
- 리소스를 제공하는 서비스
- MicroSoft.Compute, Microsoft.Network, Microsoft.Storage ...

---
## [가상 네트워크(Virtual Network, VNet)](./VirtualNetwork.md)  
### 구현 목적
- 리소스간 안전한 통신
- 온프레미스 인프라 리소스와의 안전한 통신
- 인터넷 아웃바운드 통신


## [VM(가상머신) 과 Disk](./VirtaulMachine.md)


## Azure Storage
### Storage Account
- Azure Storage 서비스를 관리
- 스토리지 서비스의 최상의 네임스페이스

### [Storage 탐색기](https://azure.microsoft.com/ko-kr/features/storage-explorer/#overview)  


### App Service
- 이미 배포되어 있는 서버들 중에서 어떤 OS 를 사용하여 어떤 언어로 배포할지 정하면 손쉽게 배포할 수 있음
- ASP.NET, ASP.NET Core, Java, Runy, Node.js, PHP, Python 등 다양한 언어를 사용
- 별도의 툴 없이 CI/CD 등 향상된 생산성을 제공
- 트랙픽에 따른 자동 확장도 가능
- Application Insights 와 연동하면 상세한 모니터링이 가능

### Azure Kubernetes Service(AKS)
- Master 서버 생성 없이 Node Pool 만 생성하여 사용
- 비용도 Node(VM) 수량만큼 지불하면 됨
- Azre DevOps 와 연동 CI/CD

### Azure Functions
- 부분함수 형태로 만들어 사용
- 서버리스 애플리케이션
- 사용량 단위 비용 지불

## [부하 분산](./loadbalancer.md)

| 항목 | 모든 프로토콜 지원 | 웹프로토콜 지원 </br> (인증서 연결 가능) |
|:---|:---|:---|
|지리적 분산 | Traffic Manager | Front Door |
| 지역 내 분산 | Load Balancer | Application Gateway |

### Traffic Manager

### Application Manager
- 경로 기반 웹서비스 분산을 위해 사용

## SaaS vs PaaS vs IaaS
![what-is-paas.png](./img/what-is-paas.png)
![Cloud-Service-Model.jpg](./img/Cloud-Service-Model.jpg)

## [Naming Rule](./NamingRule.md)  
- [명명 규칙 정의](https://docs.microsoft.com/ko-kr/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)

## [Tag](./tag.md) 
키/값 문자열 쌍이며, 범위는 Azure 구독임
- 작성자 : 리소스 작성자에 따라
- 부서/서비스 : 부서별 청구
- 환경 : 개발/운영

## [가격 계산기](https://azure.microsoft.com/ko-kr/pricing/calculator/)  

## [TCO(총 소유 비용) 계산기](https://azure.microsoft.com/ko-kr/pricing/tco/calculator/)  


## Network 설계서 및 Infra Hybrid Cloud 자료 참조