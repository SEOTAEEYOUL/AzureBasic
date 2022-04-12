# IaC(Infrastructure as Code, 코드형 인프라)
IaC(코드 제공 인프라)는 인프라 프로비전을 자동화하는 프로세스


## IaC(Infrastructure as Code, 코드형 인프라)
- 수동 프로세스가 아닌 코드를 이용하여 인프라를 관리하고 프로비저닝하는 것 
- “프로그래밍 가능 인프라”  
- 반복작업을 자동화하여 작업 시간을 단축할 수 있고 휴먼에러 감소 및 빠른 복원이 장점  
- 인프라를 코드 형태로 작성, 정의, 배포하는 것을 의미하며 서버, 데이터베이스, 네트워크, 로그, 애플리케이션 설정, 배포 자동화까지 모든 것을 코드 형태로 관리하는 데 목적이 있음  
- ARM(Azure Resource Manager), Terraform 및 Azure CLI(명령줄 인터페이스)와 같은 도구를 사용하면 필요한 클라우드 인프라를 선언적으로 스크립팅할 수 있음  

- IaC 모델은 적용될 때마다 동일한 환경을 생성
- 환경 드리프트 문제가 해결
- 팀이 프로덕션 환경과 비슷한 환경에서 애플리케이션을 조기에 테스트 할 수 있음
- 가능하면 선언적 정의 파일을 사용
- Git 를 사용 CMDB 를 별도구성하지 않고 이슈 추적 가능

*<u>프로비저닝(Provisioning)</u>*  
*사용자의 요구에 맞게 시스템 자원을 할당, 배치, 배포해 두었다가 필요 시 시스템을 즉시 사용할 수 있는 상태로 미리 준비해 두는 것*



> [코드형 인프라(IaC)란?](https://www.redhat.com/ko/topics/automation/what-is-infrastructure-as-code-iac)  
> [IaC(Infrastructure as Code) with Terraform](https://medium.com/humanscape-tech/iac-infrastructure-as-code-with-terraform-1fb0c6486fbc)  
> [코드 제공 인프라(Infrastructure as code)](https://docs.microsoft.com/ko-kr/dotnet/architecture/cloud-native/infrastructure-as-code)  

### IaC의 이점
IaC는 자동화된 프로세스를 통해 기업이 다양한 방법으로 IT 인프라의 요구를 관리할 수 있도록 지원  
#### 일관성
- 일관성을 개선하고 수동 구성 중에 자주 발생하는 오류를 줄임
- 수동 프로세스 중에 발생할 수 있는 구성 드리프트를 제거
- 구성 사양을 코딩하고 문서화하여 문서화되지 않은 임시 구성 변경을 방지하는 데 도움을 줌

#### 비용 절감
- 가상 시스템을 프로그래밍 방식으로 관리할 수 있어 수동 하드웨어 구성 및 업데이트가 필요하지 않음
- 운영자 한 명이 동일한 코드를 사용하여 1대 또는 1,000대의 시스템을 구축하고 관리할 수 있음  
  예) 배포 후 전체 자원에 대해 Tag 를 붙일 경우, 서버를 동시에         
- 필요한 인력이 줄어들고 새 하드웨어를 구입할 필요가 없어 비용이 크게 절감

#### 효율성
- 인프라를 코딩하면 프로비저닝용 템플릿이 제공되어 시스템 구성, 유지 보수 및 관리가 간소화 됨
- 이를 통해 반복 가능하고 확장 가능한 탄력적인 인프라를 구축할 수 있음
- DevOps를 통해 소프트웨어 개발 시 모든 단계의 속도를 높여 매일 더 많은 애플리케이션을 출시할 수 있음

#### 속도  
- 프로비저닝 작업을 스크립트를 실행하면 되는 간단한 작업으로 전환하여 인프라를 준비할 수 있음
- 인프라를 기다리지 않고 애플리케이션을 구축할 수 있으며 새로운 소프트웨어를 훨씬 더 신속하게 출시할 수 있음

#### 위험 감소
- 다른 소프트웨어 소스 코드 파일과 마찬가지로 구성 파일이 소스 통제를 받을 수 있도록 버전 제어를 지원함으로 위험이 감소

### IaC에 대한 선언적 접근 방식과 명령적 접근 방식
#### 선언적(Declarative) 접근 방식
- 기능적 접근 방식
- 최종 결과물이 어떻게 나올지 구상한 후 모듈 형식으로 작성
- 어떻게 달성할 것인지를 정의하지 않고 원하는 시스템 상태를 정의
- 필요한 속성을 포함하여 원하는 리소스를 정의
- 사람이 작업하지 않아도 동일한 결과로 여러 번 실행될 수 있음
#### 명령적(Imperative) 접근 방식
- 절차적 접근 방식
- 솔루션을 통해 인프라를 프로비저닝 하는데, 이때 하나씩 주어진 명령을 수행하며 인프라를 생성  
- 인프라를 구성하는 방법뿐만 아니라 이를 달성하는 방법을 정확하게 정의해야 함
- 특정 구성을 달성하는 데 필요한 명령을 정의
- 한 번에 한 단계씩 적절한 순서로 실행
- 업데이트를 허용하지 않고 명시적인 방향을 사용하는 불안정한 접근 방식
- 운영자가 변경 사항이 어떻게 적용되어야 하는지를 해독해야 함

### IaC가 사용되는 방식
- 새롭고 혁신적인 서비스와 리소스를 더 신속하게 배포할 수 있는 단일 제어 지점을 갖춘 시스템
- 일관된 프로비저닝과 오케스트레이션을 통해 애플리케이션 성능을 향상
- 소프트웨어 정의 아키텍처를 통해 코드형 인프라를 관리를 통해 사내 IT 팀에 대한 요구가 감소

### IaC 구현을 위한 주요 기술
HW Layer 위에 Orchestration 과 Configuration, Bootstrap 기능이 필요
1) ad hoc script: .sh 나 Dockerfile 과 같은 bash script
2) Orchestration(해당 인프라 계층을 추상화, Provisioning)  
   AWS CloudFormation  
   Azure Resource Manager  
   Google Cloud Deployment Manager  
   HashiCorp Terraform
3) Configuration
   이미 존재하는 인프라의 구성 관리에 중점  
   Ansible, Chef, Puppet, Saltstack
4) Bootstrap  
   Vagrant, Docker, Cloud CLI

### IaC 도구
- Chef, Puppet
- Terraform
- AWS CloudFormation
- ARM(Azure Resource Manager) Template - Bicep, JSON
- Azure Automation
- Azure DevOps 서비스
- GitHub  작업
