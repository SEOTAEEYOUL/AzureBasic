# Azure Basic

- 3-tier 기반의 Sample 을 Azure Cloud 에 구성하는 과정을 통해 익숙해지는 것을 목표로 함

## AS-IS
- Apache, Tomcat, MySQL/MariaDB 로 이루어진 서비스
- Apache : Static 문서 처리
- Tomcat : SpringFramework 기반 Biz 서비스 처리

## 일정
| 월 | 화 | 수 | 목 | 금 |
|:---:|:---:|:---:|:---:|:---:|
| | [2022.01.25](./meetings/2022-04-02.md) | | [2022.01.27](./meetings/2022-01-27.md) | |
| | [2022.02.04](./meetings/2022-02-04.md) | | [2022.02.10](./meetings/2022-02-10.md) | |
| [2022-02-14](./meetings/2022-02-14.md) | [2022-02-15](./meetings/2022-02-15.md) | | | [2022-02-18](./meetings/2022-02-18.md) |  
| [2022-02-21](./meetings/2022-02-21.md) | [2022-02-22](./meetings/2022-02-22.md) | | | [2022-02-25](./meetings/2022-02-25.md) | 
| | | [2022-03-03](./meetings/2022-03-03.md) | [2022-03-04](./meetings/2022-02-04.md) |

## 과정 내용
### 공통
| 항목 | 날짜 | 내용 | 
|:---|:---|:---|  
| 아키텍처 구성을 위한 기본 | 2022.01.25 | 3-tier 구성의 웹 전환을 대상으로 할 때 Azure 구독 획득 후 해야 할 일에 대한 설명 </br> 구독, RBAC, 자원그룹, Vnet, subnet, VM, disk, Storage Account, PaaS, SaaS 구성 및 배포 방법 </br>  - Naming Rule 및 필수 Label 포함 </br> 아키텍처 작성, Azure 계산기 를 사용하여 비용 산출하기 </br> - Network 설계서 및 Infra Hybrid Cloud 자료 참조 |  
| 배포 실습을 위한 공통 환경/도구 구성 | 2022.01.27 | azure portal, azure cli, visual studio code, powershell, git cli, github, md, devops 환경 구성 </br>
- 간단한 md/git 사용법 </br>
- PowerShell 에서 배포 및 삭제 |  

### IaaS
| 항목 | 날짜 | 내용 | 
|:---|:---|:---|  
| 3-tier 기본 환경 구성 | | |
| 3-tier 기본 환경 외부 접근 구성 | | |
| CDN 적용을 통한 고도화 | | | 
| Azure Cli 를 통한 자원 배포(IaC - 1) | | |    
| Azure DevOps 를 통한 자원 배포(IaC - 2) | | |  

### AKS

### AKS
| 항목 | 날짜 | 내용 | 
|:---|:---|:---|  
| 항목 | 날짜 | 내용 | 
|:---|:---|:---|  
| 3-tier 기본 환경 구성 | | |

## 공통 환경  
| 항목 | 날짜 | 내용 | 
|:---|:---|:---|  
| git | 2022.01.27 | 형상관리, 사용법 |  
| md | 2022.01.27 | Markdown Language, 표준 문서 포맷, 사용법 |  
| Visual Studio Code | 2022.01.27 | 편집기 |  
| az | 2022.01.27 | azure client |  
| PowerShell | 2022.01.27 | 배포 삭제 |  
| java | 2022.01.27 |  https://jdk.java.net/17/ |


---

## Azure IaaS + PaaS(MySQL)  
| 항목 | 날짜 | 내용 |  
|:---|:---|:---|  
| Apache | 2022.02.08 | 웹서버 구성 확인 |
| Tomcat | 2022.02.08 | WAS 서버 구성 확인 | 
| MariaDB | 2022.02.08 | DB 구성 확인 | 

| 항목 | 날짜 | 내용 |
|:---|:---|:---| 
| tenent | | | 
| management group | | | 
| subscription | | | 
| resource group | | | 
| vnet | | | 
| subnet | | | 
| Azure DNS | | |  
| Application Gateway | | | 
| vm | | | 
| MariaDB/MySQL | | |  

---

## Azure CaaS(AKS) + PaaS(MySQL)  
| 과정 | 날짜 | 내용 |
|:---|:---|:---|  
| Docker | | Container |
| Kubernetes | | Container as a Service, 아키텍처 | 
| AKS | | Azure Kubernetes Service | 
| DevOps | | OSS 기반, Azure DevOps 기반 |  
| Landing Zone | | Azure Landing Zone 요소 설명 | 

---
