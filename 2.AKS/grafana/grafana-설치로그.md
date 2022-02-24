
### fetch
```
PS C:\workspace\AzureBasic\2.AKS\grafana> helm fetch bitnami/grafana 
PS C:\workspace\AzureBasic\2.AKS\grafana> dir

    Directory: C:\workspace\AzureBasic\2.AKS\grafana

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---        2022-02-24 오후 10:46          42497 grafana-7.6.14.tgz
-a---        2022-02-24 오후 10:45            886 README.md

PS C:\workspace\AzureBasic\2.AKS\grafana> tar -xzvf  grafana-7.6.14.tgz
x grafana/Chart.yaml
x grafana/Chart.lock
x grafana/values.yaml
x grafana/templates/NOTES.txt
x grafana/templates/_helpers.tpl
x grafana/templates/configmap.yaml
x grafana/templates/dashboard-provider.yaml
x grafana/templates/deployment.yaml
x grafana/templates/extra-list.yaml
x grafana/templates/image-renderer-deployment.yaml
x grafana/templates/image-renderer-prometheusrules.yaml
x grafana/templates/image-renderer-service.yaml
x grafana/templates/image-renderer-servicemonitor.yaml
x grafana/templates/ingress.yaml
x grafana/templates/ldap-secret.yaml
x grafana/templates/prometheusrules.yaml
x grafana/templates/pvc.yaml
x grafana/templates/secret.yaml
x grafana/templates/service.yaml
x grafana/templates/serviceaccount.yaml
x grafana/templates/servicemonitor.yaml
x grafana/templates/smtp-secret.yaml
x grafana/templates/tls-secret.yaml
x grafana/.helmignore
x grafana/README.md
x grafana/charts/common/Chart.yaml
x grafana/charts/common/values.yaml
x grafana/charts/common/templates/_affinities.tpl
x grafana/charts/common/templates/_capabilities.tpl
x grafana/charts/common/templates/_errors.tpl
x grafana/charts/common/templates/_images.tpl
x grafana/charts/common/templates/_ingress.tpl
x grafana/charts/common/templates/_labels.tpl
x grafana/charts/common/templates/_names.tpl
x grafana/charts/common/templates/_secrets.tpl
x grafana/charts/common/templates/_storage.tpl
x grafana/charts/common/templates/_tplvalues.tpl
x grafana/charts/common/templates/_utils.tpl
x grafana/charts/common/templates/_warnings.tpl
x grafana/charts/common/templates/validations/_cassandra.tpl
x grafana/charts/common/templates/validations/_mariadb.tpl
x grafana/charts/common/templates/validations/_mongodb.tpl
x grafana/charts/common/templates/validations/_postgresql.tpl
x grafana/charts/common/templates/validations/_redis.tpl
x grafana/charts/common/templates/validations/_validations.tpl
x grafana/charts/common/.helmignore
x grafana/charts/common/README.md
PS C:\workspace\AzureBasic\2.AKS\grafana> dir

    Directory: C:\workspace\AzureBasic\2.AKS\grafana

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----        2022-02-24 오후 10:46                grafana
-a---        2022-02-24 오후 10:46          42497 grafana-7.6.14.tgz
-a---        2022-02-24 오후 10:47           2559 grafana-설치로그.md
-a---        2022-02-24 오후 10:45            886 README.md

PS C:\workspace\AzureBasic\2.AKS\grafana> mv grafana grafana-7.6.14
PS C:\workspace\AzureBasic\2.AKS\grafana> cd grafana-7.6.14
PS C:\workspace\AzureBasic\2.AKS\grafana\grafana-7.6.14> cp values.yaml values.yaml.org
```

### values.yaml 수정

### 배포하기
```
PS C:\workspace\AzureBasic\2.AKS\grafana\grafana-7.6.14> helm install grafana -f values.yaml -n monitoring .
NAME: grafana
LAST DEPLOYED: Thu Feb 24 22:51:49 2022
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: grafana
CHART VERSION: 7.6.14
APP VERSION: 8.4.1

** Please be patient while the chart is being deployed **

1. Get the application URL by running these commands:
    echo "Browse to http://127.0.0.1:8080"
    kubectl port-forward svc/grafana 8080:3000 &

2. Get the admin credentials:

    echo "User: admin"
    echo "Password: $(kubectl get secret grafana-admin --namespace monitoring -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"
PS C:\workspace\AzureBasic\2.AKS\grafana> kubectl get pvc,pod,svc,ep,ing -n monitoring -l app.kubernetes.io/component=grafana
NAME                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/grafana   Bound    pvc-cd34ad98-630d-4327-9ba3-9ba5b37ce2db   10Gi       RWO            default        9m24s

NAME                           READY   STATUS    RESTARTS   AGE
pod/grafana-696f5f47fc-87bz9   1/1     Running   0          9m24s

NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/grafana   ClusterIP   10.0.193.117   <none>        3000/TCP   9m24s

NAME                ENDPOINTS          AGE
endpoints/grafana   10.244.2.33:3000   9m24s

NAME                                    CLASS    HOSTS                        ADDRESS          PORTS   AGE
ingress.networking.k8s.io/grafana-ing   <none>   grafana.nodespringboot.org   20.200.227.196   80      11m
PS C:\workspace\AzureBasic\2.AKS\grafana> 
```