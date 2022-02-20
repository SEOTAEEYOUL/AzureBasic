# AKS Pod 배포하기

## container image build & push
### Dockerfile
### container build
```
podman build --rm=true --network=host --tag nodejs-bot:1.1.0 .
podman tag nodejs-bot:1.1.0 nodespringboot.azurecr.io/nodejs-bot:1.1.0
```

### container registory 에 넣기
```
podman login nodespringboot.azurecr.io --username 00000000-0000-0000-0000-000000000000 -p
podman push nodespringboot.azurecr.io/springboot:1.1.0
```

## pod 를 위한 manifest 작성
### Manifest 작성
#### springboot-deploy.yaml
```yaml
kind: Deployment
metadata:
  name: springboot
spec:
  selector:
    matchLabels:
      run: springboot
  replicas: 2
  template:
    metadata:
      labels:
        run: springboot
    spec:
      containers:
      - name: springboot
        image: springboot:0.1.0
        ports:
        - containerPort: 8080
```

## kubectl 를 사용한 배포
kubectl create -f springboot-deploy.yaml
```
```

