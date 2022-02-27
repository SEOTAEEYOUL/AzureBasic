# Jenkins Pipeline

> [[Jenkins] Pipeline Syntax (젠킨스 파이프라인 문법)](https://waspro.tistory.com/554)

> [Pipeline Plugin](https://plugins.jenkins.io/workflow-aggregator/)  
> [보다 상세한 Jenkins 관리](https://www.jenkins.io/doc/book/managing/plugins/)

## Jenkins Pipeline 정의
- Jenkins Webadmin : 일반적인 방식으로 Jenkins 파이프라인을 생성하여 Shell Script를 직접 생성하여 빌드하는 방식
- Git SCM : Git Repository에 JenkinsFile을 작성하여 빌드하는 방식
- Blue Ocean : 파이프라인을 시각화하여 손쉽게 구성하여 빌드하는 방식

## 문법
### Pipeline
- 파이프라인을 정의하기 위해서는 반드시 pipeline을 포함
- pipeline은 최상위 레벨이 되어야하며, { }으로 정의
- pipeline은 Section, Directives, Steps 또는 assignment 문으로만 구성

```
pipeline {
    /* insert Declarative Pipeline here */
}
```

### Section 
#### agent : agent를 추가할 경우 Jenkins는 해당 agent를 설정
- any, none, label, node, docker, dockerfile, kubernetes를 파라미터로 포함할 수 있음

#### post : 특정 stage나 pipeline이 시작되기 이전 또는 이후에 실행 될 confition block을 정의

#### stages : 하나 이상의 stage에 대한 모음을 정의

#### steps : stage 내부에서 실행되는 단계를 정의

### Directives
#### environment : key-value 형태로 파이프라인 내부에서 사용할 환경 변수로 선언

#### options : pipeline의 옵션을 선택적으로 포함 시킬 수 있음

#### parameters : 사용자가 제공해야할 변수에 대해 선언할 수 있음

#### triggers : 파이프라인을 다시 트리거해야 하는 자동화된 방법을 정의

#### tools : 설치 도구를 정의

#### input : input 지시문을 stage에 사용하면 input 단계를 사용하여 입력하라는 메시지를 표시할 수 있음

## Jenkins 파이프라인의 실행

## Jenkins Pipeline 예제
| 파일 | 구분 | 설명 |  
|:---|:---|:---|  
| pipeline.json | Pipeline | 기본 형태 |  
| pipeline-docker.json | agent | docker |  
| pipeline-dockerfile.json | agent | dockerfile |  
| pipeline-agent.json | agent | agent가 적용 된 JenkinsFile Sample |  
| pipeline-post.json | post | post가 적용 된 JenkinsFile Sample |  
| pipeline-stage-steps.json | stages, steps | tages와 steps가 적용 된 JenkinsFile Sample |  
| pipeline-environmnet.json | stages, steps | environment가 적용 된 JenkinsFile Sample |  
| pipeline-option.json | options | options가 적용 된 JenkinsFile Sample |  
| pipeline-parameter.json | parameter | parameters가 적용 된 JenkinsFile Sample | 
| pipeline-trigger.json |  tirgger | triggers가 적용 된 JenkinsFile Sample |  
| pipeline-tools.json | tools | tools가 적용 된 JenkinsFile Sample |  
| pipeline-input.json | input | input이 적용 된 JenkinsFile Sample |  
| pipeline-sequential.json |  파이프라인 | 순차적 실행 예제 |  
| pipeline-parallel.json |  파이프라인 | 평행 실행 예제 |  