# AutoScaler 구성
Pod, Node AutoScaler 구성 및 모니터링 하기
- deployment
- Storage Class
- Prometheus/AlertManager, Grafana


## AutoScaler
### metric server
각 노드에 설치된 kubelet 을 통해서 node 및 pod 의 CPU, memory 의 사용량 metric 수집  
아래의 명령은 metric 서버가 설치되어 있어야 동작함  
- kubectl top pod  
- kubectl top node 
#### 배포 되어 있는지 확인
```
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl get pod -n kube-system
NAME                                                              READY   STATUS    RESTARTS   AGE
addon-http-application-routing-external-dns-84f4c7f8d4-55js8      1/1     Running   0          4h16m
addon-http-application-routing-nginx-ingress-controller-fc6kf9q   1/1     Running   0          4h16m
coredns-845757d86-m5xrq                                           1/1     Running   0          4h16m
coredns-845757d86-mwll4                                           1/1     Running   0          3h45m
coredns-autoscaler-5f85dc856b-f58nd                               1/1     Running   0          4h16m
csi-azuredisk-node-dx95c                                          3/3     Running   0          4h14m
csi-azurefile-node-bc6s2                                          3/3     Running   0          4h14m
kube-proxy-7qlw4                                                  1/1     Running   0          4h14m
metrics-server-774f99dbf4-zx6t9                                   1/1     Running   0          4h16m
omsagent-8xxpf                                                    2/2     Running   0          4h14m
omsagent-rs-7774d47549-s4pnn                                      1/1     Running   0          4h16m
tunnelfront-7b5f9d6dcf-bvl87                                      1/1     Running   0          3h27m
PS C:\workspace\AzureBasic\2.AKS\yaml> 
```
```
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl top node
NAME                                CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
aks-homeeee01-39011919-vmss000002   357m         9%     2882Mi          26%
PS C:\workspace\AzureBasic\2.AKS\yaml> kubectl top pod --all-namespaces
NAMESPACE         NAME                                                              CPU(cores)   MEMORY(bytes)   
calico-system     calico-kube-controllers-8cc57f447-xsn89                           5m           32Mi
calico-system     calico-node-2v2jm                                                 31m          176Mi
calico-system     calico-typha-ffcfd94f6-s8szs                                      2m           33Mi
homeeee           springmysql-5d459db9cf-f5mrk                                      2m           376Mi
ingress-basic     nginx-ingress-ingress-nginx-controller-bb88cd997-6sssd            2m           101Mi
ingress-basic     nginx-ingress-ingress-nginx-controller-bb88cd997-zvq99            2m           100Mi
kube-system       addon-http-application-routing-external-dns-84f4c7f8d4-55js8      1m           27Mi
kube-system       addon-http-application-routing-nginx-ingress-controller-fc6kf9q   3m           136Mi
kube-system       coredns-845757d86-m5xrq                                           3m           24Mi
kube-system       coredns-845757d86-mwll4                                           3m           22Mi
kube-system       coredns-autoscaler-5f85dc856b-f58nd                               1m           8Mi
kube-system       csi-azuredisk-node-dx95c                                          3m           45Mi
kube-system       csi-azurefile-node-bc6s2                                          2m           46Mi
kube-system       kube-proxy-7qlw4                                                  1m           31Mi
kube-system       metrics-server-774f99dbf4-zx6t9                                   4m           20Mi
kube-system       omsagent-8xxpf                                                    9m           398Mi
kube-system       omsagent-rs-7774d47549-s4pnn                                      14m          298Mi
kube-system       tunnelfront-7b5f9d6dcf-bvl87                                      128m         16Mi
tigera-operator   tigera-operator-6d69c69b88-9jbjb                                  4m           61Mi
PS C:\workspace\AzureBasic\2.AKS\yaml> 
```

## Montoring 도구
### [Prometheus](./prometheus/README.md)  
오픈소스 시스템 모니터링 및 경고 툴킷  

### [Grafana](./Grafana.md) 
시계열 데이터(Metric)에 대한 시각화 도구  

### [EFK(ElasticSearch, FluentBit, Kibana)](ElasticSearch.md)
커스텀 로깅 솔루션을 구축할 때 가장 많이 쓰이는 컴포넌트의 조합  
Pod 의 로그를 수집, 저장, 시각화(검색)  
- Fluentd : 로그 수집
- ElasticSearch : 로그 저장
- Kibana : 로그 검색 및 시각화 도구