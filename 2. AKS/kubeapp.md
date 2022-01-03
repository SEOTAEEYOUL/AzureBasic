# kubeapp
> [Get Started with Kubeapps](https://github.com/kubeapps/kubeapps/blob/master/docs/user/getting-started.md)  


---   
## bitnami/kubeapp 설치
- 설치 준비
  ```
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo update
  helm search repo kubeapp
  NAME                    CHART VERSION   APP VERSION     DESCRIPTION
  bitnami/kubeapps        7.1.0           2.3.2           Kubeapps is a dashboard for your Kubernetes clu...

  helm fetch bitnami/kubeapps
  tar -zvxf kubeapps-7.1.0.tgz
  mv kubeapps kubeapps-7.1.0
  cd kubeapps-7.1.0
  cp values.yaml values-custom.yaml
  vi values-custom.yaml
  ```

- 사용자 정의 옵션(values-custom.yaml)
  ```
  global:
    storageClass: azurefile

  ingress:
    enabled: true
    hostname: kubeapps.chatops.ga

  metadata:
    annotations:
      nginx.ingress.kubernetes.io/proxy-read-timeout: "600"
      cert-manager.io/cluster-issuer: letsencrypt
      kubernetes.io/ingress.class: nginx
      kubernetes.io/tls-acme: "true"
      nginx.ingress.kubernetes.io/use-regex: "true"
  tls: true
  certManager: true
  ```

- helm 설치
  ```
  kubectl create ns kubeapps
  helm install chatops -f values-custom.yaml -n kubeapps .
  W0611 02:22:17.859014    7851 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
  NAME: chatops
  LAST DEPLOYED: Fri Jun 11 02:22:19 2021
  NAMESPACE: monitoring
  STATUS: deployed
  REVISION: 1
  NOTES:
  ** Please be patient while the chart is being deployed **

  Tip:

    Watch the deployment status using the command: kubectl get pods -w --namespace monitoring

  Kubeapps can be accessed via port 80 on the following DNS name from within your cluster:

    chatops-kubeapps.monitoring.svc.cluster.local

  To access Kubeapps from outside your K8s cluster, follow the steps below:

  1. Get the Kubeapps URL and associate Kubeapps hostname to your cluster external IP:

    export CLUSTER_IP=$(minikube ip) # On Minikube. Use: `kubectl cluster-info` on others K8s clusters
    echo "Kubeapps URL: https://kubeapps.chatops.ga/"
    echo "$CLUSTER_IP  kubeapps.chatops.ga" | sudo tee -a /etc/hosts

  2. Open a browser and access Kubeapps using the obtained URL.

  ##########################################################################################################
  ### WARNING: You did not provide a value for the postgresqlPassword so one has been generated randomly ###
  ##########################################################################################################

  ```

- 설치 결과 조회
```
azureuser@VM-Bastion:~/workspace/monitoring/kubeapps-7.1.0$ kubectl -n monitoring get pod
NAME                                                              READY   STATUS    RESTARTS   AGE
apprepo-monitoring-sync-bitnami-dr6v5-czk9h                       1/1     Running   0          3m14s
chatops-kubeapps-866c8f8967-4n4ww                                 1/1     Running   0          3m26s
chatops-kubeapps-866c8f8967-kwlrq                                 1/1     Running   0          3m26s
chatops-kubeapps-internal-apprepository-controller-8bc5c8bz9zlp   1/1     Running   0          3m26s
chatops-kubeapps-internal-assetsvc-886547cdb-k7gvm                1/1     Running   0          3m26s
chatops-kubeapps-internal-assetsvc-886547cdb-vhkbh                1/1     Running   0          3m26s
chatops-kubeapps-internal-dashboard-7c77fdfb87-4ccmc              1/1     Running   0          3m26s
chatops-kubeapps-internal-dashboard-7c77fdfb87-9g88r              1/1     Running   0          3m26s
chatops-kubeapps-internal-kubeops-cf9c8fccf-lszsp                 1/1     Running   0          3m26s
chatops-kubeapps-internal-kubeops-cf9c8fccf-mvdwc                 1/1     Running   0          3m26s
chatops-postgresql-primary-0                                      1/1     Running   0          3m26s
chatops-postgresql-read-0                                         1/1     Running   0          3m26s
azureuser@VM-Bastion:~/workspace/monitoring/kubeapps-7.1.0$ kubectl -n monitoring get svc
NAME                                  TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
chatops-kubeapps                      ClusterIP   10.0.21.164    <none>        80/TCP     3m35s
chatops-kubeapps-internal-assetsvc    ClusterIP   10.0.37.116    <none>        8080/TCP   3m35s
chatops-kubeapps-internal-dashboard   ClusterIP   10.0.77.208    <none>        8080/TCP   3m35s
chatops-kubeapps-internal-kubeops     ClusterIP   10.0.214.233   <none>        8080/TCP   3m35s
chatops-postgresql                    ClusterIP   10.0.53.45     <none>        5432/TCP   3m35s
chatops-postgresql-headless           ClusterIP   None           <none>        5432/TCP   3m35s
chatops-postgresql-read               ClusterIP   10.0.183.249   <none>        5432/TCP   3m35s
azureuser@VM-Bastion:~/workspace/monitoring/kubeapps-7.1.0$ kubectl -n monitoring get ep
NAME                                  ENDPOINTS                           AGE
chatops-kubeapps                      10.244.0.29:8080,10.244.0.30:8080   3m41s
chatops-kubeapps-internal-assetsvc    10.244.0.26:8080,10.244.0.28:8080   3m41s
chatops-kubeapps-internal-dashboard   10.244.0.32:8080,10.244.0.35:8080   3m41s
chatops-kubeapps-internal-kubeops     10.244.0.31:8080,10.244.0.33:8080   3m41s
chatops-postgresql                    10.244.0.34:5432                    3m41s
chatops-postgresql-headless           10.244.0.34:5432,10.244.0.36:5432   3m41s
chatops-postgresql-read               10.244.0.36:5432                    3m41s
azureuser@VM-Bastion:~/workspace/monitoring/kubeapps-7.1.0$ kubectl -n monitoring get ing
NAME               CLASS    HOSTS                 ADDRESS        PORTS     AGE
chatops-kubeapps   <none>   kubeapps.chatops.ga   20.41.72.147   80, 443   3m46s
azureuser@VM-Bastion:~/workspace/monitoring/kubeapps-7.1.0$ kubectl -n monitoring get secret
NAME                                                             TYPE                                  DATA   AGE
chatops-kubeapps-internal-apprepository-controller-token-95nnd   kubernetes.io/service-account-token   3      3m52s
chatops-kubeapps-internal-kubeops-token-n52wl                    kubernetes.io/service-account-token   3      3m52s
chatops-postgresql                                               Opaque                                2      3m52s
default-token-nmrkl                                              kubernetes.io/service-account-token   3      4m8s
kubeapps.chatops.ga-tls                                          kubernetes.io/tls                     2      2m44s
sh.helm.release.v1.chatops.v1                                    helm.sh/release.v1                    1      3m52s
azureuser@VM-Bastion:~/workspace/monitoring/kubeapps-7.1.0$ kubectl -n monitoring get ing
NAME               CLASS    HOSTS                 ADDRESS        PORTS     AGE
chatops-kubeapps   <none>   kubeapps.chatops.ga   20.41.72.147   80, 443   4m6s
azureuser@VM-Bastion:~/workspace/monitoring/kubeapps-7.1.0$ kubectl -n monitoring get pvc
No resources found in monitoring namespace.
```
```
kubectl cluster-info
Kubernetes control plane is running at https://aks-cluste-rg-chatops-23156b-99ebe014.hcp.koreacentral.azmk8s.io:443
addon-http-application-routing-default-http-backend is running at https://aks-cluste-rg-chatops-23156b-99ebe014.hcp.koreacentral.azmk8s.io:443/api/v1/namespaces/kube-system/services/addon-http-application-routing-default-http-backend/proxy
addon-http-application-routing-nginx-ingress is running at http://20.194.20.217:80 http://20.194.20.217:443 
healthmodel-replicaset-service is running at https://aks-cluste-rg-chatops-23156b-99ebe014.hcp.koreacentral.azmk8s.io:443/api/v1/namespaces/kube-system/services/healthmodel-replicaset-service/proxy
CoreDNS is running at https://aks-cluste-rg-chatops-23156b-99ebe014.hcp.koreacentral.azmk8s.io:443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://aks-cluste-rg-chatops-23156b-99ebe014.hcp.koreacentral.azmk8s.io:443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'
```

## kubeapps 와 kubernetes 접속을 위한 credential 만들기
```
kubectl -n kubeapps create serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator

kubectl -n kubeapps get sa
NAME                                                 SECRETS   AGE
chatops-kubeapps-internal-apprepository-controller   1         30m
chatops-kubeapps-internal-kubeops                    1         30m
default                                              1         30m
kubeapps-operator                                    1         10m

kubectl get clusterrolebinding | grep kubeapps
kubeapps-operator                                                  ClusterRole/cluster-admin                                              38s
kubeapps:controller:kubeapps:apprepositories-read                  ClusterRole/kubeapps:kubeapps:apprepositories-read                     3m9s
kubeapps:controller:kubeops-ns-discovery-kubeapps                  ClusterRole/kubeapps:controller:kubeops-ns-discovery-kubeapps          3m9s
kubeapps:controller:kubeops-operators-kubeapps                     ClusterRole/kubeapps:controller:kubeops-operators-kubeapps             3m9s
```

### token 얻기
- linux
```
kubectl -n kubeapps get secret $(kubectl -n kubeapps get serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo
```


```
kubectl -n default get serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token
kubeapps-operator-token-j5sxv
```

```
kubectl -n default get secret kubeapps-operator-token-j5sxv -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}'&& echo
eyJhbGciOiJSUzI1NiIsImtpZCI6IkcwZkZ2c3dSWmRVUWt1d2FrR1F0LU1VUUFtWVBvTE54WUVFWjBRYlhUWGsifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlYXBwcyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrdWJlYXBwcy1vcGVyYXRvci10b2tlbi1kNDR2YiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJrdWJlYXBwcy1vcGVyYXRvciIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjEzZTk1YzVlLTZkNDYtNGE2MC1iNTA4LWZjN2RkMWFkMjdlOCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlYXBwczprdWJlYXBwcy1vcGVyYXRvciJ9.lXwyGEwPvdGqPwUkzYMvB2uUuAe2aU6VFcGqIIT9kdqL3n1vPx85TsXcr8asTZpnzhWVyn1D9S4D8W7RxRZO_Cmfavtfqv5WHK-ukGXUb-0DFg1SBgrvvSf7jfNRQaan4R95S2qHlf_GPN7AgFkAqe0DL796R1ELxorULKWW3x7it7ozW2bhcBQYTOZkKOYdvxFvhD4em2G5iLj2SaCsrHhmwqt-sNLvnQpF8K8FtYKS1FOQLFjVwzA4Qh-zZuIjF3dSU0wwGvOv7qgKi6-3OSBSvFLNQM3h0vZs1xnICVaBPV1qBRE2jg-ag6nRF1jXl5wnRPQVJ42nAoXuxPCGYtJA3U4uoKi37n_1-uefTV_aK2hJiYesOWUPZBQDn3mzL9vkvTCd6Cl-OiP6FPDVBmXVA36w6X16Z3h9y_ZDm_mdTwDAiIUQT6EcKKoBpTaKSdh73ogbaxwlUIbsQcCH-hB8HhIxRbNLOnkPDkYHM_foa1ZUYIVQ5jwoELMvX_qw2K5MHnU6gQdH7J_MOXQvRA7_ndh95H5Z8Pu6OfA_tRfiO5hIZ6Vpi4g--Ze1jjn4NkliSi18SQycq8laeM-beOKgxHmHeAWfoPQawd58D-4R8J4fi4MUEZbQjat8RE_RLZRPyZk3tiPesAgS0WU8rYYbl3CHDdkEG2ULnENGp94
```

- windows
GetDashToken.cmd
```
@ECHO OFF
REM Get the Service Account
kubectl get serviceaccount kubeapps-operator -o jsonpath={.secrets[].name} > s.txt
SET /p ks=<s.txt
DEL s.txt

REM Get the Base64 encoded token
kubectl get secret %ks% -o jsonpath={.data.token} > b64.txt

REM Decode The Token
DEL token.txt
certutil -decode b64.txt token.txt
```