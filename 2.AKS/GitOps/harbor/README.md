# [Harbor](https://goharbor.io/)

> [github](https://github.com/goharbor/harbor)  

최소사양: 2 CPU/4GB 메모리/40GB 디스크  
권장사양: 4 CPU/8GB 메모리/160GB 디스크  

## 설치 명령어
### 1.8.1 (설치 후 로그인이 안됨)
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
### 1.7.0 (설치 후 정상 로그인 됨)
```
helm fetch harbor/harbor --version 1.7.0
tar -xzvf harbor-1.7.0.tgz
mv harbor harbor-1.7.0
cd harbor-1.7.0
cp values.yaml values.yaml.org
helm install harbor -n cicd --debug -f values.yaml .
```

## 설치 로그
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.4.1> helm install harbor -n cicd -f values.yaml .
W0227 11:33:23.529651   12780 warnings.go:70] extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
W0227 11:33:23.538333   12780 warnings.go:70] extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
W0227 11:33:26.711263   12780 warnings.go:70] extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
W0227 11:33:26.719147   12780 warnings.go:70] extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
NAME: harbor
LAST DEPLOYED: Sun Feb 27 11:33:21 2022
NAMESPACE: cicd
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Please wait for several minutes for Harbor deployment to complete.
Then you should be able to visit the Harbor portal at https://core.harbor.domain
For more details, please visit https://github.com/goharbor/harbor
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.4.1> 
```

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
- admin id/pw 변경 하지 않음


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
#### bitnami 설치 로그
```
S C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-11.2.4> helm install harbor -n cicd -f values.yaml . 
NAME: harbor
LAST DEPLOYED: Sun Feb 27 13:21:23 2022
NAMESPACE: cicd
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: harbor
CHART VERSION: 11.2.4
APP VERSION: 2.4.1

** Please be patient while the chart is being deployed **

1. Get the Harbor URL:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace cicd -w harbor'
  export SERVICE_IP=$(kubectl get svc --namespace cicd harbor --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
  echo "Harbor URL: http://$SERVICE_IP/"

2. Login with the following credentials to see your Harbor application

  echo Username: "admin"
  echo Password: $(kubectl get secret --namespace cicd harbor-core-envvars -o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64 --decode)
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-11.2.4> 
```
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-11.2.4> kubectl get secret --namespace cicd harbor-core-envvars -o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64
Wkd4aGRHd2hNREE9DQo=
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-11.2.4> kubectl get secret --namespace cicd harbor-core-envvars -o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64 -d
dlatl!00
```
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-11.2.4> helm upgrade harbor bitnami/harbor --set harborAdminPassword='dlatl!00' -n cicd
Release "harbor" has been upgraded. Happy Helming!
NAME: harbor
LAST DEPLOYED: Sun Feb 27 13:35:25 2022
NAMESPACE: cicd
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
CHART NAME: harbor
CHART VERSION: 11.2.4
APP VERSION: 2.4.1

** Please be patient while the chart is being deployed **

1. Get the Harbor URL:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace cicd -w harbor'
  export SERVICE_IP=$(kubectl get svc --namespace cicd harbor --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
  echo "Harbor URL: http://$SERVICE_IP/"

2. Login with the following credentials to see your Harbor application

  echo Username: "admin"
  echo Password: $(kubectl get secret --namespace cicd harbor-core-envvars -o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64 --decode)
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-11.2.4> 
```

### 배포 확인
**kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor**
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor
NAME                                                    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-harbor-redis-0               Bound    pvc-ab763d0d-e70c-4478-9749-948433087472   1Gi        RWO            default        112s
persistentvolumeclaim/data-harbor-trivy-0               Bound    pvc-f86d6a41-df9d-4da5-9c3d-0c3dc0e03507   5Gi        RWO            default        112s
persistentvolumeclaim/database-data-harbor-database-0   Bound    pvc-5b14a515-2c4b-4133-83ea-f72fcc362956   1Gi        RWO            default        112s
persistentvolumeclaim/harbor-chartmuseum                Bound    pvc-0da7aea3-ce70-4a71-b048-7ed41e3a66d9   5Gi        RWO            default        112s
persistentvolumeclaim/harbor-jobservice                 Bound    pvc-04da9f2f-ca67-45d6-83e4-7d9c416ff8a2   1Gi        RWO            default        112s
persistentvolumeclaim/harbor-registry                   Bound    pvc-1638abfa-c48a-434c-97d8-afc28ad3f114   5Gi        RWO            default        112s

NAME                                        READY   STATUS    RESTARTS   AGE
pod/harbor-chartmuseum-85ffdbcf86-bt2zv     1/1     Running   0          112s
pod/harbor-core-75bcf78dd4-t8w7j            1/1     Running   0          112s
pod/harbor-database-0                       1/1     Running   0          112s
pod/harbor-exporter-54c7c5c8ff-gn527        1/1     Running   0          112s
pod/harbor-jobservice-6db5986465-xh6sd      1/1     Running   0          112s
pod/harbor-notary-server-55cd558878-rdrhw   1/1     Running   1          112s
pod/harbor-notary-signer-579b54bc85-bf8s5   1/1     Running   1          112s
pod/harbor-portal-5598f9d6db-m94q2          1/1     Running   0          112s
pod/harbor-redis-0                          1/1     Running   0          112s
pod/harbor-registry-7b879d7794-rw9v8        2/2     Running   0          112s
pod/harbor-trivy-0                          1/1     Running   0          112s

NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
service/harbor-chartmuseum     ClusterIP   10.0.60.104    <none>        80/TCP                       112s
service/harbor-core            ClusterIP   10.0.198.64    <none>        80/TCP,8001/TCP              112s
service/harbor-database        ClusterIP   10.0.61.201    <none>        5432/TCP                     112s
service/harbor-exporter        ClusterIP   10.0.237.68    <none>        8001/TCP                     112s
service/harbor-jobservice      ClusterIP   10.0.114.198   <none>        80/TCP,8001/TCP              112s
service/harbor-notary-server   ClusterIP   10.0.157.39    <none>        4443/TCP                     112s
service/harbor-notary-signer   ClusterIP   10.0.227.178   <none>        7899/TCP                     112s
service/harbor-portal          ClusterIP   10.0.79.216    <none>        80/TCP                       112s
service/harbor-redis           ClusterIP   10.0.211.32    <none>        6379/TCP                     112s
service/harbor-registry        ClusterIP   10.0.255.189   <none>        5000/TCP,8080/TCP,8001/TCP   112s
service/harbor-trivy           ClusterIP   10.0.73.186    <none>        8080/TCP                     112s

NAME                             ENDPOINTS                                            AGE
endpoints/harbor-chartmuseum     10.244.4.92:9999                                     112s
endpoints/harbor-core            10.244.4.89:8001,10.244.4.89:8080                    112s
endpoints/harbor-database        10.244.4.93:5432                                     112s
endpoints/harbor-exporter        10.244.3.133:8001                                    112s
endpoints/harbor-jobservice      10.244.3.134:8080,10.244.3.134:8001                  112s
endpoints/harbor-notary-server   10.244.4.88:4443                                     112s
endpoints/harbor-notary-signer   10.244.4.86:7899                                     112s
endpoints/harbor-portal          10.244.4.87:8080                                     112s
endpoints/harbor-redis           10.244.3.135:6379                                    112s
endpoints/harbor-registry        10.244.4.91:8080,10.244.4.91:8001,10.244.4.91:5000   112s
endpoints/harbor-trivy           10.244.4.90:8080                                     112s

NAME                                              CLASS    HOSTS                              ADDRESS          PORTS     AGE
ingress.networking.k8s.io/harbor-ingress          <none>   harbor.nodespringboot.org          20.200.227.196   80, 443   112s
ingress.networking.k8s.io/harbor-ingress-notary   <none>   notary-harbor.nodespringboot.org   20.200.227.196   80, 443   112s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> 
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

```
helm install --wait --name harbor --namespace cicd `
  harbor/harbor --version v1.2.1 `
  --set expose.ingress.hosts.core=harbor.${MY_DOMAIN} `
  --set expose.ingress.hosts.notary=notary.${MY_DOMAIN} `
  --set expose.tls.secretName=ingress-cert-${LETSENCRYPT_ENVIRONMENT} `
  --set persistence.enabled=false `
  --set externalURL=https://harbor.${MY_DOMAIN} `
  --set harborAdminPassword=admin
```