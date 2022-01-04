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
| 3-tier 기본 환경 구성 | 2022.02.08 | Vnet, subnet, NSG, apache, tomcat, mysql 구성 </br> - VM, disk, Storage Account, Internal L4, VMSS, AppGateway 구성 |
| 3-tier 기본 환경 외부 접근 구성 | 2022.02.10 | 3-tier 기본 환경에 CDN 적용, Azure DNS 설정, AppGateway 구성 변경 </br> - Application Gateway 구성 </br> - Azure DNS 구성 </br> |
| CDN 적용을 통한 고도화 | 2022.02.14 | 3-tier 기본 환경에 CDN 적용, Azure DNS 설정, AppGateway 구성 변경 </br> - Storage Account Blob 배포 및 Storage Exploror/SAS 를 이용한 Static 문서 Upload </br> - Azure CDN 배포 및 구성 </br> - 정상 동작 테스트 </br> - apache 서버 삭제  | 
| Azure Cli 를 통한 자원 배포(IaC - 1) | 2022.02.15 | azure cli, powershell, ARMTemplate 사용한 배포 테스트 |    
| Azure DevOps 를 통한 자원 배포(IaC - 2) | 2022.02.18 | azure devops 에 저장소 설정 및 Pipeline 을 만들어 배포 하기 |  

### AKS
| 항목 | 날짜 | 내용 | 
|:---|:---|:---|  
| Docker/Kubernetes | 2022.02.21 | Container 란 ? </br> - 설치 및 간단한 Docker Image 만들기 </br> Kubernetes 란 ? </br> - Minikube 설치 및 사용 |
| Azure Kubernetes Service 구성 | 2022.02.22 | AKS Cluster 설계 및 생성, 로깅, 모니터링 하기 </br> - 3 tier 를 Pod 롤 배포하기 </br> - CDN, mysql(Managed, DaemonSet) 구성 </br> - Ingress Controller 구성 </br>- DNS 에 등록 외부에서 접근하기 |
| AutoScaler 구성 | 2022.02.25 | |
| Azure DevOps 를 통한 Pod 배포 | 2022.03.03 | Pod, Node AutoScaler 구성 및 모니터링 하기 </br> - deployment </br> - Storage Class </br> - Prometheus/AlertManager, Grafana |  
| OSS 를 통한 Pod 배포 | 2022.03.03 | Repos 구성, Pipeline 구성, Pod 배포 </br> Gitea, Jenkins, Harbor, ArgoCD 를 통한 GitOps 구성 </br> - webhook, Jenkinsflies 구성/작성 </br> - blue/green 배포 |

### SKT 환경 고려 사항
| 항목 | 날짜 | 내용 | 
|:---|:---|:---|  
| SKT랜딩존 환경 고려사항 | 2022.03.04 | SKT랜딩존 환경 고려사항 |

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
