# Azure DevOps
코드 구축을 위한 통합 솔루션
> DevOps is the union of people, process, and products to enable continuous delivery of value to your end users. - Donovan Brown
> 지속적으로 가치를 제공하는 것이 중요  
> 지속적인 제공(Continuos Delivery)  
> 지속적인 배포(Continuos Deployment)  
> DevOps = 소프트웨어 개발 사이클 속도를 높이는 것  
> 미래의 DevOps
  - ChatOps  
  - VoiceOps  
> [깃헙 액션으로 ChatOps 구현하기](https://blog.aliencube.org/ko/2020/03/05/implementing-chatops-on-github-actions/)  
> [데브옵스(DevOps)의 현재와 미래 - ChatOps & VoiceOps (윤석찬)](https://www.slideshare.net/awskorea/devops-on-aws-cloud-and-chatops-voice-ops)


![implementing-chatops-with-github-actions-01-ko.png](./img/implementing-chatops-with-github-actions-01-ko.png)
> 일반적으로 GitHub Action 은 지속적인 배포 프로세스를 따르고 있어서 중간에 승인 절차를 구현하혀면 별도의 방법론이 필요

## 서비스 지향 아키텍처(SOA)
### Primitives
- [Netflix Open Source Software Center](https://netflix.github.io/)  
- DevTeam 
  - "두 판의 라지 사이즈 피자" 로 먹일 수 있는 팀  
  - 민첩하고, 독립적인, 신뢰하고, 오너쉽을 가진 서비스팀
- DevOps 도구의 특징
  - 셀프 서비스 지향
  - 기술 독립적
  - 베스트 프랙티스 장려
  - 단일 목적의 서비스  
### Single-purpose
### API Interfaced
### Highly decoupled
### "Microservices"  


## ChatOps
Slack 이나 Microsoft Teams 등과 같은 채팅 플랫폼이 필요
- Chatbot 통합
![chatops.png](./img/chatops.png)  

## The Three Stage Conversation
1. People
2. Process  (Development Production)
   1. Plan  
   2. Develop  
   3. Deliver  
   4. Operate  
3. Products

## Trunk Based Development

## Microsoft Azure Virtual Training Day: GitHub 의 DevOps  
### 소개말
### DevOps 시작하기
### 작업 흐름 관리
### 클라우드에 변경 적용

## Container Security

### Kubernetes Architecture
#### Self-managed main node(s)
- API server
- Scheduler
- Controller Manager
- Cloud Controller

#### Agent Pool
- Docker
- Pods

### USER 지정 - Update Non-Root Permission
- ROOT 로 실행되지 않도록 함
   ```
   Dockerfile
   ARG sdkTag=3.0
   ARG runtimeTag=3.0
   ARG image=mcr.microsoft

   FROM node:8.12.0-alpine AS base
   WORKDIR /app
   EXPOSE 80

   COPY . .

   USER 1000

   ENTRYPOINT ["node", "start"]
   ```

### 2021-03-17
- K8S 내부 구성을 위한 Container의 Layer 구조는 유니파이드 구조를 가지고 있으며 읽기전용으로써 각 레이어는 해시값을 가집니다.
- 어플리케이션 구성을 위한 컨테이너 도구로 Docker 를 사용할 경우 Dockerfile 의 설정을 통해 런타임 스택과 어플리케이션을 정의 할 수 있습니다.
- Azure Security Center(Preview)를 통해 특정 이미지의 보안상 문제점을 파악 할 수 있습니다.
- GIthub 의 Actions 기능을 통해. Azure의 Infra As a Code 에 대한 Ops 구성이 가능합니다.
- Github Actions 기능을 통해. 코드상의 수정 내역을 Git Push기반 트리거링(Push, PR, Merge 등) 하여 Stage 혹은 Production 에 CI/CD를 적용 할 수 있습니다.
- Azure Logic Apps 를 통해. 특정 조건을 트리거로 여러 작업을 구성 할 수 있습니다.

### Automation
Can't see the value of automations?!! At some point it's an IQ test.