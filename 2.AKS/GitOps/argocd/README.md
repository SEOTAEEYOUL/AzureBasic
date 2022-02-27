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
argo/argocd-applicationset      1.0.0           v0.1.0          A Helm chart for installing ArgoCD ApplicationSet
argo/argocd-notifications       1.4.1           1.1.1           A Helm chart for ArgoCD notifications, an add-o...
argo/argo-cd                    3.10.1          2.0.5           A Helm chart for ArgoCD, a declarative, GitOps ...
```

### argocd option (values-custom.yaml)
- admin id/pw 변경
  ```
  ## Argo Configs
  configs:
    secret:
      # Argo expects the password in the secret to be bcrypt hashed. You can create this hash with
      # ARGO_PWD='dlatl!00'
      # `htpasswd -nbBC 10 "" $ARGO_PWD | tr -d ':\n' | sed 's/$2y/$2a'`
      # htpasswd -nbBC 10 $ARGO_PWD | %{$_ -replace(':\n', '')} | sed 's/$2y/$2a/'
      argocdServerAdminPassword: "$2a$10$z2lG4uy6gd1/OjtLzkqC8OAQ9wX5um9akTGSyZdlDiU/6ck498y9O"
      # Password modification time defaults to current time if not set
      # argocdServerAdminPasswordMtime: "2006-01-02T15:04:05Z"
  ```
- argocd server 인증 설정
```
  ## Certificate configuration
  certificate:
    enabled: true
    domain: argocd.a-tcl-da.net
    issuer:
      kind: ClusterIssuer
      name: letsencrypt
    additionalHosts: []
    secretName: argocd-server-tls
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
      enabled: true
      annotations:
        # kubernetes.io/tls-acme: "true"
        # cert-manager.io/cluster-issuer: letsencrypt
        ingress.kubernetes.io/proxy-body-size: "0"
        kubernetes.io/ingress.class: nginx
        # kubernetes.io/ingress.class: alb
        # alb.ingress.kubernetes.io/scheme: internet-facing
        # alb.ingress.kubernetes.io/target-type: ip
        nginx.ingress.kubernetes.io/proxy-body-size: "0"
        nginx.ingress.kubernetes.io/use-regex: "true"

      labels: {}
      ingressClassName: ""

      ## Argo Ingress.
      ## Hostnames must be provided if Ingress is enabled.
      ## Secrets must be manually created in the namespace
      ##
      hosts:
        # []
        - argocd.a-tcl-da.net
      paths:
        - /
      pathType: Prefix
      extraPaths:
        # []
        # - path: /*
        #   backend:
        #     serviceName: ssl-redirect
        #     servicePort: use-annotation
        ## for Kubernetes >=1.19 (when "networking.k8s.io/v1" is used)
        - path: /*
          pathType: Prefix
          backend:
            service:
              name: ssl-redirect
              port:
                name: use-annotation
  ```

### helm 설치 로그
- helm install argocd -n cicd -f values-custom.yaml .
  ```
  helm install argocd -n cicd -f values-custom.yaml .
  NAME: argocd
  LAST DEPLOYED: Mon Aug  2 01:23:22 2021
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

  ```

### Troubleshooting


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