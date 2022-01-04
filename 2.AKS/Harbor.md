# Harbor

## 설치 명령어
```
helm search repo harbor
helm fetch harbor/harbor
tar -xzvf harbor-1.7.0.tgz
mv harbor harbor-1.7.0
cd harbor-1.7.0
cp values.yaml values-custom.yaml
helm install harbor -n cicd -f values-custom.yaml .
```

## 설치 로그
### harbor 검색
```
helm search repo harbor
NAME            CHART VERSION   APP VERSION     DESCRIPTION
bitnami/harbor  10.2.3          2.3.1           Harbor is an an open source trusted cloud nativ...
harbor/harbor   1.7.0           2.3.0           An open source trusted cloud native registry th...
```

### harbor option (values-custom.yaml)
- admin id/pw 변경
  ```
  # The initial password of Harbor admin. Change it from portal after launching Harbor
  harborAdminPassword: "A-tcl-DA!"
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
- helm install
```
helm install harbor -n cicd -f values-custom.yaml .
NAME: harbor
LAST DEPLOYED: Tue Jul 27 08:14:46 2021
NAMESPACE: cicd
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Please wait for several minutes for Harbor deployment to complete.
Then you should be able to visit the Harbor portal at https://core.harbor.domain
For more details, please visit https://github.com/goharbor/harbor
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