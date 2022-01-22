# 자원



### App Service
- 이미 배포되어 있는 서버들 중에서 어떤 OS 를 사용하여 어떤 언어로 배포할지 정하면 손쉽게 배포할 수 있음
- ASP.NET, ASP.NET Core, Java, Runy, Node.js, PHP, Python 등 다양한 언어를 사용
- 별도의 툴 없이 CI/CD 등 향상된 생산성을 제공
- 트랙픽에 따른 자동 확장도 가능
- Application Insights 와 연동하면 상세한 모니터링이 가능

### Azure Functions
- 부분함수 형태로 만들어 사용
- 서버리스 애플리케이션
- 사용량 단위 비용 지불

### Azure Kubernetes Service(AKS)
- Master 서버 생성 없이 Node Pool 만 생성하여 사용
- 비용도 Node(VM) 수량만큼 지불하면 됨
- Azre DevOps 와 연동 CI/CD