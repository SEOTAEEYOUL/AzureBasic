# Landing Zone(착륙 지점)  
Landing Zone은 클라우드 환경을 부트스트랩하는 데 사용되는 미리 정의된 규칙, 구성 및 방법 집합  
대상은 클라우드 구독 또는 계정  
일반적으로 기업 측 또는 IT Ops 부서의 모든 요구 사항을 충족하는 규제 플랫폼을 설정하기 위한 구성 관리 역할을 함


**부트스트랩(Bootstrap)** : 한번 시작되면 알아서 진행되는 일련의 과정(Wiki)  

> [Azure에 대한 Microsoft 클라우드 채택 프레임워크](https://docs.microsoft.com/ko-kr/azure/cloud-adoption-framework/)  
> [허브 및 스포크 네트워크 토폴로지](https://docs.microsoft.com/ko-kr/azure/cloud-adoption-framework/ready/azure-best-practices/hub-spoke-network-topology)  

- 랜딩 존을 배포하면 실제로 무엇을 얻을 수 있는지 ?  
  - Azure 클라우드 마이그레이션을 간소화할 수 있음
- 어떻게 생겼는가 ?  
  ![LandingZone.png](./img/LandingZone.jfif)   
- Azure 구독 및 리소스에 어떤 영향을 주는지 ?  


## Landing Zone 이란 ?
- 클라우드 마이그레이션을 효율적으로 수행하고 관리할 수 있는 조직의 프레임워크를 구축
- 랜딩 존 내에서 클라우드에서 데이터와 애플리케이션을 사용하는 방법을 결정하는 데 사용할 매개 변수 또는 가드 레일을 선택할 수 있음
- 랜딩 존(Landing Zone)은 성공적인 cloud adoption strategy 에 필요한 구성 요소
- 새 집을 짓는 것과 비교할 때, 실제 건설 전에 자원을 확보하는 것

### 요소
- ID 및 액세스 관리
- 감사 및 로깅
- 규정 준수, 규정 및 정책
- 보안 및 모니터링
- 네트워킹
- 기본 인프라

## 방향성(고려사항)
### Overall
- Landing Zone 이 없어 CSP 선호도가 떨어짐(구축이 힘듬)
  - 서비스별 개별 구성이 아니나 공통의 서비스/거버넌스 구성
    - **Enterprise-Scale LZ 을 수용하는 아키텍처 수립, Management Group 적용**(★)

### 계정관리
- AD 계정 메뉴얼 이원화 (On prem & 클라우드 ) 관리
  - On-Premise AD 와 연동
  - **Azure AD Connect로 계정/패스워드 동기화**

### 거버넌스
- 사업부별 별도 리소스 생성으로 관리 불가
  - 확장되는 환경에서도 통합관리 제공
    - **Subscription 구조, Naming Convention, Tagging, Policy, RBAC 적용**(★)

### 네트워크
- On-Premise 와 미연동 및 확장성 제약
  - 여러 사업부의 서비스 수용으로 확장성 필요
    - **ER연동, Hub & Spoke NW 토폴로지 적용**

### 운영성
- Azure 포털을 통한 개별메뉴얼 구성으로 일관성 떨어짐
  - 구독별 기본사항 일괄구성, 유사환경 반복구성
    - **IaC활용, ARM Template, (Blueprint, Terraform) 적용**(★)

### 보안
- 별도의 보안체계/가이드 없어 사용자 혼란
  - On-Premise 와 동일한 수준의 보안보장
    - **Shared Service 영역 IaaS 기반 보안솔루션 구축, Security Center(무료)**

### 모니터링
- 별도의 모니터링 체계가 없음, On-Promise 와 연동 필요
  - 중앙집중식 모니터링과 On-Premise 의 Splunk 연동 필요
    - **Azure Monitor, Diagnostics Log, Event Hub 적용, Splunk 연동**

### 비용
- 네트워크 트래픽 비용 및 보안 솔루션 비용 과다
  - On-Premise 서비스 대체가능한 Azure 서비스 사용
    - **Tagging사용, (Third-party 솔루션 지양) Azure Backup, NSG, WAF**


## 테넌트, 관리그룹, 구독
#### **테넌트(Tenant)**  
- 테넌트는 Active Directory 에서 조직을 표현  
- 회사, 학교, 고객ID 의 고유한 값을 가지며 앱 등록의 고유한 표현식이 있음


#### **관리그룹(Management Group)**
- 조직에서 다수의 구독을 보유하고 있을 때 구독의 상위 수준으로 관리 그룹을 정의하여 관리의 편의성 제공

#### **구독(Subscription)**
- 비용을 계산하고 리소스를 할당하는 기본 단위이며 비용 지불을 위한 계약의 종류에 따라 평가판, 종량제, 기업 등이 있음

- 개별 서비스(New Service)는 다음과 같이 구성
- 경우에 따라서 Prd, Stg 구독은 통합하여 구성하기도 함  
![LZ-ManagementGroup.png](./img/LZ-ManagementGroup.png)  

## 역활과 권한
기본 역활을 기준으로 **사전에 정의된 역활(built-in)** 과 **사용자 정의 역활** 을 부여할 수 있음
- 보안과 관리성을 위해 일부 Built-in Role 할당을 제한하고, Custom Role 을 사용자에게 할당함


- 역활과 권할 할당의 흐름은 다음과 같음
![LZ-Roles-Assign-Flow.png](./img/LZ-Roles-Assign-Flow.png)  

## Shared Service 영역
- ER : Vnet 간의 연결은 peering 이 아닌 ER Connect 로 VPN 으로 연결
- UDR(User Defined Router) - 사용자 정의로 시스템 경로 외에 추가적으로 설정할 때 사용    
- NSG (Network Security Group, 2000 한계)
  - 각 서비스 별로 개별적으로 설정함
  - NSG Rule - IT 보안팀에서 정의
  - NSG Flow Log 는 v1, v2 가 있으며 v2(전체 로그) 로 설정하여 사용함
  - NSG Flow Log 는 전체 Deny 후 필요한 것만 허용하는 정책 사용
- 진단 저장소 설정
- Azure Storage Acount
- Azure Event Hub
- Scecurity Center(Basic, 모든상황, 모든로그) : Network, VM 총괄하여 보기 위한 것  
  - Data Dog - node
    - 활동로그 -> Landing Zone Storage Account(Bloc) -> Function App -> DATADOG(datadoghq.com)  
       [참조 : Splunk Collector 용도](https://docs.datadoghq.com/integrations/azure/?tab=blobstorage#log-collection)  
    WAF - 수동으로 구성하여 History 용으로 쌓음(자동화 대상이 아님)
  - Splunk - .NET

## LZ 에서 신규 서비스 생성 절차
| Seq.No| 배포단계| 설명 |
|:---|:---|:---|
| 1 | 구독 생성 | Azzure Portal 에서 새로운 구독 생성 |  
| 2 | 관리 그룹 생성 | Azure Portal 에서 신규 서비스의 관리 그룹 생성 |  
| 3 | 관리 그룹에 구독 추가 | Azure Portal 에서 생성된 관리그룹에 서비스 구독을 추가 |  
| 4 | 관리그룹을 Divisions 에 추가 | Azure Portal 에서 생성된 관리 그룹을 Divisions 관리 그룹에 추가 |  
| 5 | RBAC 생성 | 신규 구독을 대상으로 RBAC 생성 스크립트 실행 |  
| 6 | 구독에 Role 을 Assign | Azure Portal 에서 신규 구독에 Role 을 Assign |
| 7 | Activity Log 설정 | 신규구독을 대상으로 Activity Log 설정 스크립트를 실행 |
| 8 | 네트워크 생성 | 신규 구독을 대상으로 Virtual Network(VNet) / Subnet 생성 스크립트 실행 |  
| 9 | 초기 서비스 생성 완료 | |  

![lz-new-service-0.png](./img/lz-new-service-0.png)


### 서비스(워크로드) 가 신규로 생성될 때 Azure 관리자가 해야 하는 것들

| 구분 | 내용 |
|:---|:---|
| Policy | Management Group 생성 (MG 하위레벨 자동상속) |  
| RBAC | Custom Role 구독레벨 적용 |  
| Role | Role에 사용자 추가 (Service Owner/Contributor/DBA) |
| Logging | Logging 적용 템플릿 구독레벨 적용 |  


## Project 때 반영하는 것
### Naming Convention
MS Naming Guide 및 Limitation 기본 반영, Prefix/Postfix 사용을 권고로 고객 환경에 맞게 테일러링하여 설계, 주요 리소스 협의 후 추가사항 반영  
#### [명명 규칙(Naming Rule) ](../0.ENV/NamingRule.md)

#### 예시
| Azure 서비스 혹은 개체 | 패턴 | 예시 |
|:---|:---|:---|
| Resource Group | rg-skcc-<서비스 구분>-<환경> | rg-skcc-lz-network-prd | 
| Virtual Machine	[리눅스/윈도우 공통] | SKCC-<업무명><환경><서버 용도><숫자> </br> 상세) 고객사명(SKCC)-업무명(ERP)개발(D)/운영(P)서버용도(DB)번호(#) | SKCC-WSUSPAP1 |
| Storage account name (general) | <skcc><환경><서비스 고유 명칭><숫자> | skccprddbafiles1 |
| Storage account name (diagnostics) |<skcc><환경>stdiag | skcclzprdstdiag |  
| Managed Disk name | <VM 명>-ssd<##> </br> <VM 명>-<디스크용도><##> | SKCC-WSUSPAP1-ssd01 </br> SKCC-ERPPDB1-log01 | 
| Virtual Network (VNet) | vnet-skcc-<환경> | vnet-skcc-lz-prd |
| Subnet | snet-skcc-<환경>-<Subnet 용도(대역정보)>-<추가 구분 정보> | snet-skcc-prd-10.234.0.32-63-lz-shared-svc |
| Network Security Group Rule | <"allow"/"deny">-<인바운드/아웃바운드>-<내부/외부>-<포트 또는 트래픽 타입> | allow-inbound-internal-http | 
| Azure Application Gateway | skcc-<환경>-agw | skcc-lz-prd-appgw | 
| Recovery Services | skcc-rsv-<서비스 또는 애플리케이션 명>backup-<환경> | skcc-rsv-VMbackup-dev | 



### [Tagging](../0.ENV/tag.md)  
Biz, Tech, Security 관점에서 필수 Tagging 요소만 최소 정의  

#### 필수 Tag
| 대상 | 태그 이름 | 태그 값 | 내용|
|:---|:---|:---|:---|
|Resource Group | servicetitle | 서비스 별 고유명사 | 서비스 명 |
|Resource Group | environment | 'prd', 'stg', 'dev', 'poc' | 운영 구분 |
|Resource Group | personalinformation | 'yes', 'no' | 개인정보 포함 여부 |

### [Policy](./Policy.md)
- 대상 : 자원(Resource)
1. Policy 전체 분석
2. 회사 추천, Best Practice 추천 검토
3. 고객사 담당자 검토
4. 최종 선정
5. 정책(Deny, Audit) 정의
6. 적용레벨/params 협의

**적용**
- Corp. 에 적용 후 상속 받음
- 지우고 새로 만듬(반복적 실행 가능)
- Policy Type
  | 항목 | 내용 |
  |:---|:---|
  | 감사 | 감사 로그를 남김 |  
  | 거부 | 조건이 안 맞으면 생성이 안됨 |  
  | 배포 | 조건에 해당하며 만들어(설정 해) 줌 |  

### [RBAC](./RBAC.md) 
- 대상 : 사용자/Group  
- 사용자나 그룹 차원에서 자원을 Controll 할 수 있는 권한
고객사가 요청한 권한이 Built-in Role 로 충족되면 설정, Management Group 레벨 적용  
Custom Role 이 필요하면 생성하여 사용, Subscription 레벨 적용  

### Logging
- Azure Monitor - Activity Log 기본 설정
- Subscription 레벨 적용  
- Custom Role
  | Role | Read | Write/Delete |
  |:---|:---|:---|
  | Service Owner | ○ | X | 
  | Service Contributor | ○ | X |
  | Service Admin | ○ | X |

#### Activity Log 기본 적용 범위
- Audit Log(Policy)
- NSG Flow Log, Activity Log, WAF Log
- Security Center(Basic), Blob, Event Hub(->Functions(C#)->Splunk VM) 

### 로그 수집
Azure 에서 발생하는 활동 로그와 Security Center, 애플리케이션 게이트웨이(WAF), 네트워크그룹(NSG)의 로그를 공통 리소스를 통해 수집 On-Premise  로 전송  
활동로그의 수집을 위한 설정은 가상 네트워크 생성시 자동으로 배포되고 네트워크 보안그룹(NSG)의 로그는 정책에 의해 자동으로 설정이 되지만 WAF 로그 수집과 Security Center 의 로그 설정은 서비스 관리자의 추가 설정이 필요함

Security Center, Application Gateway(L7) WAF enable, NSG Flow Log 를 배포/설정하여 Activity Log 는 blob 을 통해 Datadog로 쌓이며, NSG Flow Log 는 eventlog 를 통해 Splunk 에 쌓임  

**로그 수집 흐름**   
![LZ-Log-Collection-Flow.png](./img/LZ-Log-Collection-Flow.png)  

## 유지보수

1. Azure Landing Zone 이 잘 운영되는 것
2. 생성/수정/삭제
   - 생성 : 신규는 Audit 으로 하여 생성 후 협의가 끝나면 Deny 
3. 서비스 연동
   - divisions 밑에 구독(subscription) 연결 및 RBAC (service owener - Custom) 적용
   - 자원에 TAG 는 environment, serviceName, persionalInformation 추가
   - 그외 audit 에 대한 대응 필요