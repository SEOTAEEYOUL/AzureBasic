# Azure Basic

> [Microsoft Azure 설명서](https://github.com/MicrosoftDocs/azure-docs.ko-kr)  
> [Azure architecture icons](https://docs.microsoft.com/en-gb/azure/architecture/icons/)  
> [Azure 계산기](https://azure.microsoft.com/ko-kr/pricing/calculator/)  

- 3-tier 기반의 Sample 을 Azure Cloud 에 구성하는 과정을 통해 익숙해지는 것을 목표로 함

## 3-tier 샘플
> [SpringBoot MariaDB Sample](https://github.com/SEOTAEEYOUL/SpringBootMariaDB)  
> [SpringBoot MySQL Sample](https://github.com/SEOTAEEYOUL/SpringBootMySQL)  

## AS-IS
- [Apache](./1.IaaS/Apache.md), [Tomcat](./1.IaaS/Tomcat.md), [MySQL](./1.IaaS/AzureMySQL.md)/[MariaDB](https://github.com/SEOTAEEYOUL/SpringBootMySQL/blob/main/MariaDB.md) 로 이루어진 서비스
- [Apache](./1.IaaS/Apache.md) : Static 문서 처리
- [Tomcat](./1.IaaS/Tomcat.md) : [SpringBoot](https://github.com/SEOTAEEYOUL/SpringBootMySQL/blob/main/Springboot.md) 기반 Biz 서비스 처리


| 구분 | 진입점/Ingress | Web | WAS | DB | 비고 |
|:---|:---|:---|:---|:---|:---|
| AS-IS | [L4](./1.IaaS/AzureLoadBalancer.md) | [Apache](./1.IaaS/Apache.md) | [Tomcat](./1.IaaS/Tomcat.md) | [MySQL](./1.IaaS/AzureMySQL.md)/[MariaDB](https://github.com/SEOTAEEYOUL/SpringBootMySQL/blob/main/MariaDB.md) | 3-tier 기반 서비스 |
| [Azure](./1.IaaS/README.md) | [Application GateWay](1.IaaS/AzureApplicationGateway.md) | [VM](./1.IaaS/AzureVirtualMachine.md)/[Apache](./1.IaaS/Apache.md) | [VM](./1.IaaS/AzureVirtualMachine.md)/[Tomcat](./1.IaaS/Tomcat.md) | [MySQL](./1.IaaS/AzureMySQL.md) | VM 과 Managed Service(AppG/W, DB) 사용 |  
| [Azure](./1.IaaS/README.md) | [Application GateWay](./1.IaaS/AzureApplicationGateway.md) | [Azure CDN](./1.IaaS/AzureCDN.md) | [VM](./1.IaaS/AzureVirtualMachine.md)/[Tomcat](./1.IaaS/Tomcat.md) | [MySQL](./1.IaaS/AzureMySQL.md) | CDN 를 통한 고도화 |  
| [AKS](./2.AKS/AKS.md) | [Application GateWay](1.IaaS/AzureApplicationGateway.md) | [Azure CDN](./1.IaaS/AzureCDN.md) | container/[SpringBoot](https://github.com/SEOTAEEYOUL/SpringBootMySQL/blob/main/Springboot.md) | [MySQL](./1.IaaS/AzureMySQL.md) | AKS(Kubernetes Service), CICD(빌드배포, OSS 사용), Container 빌드 포함 | 

## 과정 내용
### 공통
|| 항목 | 날짜 | 내용 | 
|:---|:---|:---|:---|  
| [Azure1](./0.ENV/Azure1.md)| 아키텍처 구성을 위한 기본 | 2022.01.25 | 3-tier 구성의 웹 전환을 대상으로 할 때 Azure 구독 획득 후 해야 할 일에 대한 설명 </br> 구독, RBAC, 자원그룹, VNet, subnet, VM, disk, Storage Account, PaaS, SaaS 구성 및 배포 방법 </br>  - Naming Rule 및 필수 Label 포함 </br> 아키텍처 작성, Azure 계산기 를 사용하여 비용 산출하기 </br> - Network 설계서 및 Infra Hybrid Cloud 자료 참조 |  
| [Azure2](./0.ENV/Azure2.md) | 배포 실습을 위한 공통 환경/도구 구성 | 2022.01.27 | azure portal, azure cli, visual studio code, powershell, git cli, github, md, devops 환경 구성 </br>
- 간단한 md/git 사용법 </br>
- PowerShell 에서 배포 및 삭제 |  

### IaaS
|| 항목 | 날짜 | 내용 | 
|:---|:---|:---|:---|  
| [Azure3](./1.IaaS/Azure3.md) | 3-tier 기본 환경 구성 | 2022.02.10 | VNet, subnet, NSG, Apache, Tomcat, MySql 구성 </br> - VM, disk, Storage Account, Application Gateway 구성 |
| [Azure4](./1.IaaS/Azure4.md) | 3-tier 기본 환경 외부 접근 구성 | 2022.02.10 | 3-tier 기본 환경에 CDN 적용, Azure DNS 설정, AppGateway 구성 변경 </br> - Application Gateway 구성 </br> - Azure DNS 구성 </br> |
| [Azure5](./1.IaaS/Azure5.md) | CDN 적용을 통한 고도화 | 2022.02.17 | 3-tier 기본 환경에 CDN 적용, Azure DNS 설정, AppGateway 구성 변경 </br> - Azure CDN 배포 및 구성 </br> - 정상 동작 테스트 </br> - apache 서버 삭제  | 
| [Azure6](./1.IaaS/Azure6.md) | Azure Cli 를 통한 자원 배포(IaC - 1) | 2022.02.18 | azure cli, powershell, ARMTemplate 사용한 배포 테스트 |    
| [Azure7](./1.IaaS/Azure7.md) | Azure DevOps 를 통한 자원 배포(IaC - 2) | 2022.02.18 | azure devops 에 저장소 설정 및 Pipeline 을 만들어 배포 하기 |  

### AKS
|| 항목 | 날짜 | 내용 | 
|:---|:---|:---|:---|  
| [Azure8](./2.AKS/Azure8.md) | Docker/Kubernetes | 2022.02.24 | Container 란 ? </br> - 설치 및 간단한 Docker Image 만들기 </br> Kubernetes 란 ?  |
| [Azure9](./2.AKS/Azure9.md) | Azure Kubernetes Service 구성 | 2022.02.24 | AKS Cluster 설계 및 생성, 로깅, 모니터링 하기 </br> - 3 tier 를 Pod 롤 배포하기 </br> - CDN, mysql(Managed, DaemonSet) 구성 </br> - Ingress Controller 구성 </br>- DNS 에 등록 외부에서 접근하기 |
| [Azure10](./2.AKS/Azure10.md) | AutoScaler 구성 | 2022.02.25 | Pod, Node AutoScaler 구성 및 모니터링 하기 </br> - deployment </br> - Storage Class </br> - Prometheus/AlertManager, Grafana |
| [Azure11](./2.AKS/Azure11.md) | Azure DevOps 를 통한 Pod 배포 | 2022.03.03 | Repos 구성, Pipeline 구성, Pod 배포 </br> - blue/green 배포 |  
| [Azure12](./2.AKS/Azure12.md) | OSS 를 통한 Pod 배포 | 2022.03.03 | Gitea, Jenkins, Harbor, ArgoCD 를 통한 GitOps 구성 </br> - webhook, Jenkinsflies 구성/작성 </br> - blue/green 배포 |

### Service 환경 고려 사항
|| 항목 | 날짜 | 내용 | 
|:---|:---|:---|:---|  
| [Azure13](./3.LandingZone/README.md) | Azure Landing Zone 요소 설명 | 2022.03.04 | Service 구축 시 랜딩존 환경 고려사항 |

## 공통 환경  
| 항목 | 내용 | 
|:---|:---|  
| [choco](./0.ENV/choco.md) | 윈도우 패키지 관리자 |  
| [git](./0.ENV/git.md) |  형상관리, 사용법 |  
| [MarkDown](./0.ENV/markdown.md) | Markdown Language, Github 사용(README.md), 표준 문서 포맷, 사용법 |  
| [YAML](./0.ENV/yaml.md) | Yet Another Markup Language,  |  
| [Visual Studio Code](./0.ENV/vscode.md) | 편집기 |  
| [az cli](./0.ENV/CLI.md) | azure client |  
| [PowerShell](./0.ENV/PowerShell.md) | 배포 삭제 |  
| java | https://jdk.java.net/17/ |

---

## Azure IaaS + PaaS(MySQL)  
| 항목 | 날짜 | 내용 |  
|:---|:---|:---|  
| [Apache](./1.IaaS/Apache.md) | 2022.02.08 | 웹서버 구성 확인 |
| [Tomcat](./1.IaaS/Tomcat.md) | 2022.02.08 | WAS 서버 구성 확인 | 
| [MySQL](./1.IaaS/AzureMySQL.md) | 2022.02.08 | DB 구성 확인 | 

| 항목 | 날짜 | 내용 |
|:---|:---|:---| 
| [resource group](./1.IaaS/AzureResourceGroup.md) | 2022.02.08 | 자원 그룹 | 
| [VNet](./1.IaaS/AzureVirtualNetwork.md) | 2022.02.08 | 구독당 하나의 VNet 구성 | 
| subnet | 2022.02.08 | DMZ, frontend, backend 로 구분 생성 | 
| [VM](./1.IaaS/AzureVirtualMachine.md) | 2022.02.08 | WEB, WAS VM 으로 생성 | 
| MariaDB/MySQL | 2022.02.08 | PaaS(Managed DB) 형태로 생성 |  
| [Azure App Service 도메인](./1.IaaS/AzureAppServiceDomain.md) | 2022.02.10 | Domain 생성/관리 |   
| [Azure DNS](./1.IaaS/AzureDNS.md) | 2022.02.10 | Azure 인프라를 사용하여 이름 확인을 제공하는 DNS 도메인에 대한 호스팅 서비스 |  
| [Application Gateway](./1.IaaS/AzureApplicationGateway.md) | 2022.02.10 | 웹 애플리케이션에 대한 트래픽을 관리할 수 있도록 하는 웹 트래픽 부하 분산 장치 | 
| [CDN](./1.IaaS/AzureCDN.md) | 2022.02.10 | CDN(콘텐츠 배달 네트워크)은 사용자에게 웹 콘텐츠를 효율적으로 제공할 수 있는 서버의 분산 네트워크 |  

---

## Azure CaaS(AKS) + PaaS(MySQL)  
| 과정 | 날짜 | 내용 |
|:---|:---|:---|  
| [Docker](./2.AKS/Docker.md) | 2022.02.21 | Container |
| [Kubernetes](./2.AKS/Kubernetes.md) | 2022.02.21 | Container as a Service, 아키텍처 | 
| [AKS](./2.AKS/AKS.md) | 2022.02.22 ~ 23 | Azure Kubernetes Service | 
| [DevOps](./2.AKS/GitOps/README.md) | 2022.03.03 | [OSS 기반](./2.AKS/GitOps/README.md), [Azure DevOps](./2.AKS/AzureDevOps.md) 기반 |  
| [Landing Zone](./3.LandingZone/README.md) | 2022.03.04 | Azure Landing Zone 요소 설명 | 

---
