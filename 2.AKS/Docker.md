# Docker

## Dockerfile 형식
| 항목 | 설명 |  
|:---|:---|  
| FROM | Base Image 지정(OS 및 버전 명시, Base Image에서 시작해서 커스텀 이미지를 추가) |  
| RUN | shell command를 해당 docker image에 실행시킬 때 사용함 |  
| WORKDIR | Docker File에 있는 RUN, CMD, ENTRYPOINT, COPY, ADD 등의 지시를 수행할 곳 |  
| EXPOSE | 호스트와 연결할 포트 번호를 지정 |  
| USER | 명령 실행할 사용자 권한 지정 |  
| ADD | 파일 / 디렉토리 추가, URL 과 같은 원격에서 파일 다운로드 받을 수 있음 |  
| COPY | 파일 복사, 순수 파일 복사 기능 |  
| CMD | application을 실행하기 위한 명령어 |  
| ENTRYPOINT | 컨테이너가 시작되었을 때 스크립트 실행 |  

## Dockerfile 예
- echo
  ```
  FROM alpine:3.10

  ENTRYPOINT ["echo", "hello"]
  ```
- nginx
  ```
  FROM nginx:latest
  RUN  echo '<h1> test nginx web page </h1>'  >> index.html
  RUN cp /index.html /usr/share/nginx/html
  ```

## Docker 명령
| 항목 | 설명 |  예 |
|:---|:---|:---|    
| build | 이미지 만들기 | docker build -t test-image . |  
| images | 생성된 이미지 확인 | docker images |  
| run | 컨테이너 이미지를 실행 | docker run -p 8080:80 --name test-nginx test-image |  
| ps | 실행중인 컨테이너 확인 | docker ps |  
| logs | 컨테이너의 로그를 출력해서 상태 확인 | docker logs -f test-nginx |  
| exec | 컨네이너 내부 쉘 환경 접근 | docker exec -it test-nginx /bin/bash |  
| stop | 실행중인 컨테이너 중지 | docker stop test-nginx |  
| rm | 컨테이너 삭제 | docker rm test-nginx |  
| rmi | 컨테이너 이미지 삭제 | docker rmi test-image |  


### Docker build
```
podman build --tag nodespringboot:0.1.0 .
```
#### -t, --tag : 저장소 이미지, 이미지 이름, 태그 설정
형식 : <저장소 이름>/<이미지 이름>:<태그> 

#### --rm=true : 이미지 생성에 성공했을 때 임시 컨테이너 삭제
#### --force-rm=false : 이미지 생성에 실패했을 때도 임시 컨테이너 삭제

### Docker tag
```
podman tag nodespringboot:0.1.0 nodespringboot.azurecr.io/nodespringboot:0.1.0
```

### Docker push
```
podman push nodespringboot.azurecr.io/nodespringboot:0.1.0
```
### Docker run 
```
podman run --network=host nodespringboot:0.1.0 --name springmysql -p 8080:8080 -d -it
```
#### -it 
터미널에서 실행할 때 사용
##### -i : interfactive
##### -t : tty

#### -p [호스트의 포트:컨테이너 포트]
#### --name [컨테이너 이름]
#### --network [bridge|host]
- bridge : 기본
- host : host 의 네트워크 사용
#### -d, --detach
컨테이너를 백그라운드에서 실행  
