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
  global:
    # -- Additional labels to add to all resources
    additionalLabels: # {}
      app: argocd

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

    # exxtraArgs 주석 해제
    extraArgs:
        - --insecure
    
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
      cert-manager.io/cluster-issuer: letsencrypt

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

    # config 수정
    config:
        # Argo CD's externally facing base URL (optional). Required when configuring SSO
        url: https://argocd.chatops.ga
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

### admin password 확인
**kubectl -n cicd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d**
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argo-cd-3.33.8> kubectl -n cicd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
PV8KBnibmQIObzxL
```

### password 변경
```
## pod 안으로 들어가기
kubectl exec -it -n cicd argocd-server-76b7c65745-cwlb5 -- bash
## 로그인
argocd login argocd.nodespringboot.org
## 비밀번호 변경
argocd account update-password
```
#### 실행 로그
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argo-cd-3.33.8> kubectl -n cicd exec argocd-server-86cd4449db-4754h -it -- bash
argocd@argocd-server-86cd4449db-4754h:~$ argocd login argocd.nodespringboot.org
WARN[0000] Failed to invoke grpc call. Use flag --grpc-web in grpc calls. To avoid this warning message, use flag --grpc-web. 
Username: admin           
Password:
'admin:login' logged in successfully
Context 'argocd.nodespringboot.org' updated
argocd@argocd-server-86cd4449db-4754h:~$ argocd account update-password
WARN[0000] Failed to invoke grpc call. Use flag --grpc-web in grpc calls. To avoid this warning message, use flag --grpc-web. 
*** Enter password of currently logged in user (admin): 
*** Enter new password for user admin:
*** Confirm new password for user admin:
Password updated
Context 'argocd.nodespringboot.org' updated
argocd@argocd-server-86cd4449db-4754h:~$
```

### Troubleshooting


## argocd notification
Argo CD 알림은 Argo CD 응용 프로그램을 지속적으로 모니터링하고 사용자에게 응용 프로그램 상태의 중요한 변경 사항을 알리는 유연한 방법을 제공  

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

### valuse.yaml 설정
#### Slack Notification 설정
```
xoxb-2047373963104-2315743923363-dROEWhJwZVrRCh1QJt5MkEONsecret:
  # -- Whether helm chart creates controller secret
  create: true

  # -- key:value pairs of annotations to be added to the secret
  annotations: {}

  # -- The name of the secret to use.
  ## If not set and create is true, the default name 'argocd-notifications-secret' is used
  name: ""

  # -- Generic key:value pairs to be inserted into the secret
  ## Can be used for templates, notification services etc. Some examples given below.
  ## For more information: https://argocd-notifications.readthedocs.io/en/stable/services/overview/
  items: {}
    # slack-token:
    slack-token: "xoxb-2047373963104-2315743923363-dROEWhJwZVrRCh1QJt5MkEON"
    #   # For more information: https://argocd-notifications.readthedocs.io/en/stable/services/slack/
```

#### Template .주석 제거(Slack Notification Template 을 풀기 위함)
```
# -- The notification template is used to generate the notification content
## For more information: https://argocd-notifications.readthedocs.io/en/stable/templates/
templates: # {}
  template.app-deployed: |
    email:
      subject: New version of an application {{.app.metadata.name}} is up and running.
    message: |
      {{if eq .serviceType "slack"}}:white_check_mark:{{end}} Application {{.app.metadata.name}} is now running new version of deployments manifests.
    slack:
      attachments: |
        [{
          "title": "{{ .app.metadata.name}}",
          "title_link":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
          "color": "#18be52",
          "fields": [
          {
            "title": "Sync Status",
            "value": "{{.app.status.sync.status}}",
            "short": true
          },
          {
            "title": "Repository",
            "value": "{{.app.spec.source.repoURL}}",
            "short": true
          },
          {
            "title": "Revision",
            "value": "{{.app.status.sync.revision}}",
            "short": true
          }
          {{range $index, $c := .app.status.conditions}}
          {{if not $index}},{{end}}
          {{if $index}},{{end}}
          {
            "title": "{{$c.type}}",
            "value": "{{$c.message}}",
            "short": true
          }
          {{end}}
          ]
        }]
  template.app-health-degraded: |
```

#### trigger 에서 모든 상태 정보를 볼수 있게 주석 제거
```
# -- The trigger defines the condition when the notification should be sent
## For more information: https://argocd-notifications.readthedocs.io/en/stable/triggers/
triggers: # {}
  trigger.on-deployed: |
    - description: Application is synced and healthy. Triggered once per commit.
      oncePer: app.status.sync.revision
      send:
      - app-deployed
      when: app.status.operationState.phase in ['Succeeded'] and app.status.health.status == 'Healthy'
  trigger.on-health-degraded: |
    - description: Application has degraded
      send:
      - app-health-degraded
      when: app.status.health.status == 'Degraded'
  trigger.on-sync-failed: |
    - description: Application syncing has failed
      send:
      - app-sync-failed
      when: app.status.operationState.phase in ['Error', 'Failed']
  trigger.on-sync-running: |
    - description: Application is being synced
      send:
      - app-sync-running
      when: app.status.operationState.phase in ['Running']
  trigger.on-sync-status-unknown: |
    - description: Application status is 'Unknown'
      send:
      - app-sync-status-unknown
      when: app.status.sync.status == 'Unknown'
  trigger.on-sync-succeeded: |
    - description: Application syncing has succeeded
      send:
      - app-sync-succeeded
      when: app.status.operationState.phase in ['Succeeded']
  
  # For more information: https://argocd-notifications.readthedocs.io/en/stable/triggers/#default-triggers
  defaultTriggers: |
    - on-sync-status-unknown
```

### Slack Notification 적용
```
kubectl -n cicd get app
kubectl patch app nodejs-bot -n cicd -p '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-sync-succeeded.slack":"alert"}}}' --type merge
kubectl patch app springmysql -n cicd -p '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-sync-succeeded.slack":"alert"}}}' --type merge
```
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> kubectl -n cicd get app
NAME          SYNC STATUS   HEALTH STATUS
nodejs-bot    OutOfSync     Missing
springmysql   OutOfSync     Degraded
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argocd-notifications-1.8.0> kubectl -n cicd get app   
NAME          SYNC STATUS   HEALTH STATUS
nodejs-bot    Synced        Healthy
springmysql   Synced        Healthy
PS C:\workspace\AzureBasic\2.AKS\GitOps\argocd\argocd-notifications-1.8.0> 
```

#### Repository URL
```
kubectl patch app springmysql -n cicd -p '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-sync-succeeded.slack":"alert"}}}' --type merge
```

![arogcd-app.png](../../img/arogcd-app.png)  
![argocd-app-springmysql.png](../../img/argocd-app-springmysql.png)  
![argocd-nodejs-bot.png](../../img/argocd-nodejs-bot.png)

## ArgoCD 배포 구성하기
 Cluster 구성(내장된 것을 그대로 사용하면 됨)
  - in-cluser :  https//kubernetes.default.svc 1.21
    ![argocd-cluster.png](../../img/argocd-cluster.png)
- Project 생성
  - springmysql, nodejs-bot 생성
  ![argocd-project-springmysql.png](../../img/argocd-project-springmysql.png)
- Repositories 구성
  - 배포할 Repositoris 등록 : gitea 의 SpringMySQL, nodejs 등록
    ![argocd-repository-springmysql.png](../../img/argocd-repository-springmysql.png)
- App 생성 (SpringMySQL, nodejs-bot)
  - GENERAL
    - Application name
    - Project 선택
    - SYNC POLICY 선택
  - SOURCE
    - Repository URL 선택
    - Revison : HEAD
    - Path : .
  - DESTINATION
    - Cluster URL : Cluster 구성 정보 선택
    - Namespace : 
  ![arogcd-app-SpringMySQL.png](../../img/arogcd-app-SpringMySQL.png)