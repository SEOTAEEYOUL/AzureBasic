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