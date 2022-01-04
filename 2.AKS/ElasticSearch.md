# ElasticSearch, Fluent-Bit, Kibana

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


### 설치
- 
```
$ helm install elasticsearch -n monitoring -f values-custom.yaml .
NAME: elasticsearch
LAST DEPLOYED: Thu Jul 15 06:28:16 2021
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
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
```
- kibana ingress 추가    

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
  $ km create -f fluent-bit-service-account.yaml
  serviceaccount/fluent-bit created
  $ km create -f fluent-bit-role.yaml
  Warning: rbac.authorization.k8s.io/v1beta1 ClusterRole is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 ClusterRole
  clusterrole.rbac.authorization.k8s.io/fluent-bit-read created
  $ km create -f fluent-bit-role-binding.yaml
  Warning: rbac.authorization.k8s.io/v1beta1 ClusterRoleBinding is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 ClusterRoleBinding
  clusterrolebinding.rbac.authorization.k8s.io/fluent-bit-read created
  $ km create -f fluent-bit-configmap.yaml
  configmap/fluent-bit-config created
  $ km create -f fluent-bit-ds.yaml
  daemonset.apps/fluent-bit created
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