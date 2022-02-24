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
#### springmysql-deploy.yaml
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: springmysql
  namespace: homepage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: springmysql
  template:
    metadata:
      labels:
        app: springmysql
    spec:
      containers:
        - name: springmysql
          image: acrhomepage.azurecr.io/springmysql:0.1.2
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
          resources:
            requests:
              cpu: 250m
            limits:
              cpu: 500m
          env:
          - name: TITLE
            value: "AKS Ingress Demo"
```
### 서비스 Manifest 작성
```
apiVersion: v1
kind: Service
metadata:
  name: springmysql 
  namespace: homepage 
spec:
  type: ClusterIP
  ports:
  - port: 8080
  selector:
    app: springmysql
```

### Ingress manifest 작성
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: springmysql-ing
  namespace: homepage
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
  - http:
      paths:
      - path: /springmysql(/|$)(.*)
        pathType: Prefix
        backend:
          service:
            name: springmysql
            port:
              number: 8080
      - path: /(.*)
        pathType: Prefix
        backend:
          service:
            name: springmysql
            port:
              number: 8080
```

## kubectl 를 사용한 배포
kubectl create -f springmysql-deploy.yaml
kubectl create -f springmysql-svc.yaml
kubectl create -f springmysql-ing.yaml
```
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl create -f springmysql-deploy.yaml
deployment.apps/springmysql created
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl create -f springmysql-svc.yaml
service/springmysql created
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl create -f springmysql-ing.yaml
ingress.networking.k8s.io/springmysql-ing created
PS C:\workspace\AzureBasic\2.AKS\yaml> 
```

## 배포 결과 확인
```
PS C:\workspace\AzureBasic> kubectl get pod,svc,ep,ing -n homepage
NAME                             READY   STATUS    RESTARTS   AGE
pod/springmysql-655bc7f7-rcncs   1/1     Running   0          16h

NAME                  TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/springmysql   ClusterIP   10.0.226.46   <none>        8080/TCP   18h

NAME                    ENDPOINTS          AGE
endpoints/springmysql   10.244.0.20:8080   18h

NAME                                        CLASS    HOSTS   ADDRESS          PORTS   AGE
ingress.networking.k8s.io/springmysql-ing   <none>   *       20.200.248.217   80      18h
PS C:\workspace\AzureBasic> 
```

### 브라우저에서 보기
http://springmysql.nodespringboot.org/  
![springmysql.nodespringboot.org.png](./img/springmysql.nodespringboot.org.png)  


http://www.nodespringboot.org/  
![nodespringboot.org.springmysql.png](./img/nodespringboot.org.springmysql.png)  


## 삭제
kubectl delete -f springmysql-deploy.yaml  
kubectl delete -f springmysql-svc.yaml  
kubectl delete -f springmysql-ing.yaml  
```
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl delete -f springmysql-deploy.yaml
deployment.apps "springmysql" deleted
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl delete -f springmysql-svc.yaml
service "springmysql" deleted
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl delete -f springmysql-ing.yaml
ingress.networking.k8s.io "springmysql-ing" deleted
PS C:\workspace\AzureBasic\2.AKS\yaml> 
```