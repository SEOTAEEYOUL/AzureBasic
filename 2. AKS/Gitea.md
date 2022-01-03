# Gitea

## 설치 명령어
```
helm search repo gitea
helm fetch gitea-charts/gitea
tar -xzvf gitea-4.0.1.tgz
mv gitea gitea-4.0.1
cd gitea-4.0.1
cp values.yaml values-custom.yaml
helm install gitea -n cicd -f values-custom.yaml .
```

## 설치 로그
### gitea 검색
```
helm search repo gitea
NAME                    CHART VERSION   APP VERSION     DESCRIPTION
gitea-charts/gitea      4.0.1           1.14.3          Gitea Helm chart for Kubernetes
```

### gitea option (values-custom.yaml)
- "letsencrypt" 를 통해 인증을 받도록 함
- ingress 설정
  ```
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: nginx
      kubernetes.io/tls-acme: "true"
      cert-manager.io/cluster-issuer: letsencrypt
    hosts:
      - host: gitea.a-tcl-da.net
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: gitea-tls
        hosts:
          - gitea.a-tcl-da.net
  ```
- service 항목 수정
  - ClusterIP: None -> ClusterIP 로 변경 ClusterIP 를 받도록 함
  ```
  service:
  http:
    type: ClusterIP
    port: 3000
    clusterIP:
    # clusterIP: None
    #loadBalancerIP:
    #nodePort:
    #externalTrafficPolicy:
    #externalIPs:
    loadBalancerSourceRanges: []
    annotations:
  ssh:
    type: ClusterIP
    port: 22
    clusterIP:
    # clusterIP: None
    #loadBalancerIP:
    #nodePort:
    #externalTrafficPolicy:
    #externalIPs:
    loadBalancerSourceRanges: []
    annotations:
  ```
- admin id/pw 변경
  ```
  gitea:
  admin:
    #existingSecret: gitea-admin-secret
    username: daadmin
    password: "A-tcl-DA!"
    email: "gitea@a-tcl-da.net"
  ```

- metric enable
  ```
  metrics:
    enabled: true
    serviceMonitor:
      enabled: true
      additionalLabels:
        prometheus-release: prom1
  ```

- oauth
  ```
    oauth:
    enabled: true
  ```

- 내장 database (postgresql -> mariadb)
  ```
    database:
    builtIn:
      postgresql:
        enabled: false
      mysql:
        enabled: false
      mariadb:
        enabled: true
  ```

### helm 설치 로그
- helm install
```
helm install gitea -n cicd -f values-custom.yaml .
NAME: gitea
LAST DEPLOYED: Mon Jul 26 04:17:03 2021
NAMESPACE: cicd
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  https://gitea.a-tcl-da.net/
```
- pod
```
kc get pods
NAME                               READY   STATUS    RESTARTS   AGE
gitea-0                            1/1     Running   0          78s
gitea-mariadb-0                    1/1     Running   0          78s
gitea-memcached-6f7b7f686c-pk2fl   1/1     Running   0          78s

kc get ep
NAME              ENDPOINTS               AGE
gitea-http        192.168.97.47:3000      2m22s
gitea-mariadb     192.168.111.130:3306    2m22s
gitea-memcached   192.168.127.184:11211   2m22s
gitea-ssh         192.168.97.47:22        2m22s

kc get svc
NAME              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
gitea-http        ClusterIP   None             <none>        3000/TCP    2m42s
gitea-mariadb     ClusterIP   10.100.87.125    <none>        3306/TCP    2m42s
gitea-memcached   ClusterIP   10.100.121.221   <none>        11211/TCP   2m42s
gitea-ssh         ClusterIP   None             <none>        22/TCP      2m42s

kc get ing
NAME    CLASS    HOSTS                ADDRESS   PORTS     AGE
gitea   <none>   gitea.a-tcl-da.net             80, 443   81s
```
