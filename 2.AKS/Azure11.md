# [Azure DevOps](https://azure.microsoft.com/ko-kr/services/devops/#overview) 를 통한 Pod 배포
Repos 구성, Pipeline 구성, Pod 배포

[Azure DevOps 가격](https://azure.microsoft.com/ko-kr/pricing/details/devops/azure-devops-services/)  

## [DevOps](../0.ENV/DevOps.md)
코드 구축을 위한 통합 솔루션  
DevOps = 소프트웨어 개발 사이클 속도를 높이는 것  
DevOps는 개발 팀과 운영 팀 사이의 협업을 촉진하여 더욱 빠르고 안정적인 소프트웨어 제공을 지원하는 소프트웨어 개발 방식  

## [GitOps](./GitOps/README.md)  
- GitOps = 지속적 전달 + 지속적인 작업  
- Git을 거의 모든 것을 작동하는 소스 로 사용 하는 것  
- Git 도구에 연결된 특정 시스템 작업 프로세스  
- CI/CD 및 DevOps에서 개념을 차용하면서 클러스터 또는 클라우드 네이티브 애플리케이션을 관리하는 데 도움이 되는 지속적인 배포 접근 방식을 만드는 것  

## GitOps vs DevOps
| 항목 | GitOps | DevOps |  
|:---|:---|:---|  
| 접근 | Git 도구사용 | CI/CD 에 중점을 둔 문화(특정 도구에 얽매이지 않음)  |  
| 주요도구 | Git | CI/CD 파이프라인 |
| 기타도구 | Kuernetes, 별도의 CI/CD 파이프라인, 코드형 인프라 | Supply chain management, Cloud Configuration as Code |
| 초점 | 정확성, DevOps 를 올바르게 수행 | 자동화 및 빈번한 배포 |  
| 정확함 | 정확서에 염두를 두고 설계 | 정확성에 덜 집중 |
| 유연성 | 더 엄격하고 덜 개방적 | 덜 엄격하고 더 개방적 | 

[Azure DevOps Status](https://status.dev.azure.com/)


## [Azure DevOps](https://azure.microsoft.com/ko-kr/overview/devops-tutorial/#understanding)  
- 애자일 계획 및 lean Project 관리 (Azure Boards)
- 버전 제어(Azure Repos)  
- 연속통합(Azure Pipelines - Pipelines)
- 연속배달(Azure Pipelines - Releases)  


### Overview
Project 의 설명등 표현

### [Boards](https://docs.microsoft.com/ko-kr/azure/devops/boards/get-started/what-is-azure-boards?view=azure-devops) 
팀원들과 작업을 계획하고 추적하고 논의  
사용자 지정 가능한 스크럼, Kanban, Agile 도구를 사용하여 문제, 버그, 사용자 스토리, 기타 작업을 정의하고 업데이트할 수 있음

### [Repos](https://docs.microsoft.com/ko-kr/azure/devops/repos/get-started/what-is-repos?view=azure-devops) ([Git](../0.ENV/git.md) 저장소)
코드를 관리하는 데 사용할 수 있는 버전 제어 도구 세트  
- CI (지속적인 통합) 및 CD (지속적인 업데이트)를 결합 하 여 코드를 테스트 하 고 빌드하고 모든 대상에 제공 
- Public 무료
- Private 월 1800 분 (30 시간)의 파이프라인 작업 무료

### [Pipelines](https://docs.microsoft.com/ko-kr/azure/devops/pipelines/get-started/what-is-azure-pipelines?view=azure-devops) (빌드/배포)
선택한 앱과 플랫폼에 대한 CI/CD(연속 통합 및 지속적인 업데이트)를 구현  
- Azure 배포와 통합  
- GitHub 와 통합   
- 오픈 소스 프로젝트에서 작동  



### [Test Plans](https://docs.microsoft.com/ko-kr/azure/devops/test/overview?view=azure-devops)  
팀의 모든 사람이 개발 프로세스 전반에 걸쳐 품질과 협업을 촉진하는 데 사용할 수 있는 풍부하고 강력한 도구를 제공  

### Artifacts
다양한 피드 및 공용 레지스트리의 패키지를 공유하고 사용  
퍼블릭 및 프라이빗 소스에서 Maven, npm, NuGet 및 Python 패키지 피드를 만들고 공유  

### [Azure DevOps Pipeline 적용](./AzureDevOps.md)  
SpringBootMySql 예제 적용 
#### 테스트에 사용한 정보
| 구분 | 내용 | 
|:---|:---| 
| Cluster | aks-cluster-Homeeee |  
| ACR | acrhomeeee.azurecr.io |  
| Registry | acrHomeeee |  
| Repogitory | springmysql |  

## blue/green 배포 전략
- 격리된 Blue 와 Green 2개의 환경에 애플리케이션을 배포해서, Blue 와 Green 리소스 간에 서로 영향을 주지 않도록 하여  배포 위험을 줄이고 가용성을 높일 수 있음  
- Cluster 설계시 Worker Node 를 추가 구성하여함
- 동시 배포셋(통상 frontend 1 Set, Backend Service 1 Set)에 따라 추가 자원 확보하여 운영  
  - Blue Pod : 이전 버전의 컨테이너
  - Green Pod : 최신 버전의 컨테이너 
  - Deployment 의 명자체(Version 표기)하여 배포 후 정상 동작하면 Service 에서 Pod 명을 바꿔주는 형태로 사용하기도 함

