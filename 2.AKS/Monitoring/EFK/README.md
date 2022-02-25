# [ElasticSearch](https://github.com/elastic/helm-charts), Fluent-Bit, Kibana

## ElasticSearch Node 의 종류
| Node | Description |  
| :--- | :--- |  
| master | 클러스터의 제어를 담당 |  
| data | 데이터를 보관하고 데이터의 CRUD, 검색, 집계 등 데이터 관련 작업을 담당 |  
| ingest | 다양한 형태의 데이터를 색인할 때 데이터의 전처리를 담당하는 용도 |  
| Coordinate | 사용자 요청을 받아 처리 |  

## Master Node
- 클러스터의 제어를 담당하는 Node
- 기본적으로 index 생성/변경/삭제 등의 역활을 담당
- 분산 코디네이터의 역활을 담당하여 클러스터 구성 Node 의 상태를 주기적으로 점검 장애를 대비함
- 장애에 대응하여 다수의 Node로 구성

## Data Node
- 클러스터의 데이터를 보관하고 데이터의 CRUD, 검색, 집계 등 데이터 관련 작업을 담당
- 내부에 색인된 데이터가 저장되며 대용량 저장소가 필수임
- CRUD 작업과 검색, 집계와 같은 리소스를 잡아먹는 역활도 수행하기 때문에 전체적인 스펙을 갖춘 서버로 운영하는 것이 좋음

## Ingest Node
- 다양한 형태의 데이터를 색인할 때 데이터의 전처리를 담당하는 Node
- 데이터를 색인하려면 Index 라는 (RDB Schema) 틀을 생성해야 한다.
- 비정형 데이터를 다루는 저장소로 볼 수 있지만 일정한 형태의 인덱스를 생성해 주어야 하며, 해당 인덱스에는 여러 포맷 변경이나 유효성 검증 같은 전처리가 필요할 때 이용

## Coordinate Node (elastic search 2.x 이전 client node)
### 특징
- elasticsearch 의 모든 노드는 기본적으로 Coordinate Node 이다.
- 모든 노드가 사용자의 요청을 받아 처리할 수 있음
- coordinate node가 없는 경우, data node가 coordinate node 역할을 수행
- es cluster에서 로드밸런서와 비슷한 역할을 수행
  - cluster 크기가 커지면 커질수록 coordinate node가 필요

### 역활
- Routing 이 안되어 있는 경우
  - 특정 데이터를 찾아야 하는 요청(request)을 받는다
  - cluster 의 모든 노드에게 해당 데이터를 가지고 있는지 질의
    - routing 이 안되어있기 때문에 어떤 노드가 해당 데이터를 가지고 있는지 알 수 없음
  - 모든 노드로부터 데이터 유무와 데이터 정보를 모아서(aggregate) 요청(request)에 응답(response)
    - 모든 노드로부터 response 를 받아야만 aggregate 수행
    - 만약 하나의 노드라도 누락된 경우, timeout
- routing 이 안되어 있는 경우
  - 특정 데이터를 찾아야 하는 요청(request)을 받는다.
    - routing 을 통해 어떤 node 가 해당 데이터를 가지고 있는지 알 수 있다.
  - 해당 노드에게만 데이터를 질의
  - 전달받은 데이터로 요청(request)에 응답(response)


### REPO 추가, 구성 변경, 설치
#### repo 추가 및 가져오기
```
helm repo add elastic https://helm.elastic.co
helm fetch elastic/elasticsearch
tar -xzvf elasticsearch-7.16.3.tgz
cd elasticsearch-7.16.3
cp values.yaml values.yaml.org
```
#### values.yaml  
ingress eanbled : true 설정
```
ingress:
  enabled: true
  annotations: {}
```
#### 설치

$ helm install elasticsearch -n monitoring -f values.yaml .
```
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-7.16.3> helm install elasticsearch -n monitoring -f values.yaml .
W0225 11:33:30.771692   23728 warnings.go:70] policy/v1beta1 PodDisruptionBudget is deprecated in v1.21+, unavailable in v1.25+; use policy/v1 PodDisruptionBudget
W0225 11:33:31.306729   23728 warnings.go:70] policy/v1beta1 PodDisruptionBudget is deprecated in v1.21+, unavailable in v1.25+; use policy/v1 PodDisruptionBudget
NAME: elasticsearch
LAST DEPLOYED: Fri Feb 25 11:33:29 2022
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
NOTES:
1. Watch all cluster members come up.
  $ kubectl get pods --namespace=monitoring -l app=elasticsearch-master -w
2. Test cluster health using Helm test.
  $ helm --namespace=monitoring test elasticsearch
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-7.16.3> 
```

#### elasticsearch 구동 확인
```
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-7.16.3> kubectl get pods --namespace=monitoring -l app=elasticsearch-master -w 
NAME                     READY   STATUS     RESTARTS   AGE
elasticsearch-master-0   0/1     Init:0/1   0          55s
elasticsearch-master-1   0/1     Pending    0          55s
elasticsearch-master-2   0/1     Pending    0          55s
elasticsearch-master-0   0/1     PodInitializing   0          2m21s
elasticsearch-master-0   0/1     Running    0          2m50s
elasticsearch-master-1   0/1     PodInitializing   0          2m58s
elasticsearch-master-1   0/1     Running           0          2m59s
elasticsearch-master-2   0/1     PodInitializing   0          3m
elasticsearch-master-2   0/1     Running           0          3m1s
elasticsearch-master-0   1/1     Running           0          3m43s
elasticsearch-master-1   1/1     Running           0          3m47s
elasticsearch-master-2   1/1     Running           0          3m58s
```

#### helm test 
```
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-7.16.3> helm --namespace=monitoring test elasticsearch
NAME: elasticsearch
LAST DEPLOYED: Fri Feb 25 11:33:29 2022
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE:     elasticsearch-eohoj-test
Last Started:   Fri Feb 25 11:41:59 2022
Last Completed: Fri Feb 25 11:42:00 2022
Phase:          Succeeded
NOTES:
1. Watch all cluster members come up.
  $ kubectl get pods --namespace=monitoring -l app=elasticsearch-master -w2. Test cluster health using Helm test.
  $ helm --namespace=monitoring test elasticsearch
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-7.16.3> 
```
```
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-7.16.3> helm -n monitoring list                       
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
elasticsearch   monitoring      1               2022-02-25 11:33:29.365198 +0900 KST    deployed        elasticsearch-7.16.3    7.16.3
grafana         monitoring      1               2022-02-24 23:35:59.9799309 +0900 KST   deployed        grafana-6.22.0          8.3.6
prometheus      monitoring      1               2022-02-24 23:47:43.4181138 +0900 KST   deployed        prometheus-15.4.0       2.31.1
```

#### 배포 자원 확인
kubectl -n monitoring get pvc,pod,svc,ep,ing -l app=elasticsearch-master  
```
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-7.16.3> kubectl -n monitoring get pvc,pod,svc,ep,ing -l app=elasticsearch-master
NAME                                                                STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/elasticsearch-master-elasticsearch-master-0   Bound    pvc-99ac268a-3e97-40d6-9cad-52d6cf6db790   30Gi       RWO            default        14m
persistentvolumeclaim/elasticsearch-master-elasticsearch-master-1   Bound    pvc-79ed0364-fab6-43e5-88cb-9ec669f38515   30Gi       RWO            default        14m
persistentvolumeclaim/elasticsearch-master-elasticsearch-master-2   Bound    pvc-e8ba9aa5-e664-4022-a2c3-e04091c16bed   30Gi       RWO            default        14m

NAME                         READY   STATUS    RESTARTS   AGE
pod/elasticsearch-master-0   1/1     Running   0          14m
pod/elasticsearch-master-1   1/1     Running   0          14m
pod/elasticsearch-master-2   1/1     Running   0          14m

NAME                                    TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)             AGE
service/elasticsearch-master            ClusterIP   10.0.21.210   <none>        9200/TCP,9300/TCP   14m
service/elasticsearch-master-headless   ClusterIP   None          <none>        9200/TCP,9300/TCP   14m

NAME                                      ENDPOINTS                                                      AGE
endpoints/elasticsearch-master            10.244.2.85:9200,10.244.3.3:9200,10.244.4.3:9200 + 3 more...   14m
endpoints/elasticsearch-master-headless   10.244.2.85:9200,10.244.3.3:9200,10.244.4.3:9200 + 3 more...   14m
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-7.16.3>
```
## bitnami/elasticsearch 17.9.3
```
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-17.9.3> helm install elasticsearch -n monitoring -f values.yaml .
NAME: elasticsearch
LAST DEPLOYED: Fri Feb 25 13:35:34 2022
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: elasticsearch
CHART VERSION: 17.9.3
APP VERSION: 7.17.0

-------------------------------------------------------------------------------
 WARNING

    Elasticsearch requires some changes in the kernel of the host machine to
    work as expected. If those values are not set in the underlying operating
    system, the ES containers fail to boot with ERROR messages.

    More information about these requirements can be found in the links below:

      https://www.elastic.co/guide/en/elasticsearch/reference/current/file-descriptors.html
      https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html

    This chart uses a privileged initContainer to change those settings in the Kernel
    by running: sysctl -w vm.max_map_count=262144 && sysctl -w fs.file-max=65536

** Please be patient while the chart is being deployed **

  Elasticsearch can be accessed within the cluster on port 9200 at elasticsearch-coordinating-only.monitoring.svc.cluster.local

  To access from outside the cluster execute the following commands:

    kubectl port-forward --namespace monitoring svc/elasticsearch-coordinating-only 9200:9200 &
    curl http://127.0.0.1:9200/
PS C:\workspace\AzureBasic\2.AKS\EFK\elasticsearch-17.9.3>
```

## kibana    
```
helm search repo kibana
helm fetch elastic/kibana
tar -xzvf kibana-7.16.3.tgz 
mv kibana kibana-7.16.3
cd kibana-7.16.3
cp values.yaml values.yaml.org
helm install kibana -n monitoring -f values.yaml .
kubectl -n monitoring get pod,svc,ep,ing  -l app=kibana
```
#### bitnami/kibana
```
PS C:\workspace\AzureBasic\2.AKS\EFK\kibana-9.3.6> helm install kibana -f values.yaml -n monitoring .
NAME: kibana
LAST DEPLOYED: Fri Feb 25 13:00:16 2022
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: kibana
CHART VERSION: 9.3.6
APP VERSION: 7.17.0

** Please be patient while the chart is being deployed **######################################################################################################
### ERROR: You did not provide the Elasticsearch external host or port in your 'helm install' call ###
######################################################################################################

Complete your Kibana deployment by running:

helm upgrade --namespace monitoring kibana bitnami/kibana \
    --set elasticsearch.hosts[0]=YOUR_ES_HOST,elasticsearch.port=YOUR_ES_PORT  

Replacing "YOUR_ES_HOST" and "YOUR_ES_PORT" placeholders by the proper values of your Elasticsearch deployment.
PS C:\workspace\AzureBasic\2.AKS\EFK\kibana-9.3.6> 
```
```
helm upgrade `
  --namespace monitoring kibana bitnami/kibana `
  --set elasticsearch.hosts[0]=elasticsearch-coordinating-only.monitoring.svc.cluster.local,elasticsearch.port=9200
```
```
PS C:\workspace\AzureBasic\2.AKS\EFK\kibana-9.3.6> helm upgrade `
>>   --namespace monitoring kibana bitnami/kibana `
>>   --set elasticsearch.hosts[0]=elasticsearch-coordinating-only.monitoring.svc.cluster.local,elasticsearch.port=9200
Release "kibana" has been upgraded. Happy Helming!
NAME: kibana
LAST DEPLOYED: Fri Feb 25 13:42:38 2022
NAMESPACE: monitoring
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
CHART NAME: kibana
CHART VERSION: 9.3.6
APP VERSION: 7.17.0

** Please be patient while the chart is being deployed **1. Get the application URL by running these commands:
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl port-forward svc/kibana 8080:5601
PS C:\workspace\AzureBasic\2.AKS\EFK\kibana-9.3.6> 
```
### values.yaml
```

ingress:
  enabled: true
  className: "nginx"
  pathtype: ImplementationSpecific
  annotations: {}
```

### 배포 로그
```
PS C:\workspace\AzureBasic\2.AKS\EFK\kibana-7.16.3> helm install kibana -n monitoring -f values.yaml .
NAME: kibana
LAST DEPLOYED: Fri Feb 25 11:55:18 2022
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
PS C:\workspace\AzureBasic\2.AKS\EFK\kibana-7.16.3> helm ls -n monitoring
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
elasticsearch   monitoring      1               2022-02-25 11:33:29.365198 +0900 KST    deployed        elasticsearch-7.16.3    7.16.3
grafana         monitoring      1               2022-02-24 23:35:59.9799309 +0900 KST   deployed        grafana-6.22.0          8.3.6
kibana          monitoring      1               2022-02-25 11:55:18.625447 +0900 KST    deployed        kibana-7.16.3           7.16.3
prometheus      monitoring      1               2022-02-24 23:47:43.4181138 +0900 KST   deployed        prometheus-15.4.0       2.31.1
PS C:\workspace\AzureBasic\2.AKS\EFK> kubectl -n monitoring get pod,svc,ep,ing  -l app=kibana
NAME                                READY   STATUS    RESTARTS   AGE
pod/kibana-kibana-fc976c796-9cdwq   1/1     Running   0          9m13s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/kibana-kibana   ClusterIP   10.0.206.233   <none>        5601/TCP   9m13s

NAME                      ENDPOINTS         AGE
endpoints/kibana-kibana   10.244.3.9:5601   9m13s

NAME                                   CLASS    HOSTS                       ADDRESS          PORTS   AGE
ingress.networking.k8s.io/kibana-ing   <none>   kibana.nodespringboot.org   20.200.227.196   80      116s
PS C:\workspace\AzureBasic\2.AKS\EFK> 
```

## Fluent-bit
### Link
> [fluentbit Kubernetes Logging](https://docs.fluentbit.io/manual/installation/kubernetes)

### Installation
```
wget https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml
wget https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role.yaml
wget https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding.yaml
```

### configmap
```
wget https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/output/elasticsearch/fluent-bit-configmap.yaml
```


### Fulent Bit to Elasticsearch
```
wget https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/output/elasticsearch/fluent-bit-ds.yaml
```

### install
- 변경사항
  - namespace : monitoring
  - fluent-bit-ds.yaml : elasticsearch -> elasticsearch-coordinating-only
  ```
  kubectl -n monitoring creat -f fluent-bit-service-account.yaml
  kubectl -n monitoring creat -f fluent-bit-role.yaml
  kubectl -n monitoring creat -f fluent-bit-role-binding.yaml
  kubectl -n monitoring creat -f fluent-bit-configmap.yaml
  kubectl -n monitoring creat -f fluent-bit-ds.yaml  
  ```

### Helm Chart 로 설치하기

#### Fluent Helm Chart repo 추가
```
helm repo add fluent https://fluent.github.io/helm-charts
```

#### 설치하기
```
helm fetch fluent/fluent-bit
tar -xzvf fluent-bit-0.15.15.tgz
cd fluent-bit
cp values.yaml values-custom.yaml
helm install fluent-bit -f values-custom.yaml -n monitoring .
```

#### Fluent Bit 구성
- Ubuntu/CentOS 기준 Docker Log 위치 : /var/lib/docker/containers/<container id>/<container id>-json.log
- ConfigMap "fluent-bit-config " 의 [INPUT] 에 기술 되어 있음(수정 불필요)  
  ```
  .
  .
  .
  input-kubernetes.conf: |
    [INPUT]
        Name              tail
        Tag               kube.*
        Path              /var/log/containers/*.log
        Parser            docker
        DB                /var/log/flb_kube.db
        Mem_Buf_Limit     5MB
        Skip_Long_Lines   On
        Refresh_Interval  10
  .
  .
  .
  ```