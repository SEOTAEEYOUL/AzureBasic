# Docker/Kubernetes
Container 란 ?
- 설치 및 간단한 Docker Image 만들기  

[Kubernetes 란 ?](https://kubernetes.io/ko/docs/concepts/overview/what-is-kubernetes/)  

## Container 
컨테이너란 호스트 OS상에 논리적인 구획(컨테이너)을 만들고, 어플리케이션을 작동시키기 위해 필요한 라이브러리나 어플리케이션 등을 하나로 모아, 마치 별도의 서버인 것처럼 사용할 수 있게 만든 것  

### [CRI(Container Runtime Interface)](./ContainerRuntimeInterface.md)  
컨테이너 런타임 표준  
컨테이너의 생성, 삭제 등 라이프사이클을 관리하는 스펙  
gRPC 기반의 API로 플러그인 구조로 추가할 수 있음  

### [Dockerfile 형식 및 명령어](./Docker.md)  
#### [podman 설치 및 예제 수행](./podman.md)  
```
podman build --tag springmysql:0.1.0 .
podman images
podman run --network=host springmysql:0.1.0 --name springmysql -p 8080:8080 -d -it
podman ps

curl localhost:8080
```
```
alias docker="podman"

docker build --tag springmysql:0.1.0 .
docker images
docker run --network=host springmysql:0.1.0 --name springmysql -p 8080:8080 -d -it
docker ps

curl localhost:8080
```

#### [SpringBoot+MySQL Containerizing 예제](https://github.com/SEOTAEEYOUL/SpringBootMySQL) 

## [Kubernetes](./Kubernetes.md)  
> [Kubernetes에 대해서][(](https://medium.com/humanscape-tech/kubernetes%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C-a336d2b6e01a))  
> [Kubernetes cluster(vagrant 를 사용한 1.21.2-00 설치)](https://github.com/SEOTAEEYOUL/kubernetes-cluster)  

Kubernetes는 구글에서 개발되고 사용 중인 컨테이너 Orchestration Management 기술로서  자동화 된 컨테이너 배포, 확장 및 관리가 가능하여 적은 인력으로 대규모의 시스템을  손쉽게 운영 할 수 있는 기술로 3개월 마다 새로운 버전이 출시 됨


### [Cloud Native](./CloudNative.md)  

### [Kubernetes](./Kubernetes.md) 
컨테이너화된 애플리케이션을 자동으로 배포, 스케일링 및 관리해주는 오픈소스 시스템  
