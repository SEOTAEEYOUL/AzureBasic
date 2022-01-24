# Ingress Controller 설치

## (Optional) AKS 서비스가 Stop되어 있을 경우 다시 start 하기
```
az aks start -g rg-kubernetes -n aks-cluster
kubectl get ns

(Stop용) az aks stop -g rg-kubernetes -n aks-cluster
```

## Ingress Controller 설치
```
kubectl create namespace ingress-basic
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo list
helm install nginx-ingress ingress-nginx/ingress-nginx  \
 --namespace ingress-basic  --set controller.replicaCount=2  \
 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
 --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
kubectl -n ingress-basic get pod
kubectl -n ingress-basic get all
kubectl --namespace ingress-basic get services -o wide -w nginx-ingress-ingress-nginx-controller
```
- 설치 후 (만들어진 LoadBalancer 타입의) 서비스를 확인하면 EXTERNAL-IP 가 등록된 것을 확인할 수 있음.
  ```
  kubectl get svc -n ingress-basic
  ```

# Domain을 따기
- Azure 내부에서
  * DNS 영역 (DNS Zone) 화면으로 들어가 도메인을 생성: chatops.ga
    - 리소스 그룹: rg-kubernetes
  * A Record 를 추가: `*` 라는 이름으로, 위에 확인한 EXTERNAL-IP 값을
    ```
    az network dns record-set a add-record    \
     --resource-group rg-kubernetes \
     --zone-name chatops.ga  \
     --record-set-name '*' \
     --ipv4-address 20.41.72.147
    ```
  * 등록 후 어떤 네임서버들이 설정되어 있는지 기억해 두자.  
    ![Azure Nameservers](https://github.com/SEOTAEEYOUL/A-TCL-ChatOps/blob/main/img/azure-dns-nameservers.png)
  * 테스트: 
    - `nslookup chatops.ga ns2-01.azure-dns.net`
    - Azure 의 네임서버에서 인식하는 것까지만 확인
  * 아주 오랜 시간을 기다리면 도메인 정보가 전파되어 접속 가능해 지는데 그날 안으로로 안되던 경험이 있음  
    --> 좀더 빨리 전파되도록 외부에서 작업을 해 주자
- Azure 외부에서
  * 무료 DNS 제공 사이트 https://www.freenom.com/ 에 로그인
  * Register a New Domain 메뉴를 선택하고 
    - 도메인: `chatops.ga`
    - 도메인에 IP를 직접 매핑하는 방식과 정보를 가져올 네임서버를 지정하는 방식이 있으며 우리는 후자를 택할 것
    - 앞서 기억해 둔 Azure Name server 들을 등록.
    - 관련화면은 다음과 같음:  
      ![freenom DNS서버 지정](https://github.com/SEOTAEEYOUL/A-TCL-ChatOps/blob/main/img/freenom-dns-setting-01.png)  
      이 화면은 사실 처음 등록할 때의 화면이 아니고 이후 수정할 때의 화면임. (처음 등록할 때 이상하게 좀 안되더라)

# Cert Manager 설치
 - external IP를 아래 IP에다가 적는다. *의 경우 '' or \ 로 감싸주어야 한다.
```
helm repo add jetstack https://charts.jetstack.io
kubectl label namespace ingress-basic cert-manager.io/disable-validation=true
helm repo update
helm search repo jetstack/cert-manager
helm install cert-manager jetstack/cert-manager \
 --namespace ingress-basic  \
 --version v1.3.1 \
 --set installCRDs=true  \
 --set nodeSelector."beta\.kubernetes\.io/os"=linux  \
 --set webhook.nodeSelector."kubernetes\.io/os"=linux \
 --set cainjector.nodeSelector."kubernetes\.io/os"=linux
```
# CA 클러스터 발급자 만들기
 - SSL 접속 하기 위함
```
vi cluster-issuer.yaml
kubectl apply -f cluster-issuer.yaml

kubectl get crd
helm list --namespace ingress-basic
```
### cluster-issuer.yaml
```
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: xxx@gmail.com
    privateKeySecretRef:
      name: letsencrypt
    solvers:
    - http01:
        ingress:
          class: nginx
          podTemplate:
            spec:
              nodeSelector:
                "kubernetes.io/os": linux
  ```

 - 링크 참조: https://github.com/anabaral/azure-etude/blob/master/cert-manager.md

#샘플 테스트해보기(Study\Swagger from 서태열 수석님 작성한 것 참조)
```
vi user-deploy.yaml (https://github.com/SEOTAEEYOUL/A-TCL-ChatOps/blob/main/study/Swagger/user-deploy.yaml)
kubectl create -f user-deploy.yaml
kubectl get pod

vi user-svc.yaml https://github.com/SEOTAEEYOUL/A-TCL-ChatOps/blob/main/study/Swagger/user-svc.yaml)
kubectl create -f user-svc.yaml
kubectl get svc
kubectl get ep

vi user-ing.yaml https://github.com/SEOTAEEYOUL/A-TCL-ChatOps/blob/main/study/Swagger/user-ing.yaml)
kubectl create -f user-ing.yaml
kubectl get ing
kubectl get secret

(도메인이 변경되었을 때 다시 적용하려면) kubectl apply -f user-ing.yaml
```

# Swagger Application 접속해서 확인하기
 - https://user.chatops.ga/
 - https://user.chatops.ga/api-docs/

# Swagger Application 변경 및 Container image 생성(1.2.0) 후 재배포 접속해서 확인하기
```
swagger.yaml에 user.chatops.ga를 추가한다.
servers:
  - url: 'https://user.chatops.ga/'

az acr build --image users:1.2.0 --registry acrChatOps --file Dockerfile .

vi user-deploy.yaml
아래 라인에서 1.1.9 --> 1.2.0으로 변경하여 저장함.
image: acrChatOps.azurecr.io/users:1.2.0

kubectl apply -f user-deploy.yaml
```

- URL 재접속하여 테스트해보기
