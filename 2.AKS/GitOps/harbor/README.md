# [Harbor](https://github.com/goharbor/harbor)  

최소사양: 2 CPU/4GB 메모리/40GB 디스크  
권장사양: 4 CPU/8GB 메모리/160GB 디스크  

## 설치 명령어
```
helm repo add harbor https://helm.goharbor.io
helm search repo harbor
helm fetch harbor/harbor
tar -xzvf harbor-1.8.1.tgz
mv harbor harbor-1.8.1
cd harbor-1.8.1
cp values.yaml values.yaml.org
helm install harbor -n cicd -f values.yaml .
```

## 설치 로그
### harbor 검색
```
helm search repo harbor
NAME            CHART VERSION   APP VERSION     DESCRIPTION
bitnami/harbor  10.2.3          2.3.1           Harbor is an an open source trusted cloud nativ...
harbor/harbor   1.7.0           2.3.0           An open source trusted cloud native registry th...
```

### harbor option (values.yaml)
- ingress domain 설정
  ```
  .
  .
  .
    ingress:
    hosts:
      core: harbor.nodespringboot.org
      notary: notary-harbor.nodespringboot.org
    annotations:
      # note different ingress controllers may require a different ssl-redirect annotation
      # for Envoy, use ingress.kubernetes.io/force-ssl-redirect: "true" and remove the nginx lines below
      ingress.kubernetes.io/ssl-redirect: "true"
      ingress.kubernetes.io/proxy-body-size: "0"
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
      nginx.ingress.kubernetes.io/proxy-body-size: "0"
      nginx.ingress.kubernetes.io/use-regex: "true"
      nginx.ingress.kubernetes.io/rewrite-target: /$1  
      .
      .
      .
  externalURL: https://harbor.nodespringboot.org/
  .
  .
  .
  ```
- admin id/pw 변경
  ```
  # The initial password of Harbor admin. Change it from portal after launching Harbor
  harborAdminPassword: "dlatl!00"
  ```

- metric enable
  ```
  metrics:
    enabled: true
    core:
      path: /metrics
      port: 8001
    registry:
      path: /metrics
      port: 8001
    jobservice:
      path: /metrics
      port: 8001
    exporter:
      path: /metrics
      port: 8001
    ## Create prometheus serviceMonitor to scrape harbor metrics.
    ## This requires the monitoring.coreos.com/v1 CRD. Please see
    ## https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/user-guides/getting-started.md
    ##
    serviceMonitor:
      enabled: true
  ```

### helm 설치 로그
- helm install harbor -n cicd -f values.yaml .
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.8.1> helm install harbor -n cicd -f values.yaml .
NAME: harbor
LAST DEPLOYED: Sat Feb 26 17:54:26 2022
NAMESPACE: cicd
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Please wait for several minutes for Harbor deployment to complete.
Then you should be able to visit the Harbor portal at https://core.harbor.domain
For more details, please visit https://github.com/goharbor/harbor
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.8.1> 
```

### 배포 확인
**kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor**
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.8.1> kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor
NAME                                                    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-harbor-redis-0               Bound    pvc-144d1bfd-6783-469d-98b0-907682ccd13f   1Gi        RWO            default        106s
persistentvolumeclaim/data-harbor-trivy-0               Bound    pvc-db2c2630-808d-4bb1-aede-d8646a323c28   5Gi        RWO            default        106s
persistentvolumeclaim/database-data-harbor-database-0   Bound    pvc-91b39c59-5303-412b-80f2-e4af0d93f692   1Gi        RWO            default        106s
persistentvolumeclaim/harbor-chartmuseum                Bound    pvc-c72b2c28-25ae-4aab-8ce6-c0122101c37c   5Gi        RWO            default        106s
persistentvolumeclaim/harbor-jobservice                 Bound    pvc-9deced37-36d1-4858-a432-4586efda4b3f   1Gi        RWO            default        106s
persistentvolumeclaim/harbor-registry                   Bound    pvc-096594ab-c69e-4c12-a4e3-84d271b3bcf8   5Gi        RWO            default        106s

NAME                                        READY   STATUS    RESTARTS   AGE
pod/harbor-chartmuseum-d8bf4c58c-g5cpx      1/1     Running   0          106s
pod/harbor-core-6d867bbf5d-r9q8d            1/1     Running   0          106s
pod/harbor-database-0                       1/1     Running   0          106s
pod/harbor-exporter-54c7c5c8ff-q9wp2        1/1     Running   0          106s
pod/harbor-jobservice-fddb76c5d-99fg6       1/1     Running   0          105s
pod/harbor-notary-server-5798d99f97-cclzt   1/1     Running   0          105s
pod/harbor-notary-signer-7796f6d8f-df29t    1/1     Running   0          106s
pod/harbor-portal-5598f9d6db-mldb6          1/1     Running   0          106s
pod/harbor-redis-0                          1/1     Running   0          106s
pod/harbor-registry-5ff7bb5b77-vbltt        2/2     Running   0          105s
pod/harbor-trivy-0                          1/1     Running   0          106s

NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
service/harbor-chartmuseum     ClusterIP   10.0.84.217    <none>        80/TCP                       106s
service/harbor-core            ClusterIP   10.0.46.187    <none>        80/TCP,8001/TCP              106s
service/harbor-database        ClusterIP   10.0.135.12    <none>        5432/TCP                     106s
service/harbor-exporter        ClusterIP   10.0.112.17    <none>        8001/TCP                     106s
service/harbor-jobservice      ClusterIP   10.0.49.214    <none>        80/TCP,8001/TCP              106s
service/harbor-notary-server   ClusterIP   10.0.157.166   <none>        4443/TCP                     106s
service/harbor-notary-signer   ClusterIP   10.0.11.221    <none>        7899/TCP                     106s
service/harbor-portal          ClusterIP   10.0.235.18    <none>        80/TCP                       106s
service/harbor-redis           ClusterIP   10.0.87.138    <none>        6379/TCP                     106s
service/harbor-registry        ClusterIP   10.0.147.65    <none>        5000/TCP,8080/TCP,8001/TCP   106s
service/harbor-trivy           ClusterIP   10.0.89.193    <none>        8080/TCP                     106s

NAME                             ENDPOINTS                                            AGE
endpoints/harbor-chartmuseum     10.244.3.115:9999                                    106s
endpoints/harbor-core            10.244.3.113:8001,10.244.3.113:8080                  106s
endpoints/harbor-database        10.244.3.114:5432                                    106s
endpoints/harbor-exporter        10.244.4.55:8001                                     106s
endpoints/harbor-jobservice      10.244.3.116:8080,10.244.3.116:8001                  106s
endpoints/harbor-notary-server   10.244.4.58:4443                                     106s
endpoints/harbor-notary-signer   10.244.4.56:7899                                     106s
endpoints/harbor-portal          10.244.4.57:8080                                     106s
endpoints/harbor-redis           10.244.4.61:6379                                     106s
endpoints/harbor-registry        10.244.4.59:8080,10.244.4.59:8001,10.244.4.59:5000   106s
endpoints/harbor-trivy           10.244.4.60:8080                                     106s

NAME                                              CLASS    HOSTS                              ADDRESS   PORTS     AGE
ingress.networking.k8s.io/harbor-ingress          <none>   harbor.nodespringboot.org                    80, 443   106s
ingress.networking.k8s.io/harbor-ingress-notary   <none>   notary.harbor.nodespringboot.org             80, 443   106s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.8.1> 
```

#### 설치 제거
helm uninstall harbor -n cicd
kubectl -n cicd delete pvc -l app=harbor
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> kubectl -n cicd delete pvc -l app=harbor             
persistentvolumeclaim "data-harbor-redis-0" deleted
persistentvolumeclaim "data-harbor-trivy-0" deleted
persistentvolumeclaim "database-data-harbor-database-0" deleted
persistentvolumeclaim "harbor-chartmuseum" deleted
persistentvolumeclaim "harbor-jobservice" deleted
persistentvolumeclaim "harbor-registry" deleted
```

### Troubleshooting
- harbar-database 오류
```
kc get pods
NAME                                    READY   STATUS             RESTARTS   AGE
gitea-0                                 1/1     Running            0          121m
gitea-mariadb-0                         1/1     Running            0          121m
gitea-memcached-6f7b7f686c-ml4rp        1/1     Running            0          121m
harbor-chartmuseum-745c4bfb9b-k8kz6     1/1     Running            0          15m
harbor-core-58f5769485-dtwcn            0/1     CrashLoopBackOff   6          15m
harbor-database-0                       0/1     CrashLoopBackOff   7          15m
harbor-exporter-b9c898567-66gzz         0/1     CrashLoopBackOff   6          15m
harbor-jobservice-bd8655f87-qsl9f       0/1     CrashLoopBackOff   6          15m
harbor-notary-server-7cd9888ccb-b567l   0/1     Running            7          15m
harbor-notary-signer-56499fd544-c99cf   0/1     Running            7          15m
harbor-portal-5bfdfcf9f6-l6n55          1/1     Running            0          15m
harbor-redis-0                          1/1     Running            0          15m
harbor-registry-75776bc98-2pqjg         2/2     Running            0          15m
harbor-trivy-0                          1/1     Running            0          15m
jenkins-0                               2/2     Running            0          98m
```
```
kc logs harbor-database-0
2021-07-27 08:29:10.440 UTC [1] FATAL:  data directory "/var/lib/postgresql/data/pgdata/pg13" has invalid permissions
2021-07-27 08:29:10.440 UTC [1] DETAIL:  Permissions should be u=rwx (0700) or u=rwx,g=rx (0750).
no need to upgrade postgres, launch it.

```
#### Harbor database init script 변경
- kc edit sts harbor-database
```
      - args:
        - -c
        - chmod 700 /var/lib/postgresql/data/pgdata /var/lib/postgresql/data/pgdata/pg13 || true
        command:

```
- 설치전 template 수정 (harbor-1.7.0/templates/database/database-ss.yaml)
```
      - name: "data-permissions-ensurer"
        image: {{ .Values.database.internal.image.repository }}:{{ .Values.database.internal.image.tag }}
        imagePullPolicy: {{ .Values.imagePullPolicy }}
        command: ["/bin/sh"]
        args: ["-c", "chmod 700 /var/lib/postgresql/data/pgdata /var/lib/postgresql/data/pgdata/pg13 || true"]
{{- if .Values.database.internal.initContainer.permissions.resources }}
        resources:
{{ toYaml .Values.database.internal.initContainer.permissions.resources | indent 10 }}
{{- end }}
```
  
- 수정 후 로그
```
kc logs -f harbor-database-0
no need to upgrade postgres, launch it.
2021-07-27 08:37:56.458 UTC [1] LOG:  starting PostgreSQL 13.3 on x86_64-unknown-linux-gnu, compiled by x86_64-unknown-linux-gnu-gcc (GCC) 10.2.0, 64-bit
2021-07-27 08:37:56.458 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2021-07-27 08:37:56.458 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2021-07-27 08:37:56.465 UTC [1] LOG:  listening on Unix socket "/run/postgresql/.s.PGSQL.5432"
2021-07-27 08:37:56.477 UTC [7] LOG:  database system was shut down at 2021-07-27 08:15:37 UTC
2021-07-27 08:37:56.493 UTC [1] LOG:  database system is ready to accept connections
```
- 서비스 의 빠른 정상화을 위해 CrashLoopBackOff 상태의 Pod 강제 종료
```
kc --force --grace-period=0 delete pods harbor-exporter-b9c898567-66gzz
warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
^[kwpod "harbor-exporter-b9c898567-66gzz" force deleted
kc --force --grace-period=0 delete pods harbor-jobservice-bd8655f87-qsl9f
warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "harbor-jobservice-bd8655f87-qsl9f" force deleted
kc --force --grace-period=0 delete pods harbor-core-58f5769485-dtwcn
warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "harbor-core-58f5769485-dtwcn" force deleted
```
- 서비스 정상화 확인
```
kc get pods
NAME                                    READY   STATUS    RESTARTS   AGE
gitea-0                                 1/1     Running   0          129m
gitea-mariadb-0                         1/1     Running   0          129m
gitea-memcached-6f7b7f686c-ml4rp        1/1     Running   0          129m
harbor-chartmuseum-745c4bfb9b-k8kz6     1/1     Running   0          23m
harbor-core-58f5769485-b9nc9            1/1     Running   0          80s
harbor-database-0                       1/1     Running   0          3m28s
harbor-exporter-b9c898567-vpjl4         1/1     Running   0          97s
harbor-jobservice-bd8655f87-6dff5       1/1     Running   0          89s
harbor-notary-server-7cd9888ccb-b567l   1/1     Running   8          23m
harbor-notary-signer-56499fd544-c99cf   1/1     Running   8          23m
harbor-portal-5bfdfcf9f6-l6n55          1/1     Running   0          23m
harbor-redis-0                          1/1     Running   0          23m
harbor-registry-75776bc98-2pqjg         2/2     Running   0          23m
harbor-trivy-0                          1/1     Running   0          23m
jenkins-0                               2/2     Running   0          106m
```
```
kc get ing
NAME                    CLASS    HOSTS                                     ADDRESS   PORTS     AGE
cicd-ing                <none>   gitea.a-tcl-da.net,jenkins.a-tcl-da.net             80        100m
harbor-ingress          <none>   harbor.a-tcl-da.net                                 80, 443   25m
harbor-ingress-notary   <none>   notary.a-tcl-da.net                                 80, 443   25m
```