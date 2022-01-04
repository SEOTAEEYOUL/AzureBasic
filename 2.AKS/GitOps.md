# GitOps
> [Guide To GitOps](https://www.weave.works/technologies/gitops/)  



## GitOps = 지속적 전달 + 지속적인 작업.  
  - Git을 거의 모든 것을 작동하는 소스 로 사용 하는 것
  - 리소스를 수동으로(또는 스크립트나 파이프라인을 통해) 클러스터에 적용하는 대신 전용 에이전트가 변경 사항을 클러스터로 가져와 사용자를 대신하여 적용  
  - Git 저장소에 정의된 것이 무엇이든 Kubernetes 클러스터의 자동화된 에이전트를 사용하여 인프라 측에 반영되도록 지속적으로 발생 하는 조정 루프  

### Kelsey Hightower
GitOps is the best thing since configuration as code. Git changed how we collaborate, but declarative configuration is the key to dealing with infrastructure at scale, and sets the stage for the next generation of management tools. 

![GitOps-Timeline.png](./img/GitOps-Timeline.png)  

## GitOps 관련 도구  
### [ArgoCD](https://argoproj.github.io/argo-cd/)  
- Kubernetes용 선언적 GitOps 지속적 전달 도구
- 애플리케이션 정의, 구성 및 환경이 선언적이고 버전이 제어됨
- 애플리케이션 배포 및 수명 주기 관리는 자동화되고 감사 가능하며 이해하기 쉬움  
- 선언적이란 구성이 일련의 지침 대신 사실 집합에 의해 보장됨을 의미함  

> [ArgoCD Best Practices](https://argoproj.github.io/argo-cd/user-guide/best_practices/)  
  - [[DevOps] ArgoCD Best Practice](https://wookiist.dev/m/138)  
  - 매니페스트 파일만 수정했을 뿐인데도 CI가 자동으로 발생하는 상황을 막기 위해 ArgoCD 공식 문서에서도 매니페스트 파일과 소스 코드 레포지토리를 분리할 것을 권고
