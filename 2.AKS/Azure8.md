# Docker/Kubernetes
Container 란 ?
- 설치 및 간단한 Docker Image 만들기  
- [Kubernetes 란 ?](https://kubernetes.io/ko/docs/concepts/overview/what-is-kubernetes/)  

## Container 
### [CRI(Container Runtime Interface)](./ContainerRuntimeInterface.md)  

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
> [Kubernetes cluster(vagrant 를 사용한 1.21.2-00 설치)](https://github.com/SEOTAEEYOUL/kubernetes-cluster)  

### [Cloud Native](./CloudNative.md)  

### [Kubernetes](./Kubernetes.md) 
컨테이너화된 애플리케이션을 자동으로 배포, 스케일링 및 관리해주는 오픈소스 시스템  
