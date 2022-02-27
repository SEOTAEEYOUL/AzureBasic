# ArgoCD 
Kubernetes용 선언적 GitOps 지속적 전달 도구  
**정책 및 역할 기반 액세스 제어**로 아티팩트를 보호하고, **이미지가 스캔되고 취약성이 없는지 확인**하고, 이미지를 신뢰할 수 있는 것으로 서명하는 **오픈 소스 레지스트리** 

> [Argo CD - Declarative Continuous Delivery for Kubernetes](https://github.com/argoproj)
> [demo Site](https://cd.apps.argoproj.io/)

## 설치 명령어
```
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm search repo argocd
helm fetch argo/argo-cd
tar -xzvf argo-cd-3.33.8.tgz
mv argo-cd argo-cd-3.33.8
cd argo-cd-3.33.8
cp values.yaml values.yaml.org
helm install argocd -n cicd -f values.yaml .
```

## 설치 로그
### arogcd 검색
```
helm search repo argocd
NAME                            CHART VERSION   APP VERSION     DESCRIPTION
NAME                            CHART VERSION   APP VERSION     DESCRIPTION
argo/argocd-applicationset      1.11.0          v0.3.0          A Helm chart for installing ArgoCD ApplicationSet
argo/argocd-image-updater       0.6.3           v0.11.3         A Helm chart for Argo CD Image Updater, a tool ...
argo/argocd-notifications       1.8.0           v1.2.1          A Helm chart for ArgoCD notifications, an add-o...
argo/argo-cd                    3.33.8          v2.2.5          A Helm chart for ArgoCD, a declarative, GitOps ...
```

### argocd option (values-custom.yaml)
- admin id/pw 변경
  - ARGO_PWD='dlatl!00'
  - pswd_str=`htpasswd -nbBC 10 "" $ARGO_PWD | tr -d ':\n' | sed 's/$2y/$2a/'`
  ```
  ubuntu@DESKTOP-QR555PR:/mnt/c/workspace/AzureBasic/2.AKS/GitOps/argocd$ ARGO_PWD='dlatl!00'
  ubuntu@DESKTOP-QR555PR:/mnt/c/workspace/AzureBasic/2.AKS/GitOps/argocd$ pswd_str=`htpasswd -nbBC 10 "" $ARGO_PWD | tr -d ':\n' | sed 's/$2y/$2a/'`
  ubuntu@DESKTOP-QR555PR:/mnt/c/workspace/AzureBasic/2.AKS/GitOps/argocd$ echo $pswd_str
  $2a$10$g9bi/Gj5TOKwVLC/ZCBYKeaUxM1ObIuq172FT/dUtMQHJwUnzx3xu
  ```
  ```
  ## Argo Configs
  configs:
    secret:
      # Argo expects the password in the secret to be bcrypt hashed. You can create this hash with
      # ARGO_PWD='dlatl!00'
      # `htpasswd -nbBC 10 "" $ARGO_PWD | tr -d ':\n' | sed 's/$2y/$2a'`
      # htpasswd -nbBC 10 "" $ARGO_PWD | %{$_ -replace(':\n', '')} | sed 's/$2y/$2a/'
      argocdServerAdminPassword: "$2a$10$g9bi/Gj5TOKwVLC/ZCBYKeaUxM1ObIuq172FT/dUtMQHJwUnzx3xu"
      # Password modification time defaults to current time if not set
      # argocdServerAdminPasswordMtime: "2006-01-02T15:04:05Z"
  ```
- argocd server 인증 설정
  ```
    ## Certificate configuration
    certificate:
      enabled: true
      domain: argocd.nodespringboot.org
      issuer:
        kind: ClusterIssuer
        name: letsencrypt
      additionalHosts: []
      secretName: argocd-server-tls
  ```

- apiVersionOverrides
  ```
  apiVersionOverrides:
    # -- String to override apiVersion of certmanager resources rendered by this helm chart
    certmanager: "cert-manager.io/v1" # cert-manager.io/v1
    # -- String to override apiVersion of ingresses rendered by this helm chart
    ingress: "networking.k8s.io/v1" # networking.k8s.io/v1beta1
  ```

- metric enable
  ```
  ## Controller
  controller:

    ## Server metrics controller configuration
    metrics:
      enabled: true
      service:
        annotations: {}
        labels: {}
        servicePort: 8082
      serviceMonitor:
        enabled: true
        interval: 30s
      #   selector:
      #     prometheus: kube-prometheus
      #   namespace: monitoring
      #   additionalLabels: {}
  ```
- server autoscaling && ingress Controller
  ```
  ## Server
  server:
    name: server
    replicas: 1

    autoscaling:
      enabled: true
      minReplicas: 1
      maxReplicas: 5
      targetCPUUtilizationPercentage: 50
      targetMemoryUtilizationPercentage: 50

    ingress:
      # -- Enable an ingress resource for the Argo CD server
      enabled: true
      # -- Additional ingress annotations
      annotations: {}
      # -- Additional ingress labels
      kubernetes.io/ingress.class: nginx
      nginx.ingress.kubernetes.io/proxy-body-size: "0"
      nginx.ingress.kubernetes.io/use-regex: "true"
      nginx.ingress.kubernetes.io/rewrite-target: /$1   
      nginx.ingress.kubernetes.io/ssl-redirect: "false"

      labels: {}
      # -- Defines which ingress controller will implement the resource
      ingressClassName: ""

      # -- List of ingress hosts
      ## Argo Ingress.
      ## Hostnames must be provided if Ingress is enabled.
      ## Secrets must be manually created in the namespace
      hosts:
        # []
        - argocd.nodespringboot.org

      # -- List of ingress paths
      paths:
        - /(.*)
      # -- Ingress path type. One of `Exact`, `Prefix` or `ImplementationSpecific`
      pathType: Prefix
      # -- Additional ingress paths
      extraPaths:
        []
        # - path: /*
        #   backend:
        #     serviceName: ssl-redirect
        #     servicePort: use-annotation
        ## for Kubernetes >=1.19 (when "networking.k8s.io/v1" is used)
        # - path: /*
        #   pathType: Prefix
        #   backend:
        #     service:
        #       name: ssl-redirect
        #       port:
        #         name: use-annotation

      # -- Ingress TLS configuration
      tls:
        # []
        - secretName: argocd-tls-certificate
          hosts:
            - argocd.nodespringboot.org

      # -- Uses `server.service.servicePortHttps` instead `server.service.servicePortHttp`
      https: true
    ```

### helm 설치 로그
- **helm install argocd -n cicd -f values.yaml .**
  ```
  PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argo-cd-3.33.8> helm  install argocd -n cicd -f values.yaml .
  NAME: argocd
  LAST DEPLOYED: Sun Feb 27 10:36:10 2022
  NAMESPACE: cicd
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None
  NOTES:
  In order to access the server UI you have the following options:

  1. kubectl port-forward service/argocd-server -n cicd 8080:443

      and then open the browser on http://localhost:8080 and accept the certificate

  2. enable ingress in the values file `server.ingress.enabled` and either
        - Add the annotation for ssl passthrough: https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/ingress.md#option-1-ssl-passthrough
        - Add the `--insecure` flag to `server.extraArgs` in the values file and terminate SSL at your ingress: https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/ingress.md#option-2-multiple-ingress-objects-and-hosts


  After reaching the UI the first time you can login with username: admin and the random password generated during the installation. You can find the password by running:

  kubectl -n cicd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

  (You should delete the initial secret afterwards as suggested by the Getting Started Guide: https://github.com/argoproj/argo-cd/blob/master/docs/getting_started.md#4-login-using-the-cli)
  PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argo-cd-3.33.8> 
  ```
  ```
  PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argo-cd-3.33.8> kubectl -n cicd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  cLFcgtNGoMUAM4w5
  ```

### 배포된 자원 보기
**kubectl -n cicd get pvc,pod,svc,ep -l app.kubernetes.io/instance=argocd**  
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argo-cd-3.33.8> kubectl -n cicd get pvc,pod,svc,ep -l app.kubernetes.io/instance=argocd
NAME                                                 READY   STATUS    RESTARTS   AGE
pod/argocd-application-controller-7889c7b494-p465z   1/1     Running   0          2m11s
pod/argocd-dex-server-5445c96957-4cwg4               1/1     Running   0          2m11s
pod/argocd-redis-58f8d4cf8b-4v257                    1/1     Running   0          2m11s
pod/argocd-repo-server-66d4fbc6b9-w2jr2              1/1     Running   0          2m11s
pod/argocd-server-7558c864cc-wqnm4                   1/1     Running   0          2m11s

NAME                                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/argocd-application-controller   ClusterIP   10.0.175.181   <none>        8082/TCP            2m11s
service/argocd-dex-server               ClusterIP   10.0.47.101    <none>        5556/TCP,5557/TCP   2m11s
service/argocd-redis                    ClusterIP   10.0.244.188   <none>        6379/TCP            2m11s
service/argocd-repo-server              ClusterIP   10.0.113.111   <none>        8081/TCP            2m11s
service/argocd-server                   ClusterIP   10.0.238.102   <none>        80/TCP,443/TCP      2m11s

NAME                                      ENDPOINTS                             AGE
endpoints/argocd-application-controller   10.244.3.137:8082                     2m11s
endpoints/argocd-dex-server               10.244.4.96:5557,10.244.4.96:5556     2m11s
endpoints/argocd-redis                    10.244.4.94:6379                      2m11s
endpoints/argocd-repo-server              10.244.4.95:8081                      2m11s
endpoints/argocd-server                   10.244.3.136:8080,10.244.3.136:8080   2m11s
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argo-cd-3.33.8> 
```

### Troubleshooting
#### error: endpoints "default-http-backend" not found
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd> kubectl -n cicd describe ing argocd-server
Name:             argocd-server
Labels:           app.kubernetes.io/component=server
                  app.kubernetes.io/instance=argocd
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=argocd-server
                  app.kubernetes.io/part-of=argocd
                  helm.sh/chart=argo-cd-3.33.8
Namespace:        cicd
Address:          20.200.227.196
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
TLS:
  argocd-tls-certificate terminates argocd.nodespringboot.org
Rules:
  Host                       Path  Backends
  ----                       ----  --------
  argocd.nodespringboot.org
                             /argocd(/|$)(.*)   argocd-server:80 (10.244.3.142:8080)
                             /(.*)              argocd-server:80 (10.244.3.142:8080)
Annotations:                 kubernetes.io/ingress.class: nginx
                             meta.helm.sh/release-name: argocd
                             meta.helm.sh/release-namespace: cicd
                             nginx.ingress.kubernetes.io/proxy-body-size: 0
                             nginx.ingress.kubernetes.io/rewrite-target: /$1
                             nginx.ingress.kubernetes.io/use-regex: true
Events:
  Type    Reason             Age                 From                      Message
  ----    ------             ----                ----                      -------
  Normal  CreateCertificate  109s                cert-manager              Successfully created Certificate "argocd-tls-certificate"
  Normal  Sync               24s (x4 over 110s)  nginx-ingress-controller  Scheduled for sync
  Normal  Sync               24s (x4 over 110s)  nginx-ingress-controller  Scheduled for sync
```

## argocd notification

### 설치
```
helm search repo argocd
helm fetch argo/argocd-notifications
tar -xzvf argocd-notifications-1.8.0.tgz
mv argocd-notifications argocd-notifications-1.8.0
cd argocd-notifications-1.8.0
cp values.yaml values.yaml.org
helm install argocd-notifications -n cicd -f values.yaml .
```

### 배포 로그
**helm install argocd-notifications -n cicd -f values.yaml .**
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argocd-notifications-1.8.0> helm install argocd-notifications -n cicd -f values.yaml .
NAME: argocd-notifications
LAST DEPLOYED: Sun Feb 27 10:29:25 2022
NAMESPACE: cicd
STATUS: deployed
REVISION: 1
TEST SUITE: None
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argocd-notifications-1.8.0> 
```

### 배포된 자원 보기
**kubectl -n cicd get pvc,pods,svc,ep,ing -l app.kubernetes.io/instance=argocd-notifications**  
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argocd-notifications-1.8.0> kubectl -n cicd get pvc,pods,svc,ep,ing -l app.kubernetes.io/instance=argocd-notifications
NAME                                                   READY   STATUS    RESTARTS   AGE
pod/argocd-notifications-controller-689544845d-r52rs   1/1     Running   0          82s
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argocd-notifications-1.8.0>
```