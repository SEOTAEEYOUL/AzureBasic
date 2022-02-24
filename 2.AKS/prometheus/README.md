# Prometheus/AlertManager
- prometheus-community 설명이 좀더 친절  

> ## [Prometheus](https://github.com/prometheus-community/prometheus)  
> [JMX Exporter](https://github.com/prometheus/jmx_exporter)  

---   
### Helm Chart 가져오기
#### repo 추가 & 갱신
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

#### helm 조회 및 가져오기/Monitoring Folder 에 풀기
```
helm search repo prometheus 
helm fetch prometheus-community/prometheus

tar -xzvf prometheus-15.4.0.tgz
mv prometheus prometheus-15.4.0
cd prometheus-15.4.0
cp values.yaml values.yaml.org
```


#### prometheus-values.yaml 설정
```
alertmanager:
  persistentVolume:
    storageClass: "default"
server:
  persistentVolume:
    size: 2Gi
    storageClass: "default"
```
#### namespace 생성
```
kubectl create ns monitoring
```

#### 설치
```
helm install prometheus  -n monitoring -f values.yaml .
```

#### 설정 파일을 받은 후 모니터일 룰과 Alert  룰 설정
##### 설정 받기
```
kubectl -n monitoring get cm prometheus-alertmanager -o yaml > prometheus-alertmanager-cm.yaml
kubectl -n monitoring get cm prometheus-server -o yaml > prometheus-server-cm.yaml          
```
##### 설정 수정

##### 설정 적용
```
kubectl apply -f prometheus-alertmanager-cm.yaml
kubectl apply -f prometheus-server-cm.yaml
```

## Slack Incoming Webhook 설정  

### [수신 웹후크 추가하기](https://a-tcl-da.slack.com/services/2308795797558?updated=1)  
- 웹후크 URL
  ```
  https://hooks.slack.com/services/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
  ```
- 메시지 전송
  ```
  payload={"text": "채널에 있는 한 줄의 텍스트입니다.\n또 다른 한 줄의 텍스트입니다."}
  ```
- 링크 추가
  ```
  payload={"text": "매우 중요한 알림이 있습니다! 자세히 알아보려면 <https://alert-system.com/alerts/1234|여기를 클릭>하세요."}
  ```
- 사용자 지정된 모양
  -  통합 앱 설정 섹션에서 수신 웹후크의 이름 및 아이콘을 사용자 지정
  -  JSON 페이로드에서 재정의
    - 표시된 이름 : "username": "new-bot-name"
    - 봇 아이콘
      - "icon_url": "https://slack.com/img/icons/app-57.png"
      - "icon_emoji": ":ghost:"

- 채널 재정의
  -  JSON 페이로드에서 재정의할 수 있슴
    - 공개채널 : "channel": "#other-channel"
    - 다이렉트 메시지 : "channel": "@사용자 이름"

- 예
  - bash
  ```bash
  curl -X POST --data-urlencode "payload={\"channel\": \"#chatops\", \"username\": \"webhookbot\", \"text\": \"이 항목은 #개의 chatops에 포스트되며 webhookbot이라는 봇에서 제공됩니다.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
  ```

  - powershell
  ```posershell
  curl -X POST --data-urlencode "payload={'channel': '#alert', 'username': 'webhookbot', 'text': '이 항목은 #개의 chatops에 포스트되며 webhookbot이라는  봇에서 제공됩니다.', 'icon_emoji': ':ghost:'}" https://hooks.slack.com/services/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 
  ```

- [prometheus-alertmanager-cm.yaml](./prometheus-alertmanager-cm.yaml)
```
apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
    meta.helm.sh/release-name: prometheus
    meta.helm.sh/release-namespace: monitoring
  labels:
    app: prometheus
    app.kubernetes.io/managed-by: Helm
    chart: prometheus-15.4.0
    component: alertmanager
    heritage: Helm
    release: prometheus
  name: prometheus-alertmanager
  namespace: monitoring
data:
  alertmanager.yml: |
    global:
      slack_api_url: https://hooks.slack.com/services/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
    receivers:
    - name: 'slack-notifications'
      slack_configs:
      - channel: '#alert'
        username: 'SKCC'
        send_resolved: true
        icon_emoji: ":crocodile:"
        icon_url: '{{ template "slack.default.iconurl" . }}'
        title: '[{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] 모니터링 이벤트 알림'
        text: "{{ range .Alerts }} *경고:* _{{ .Labels.alertname }}_\n*심각도:* `{{ .Labels.severity }}`\n*환경:* *SKCC Alert *\n*요약:* {{ .Annotations.summary }}\n*내용:* {{ .Annotations.description }}\n{{ end }}"
    route:
      group_wait: 10s
      receiver: slack-notifications
      repeat_interval: 30s
```

- prometheus-server-cm.yaml
```
apiVersion: v1
data:
  # alerting_rules.yml: |
  #   {}
  alerting_rules.yml: |
    groups:
    - name: container memory alert
      rules:
      - alert: container memory usage rate is very high( > 55%)
        expr: sum(container_memory_working_set_bytes{pod!="", name=""})/ sum (kube_node_status_allocatable_memory_bytes) * 100 > 55
        for: 1m
        labels:
          severity: fatal
        annotations:
          description: ' Memory Usage: '
          summary: High Memory Usage on
    - name: container CPU alert
      rules:
      - alert: container CPU usage rate is very high( > 10%)
        expr: sum (rate (container_cpu_usage_seconds_total{pod!=""}[1m])) / sum (machine_cpu_cores) * 100 > 10
        for: 1m
        labels:
          severity: fatal
        annotations:
          summary: High Cpu Usage
          descritption: High Cpu Usage
    - name: Unavailable Node
      rules:
      - alert: InstanceDown
        expr: sum(kube_node_spec_unschedulable) > 0
        for: 10m
        labels:
          severity: page
        annotations:
          summary: Instance {{$labels.instance}} down
          description: '{{$labels.instance}} has been down for more than 10 minute.'
    - name: General
      rules:
      - alert: pods_terminated
        expr: sum_over_time(kube_pod_container_status_terminated_reason{reason!="Completed", reason!="OOMKilled"}[5m]) > 0
        for: 1m
        labels:
          severity: info
        annotations:
          description: '비정상 종료 Pod : {{$labels.namespace}}/{{$labels.pod}} , 사유 : {{$labels.reason}} , 인스턴스 : {{$labels.instance}} '
          summary: Pod was terminated
      - alert: pods_restarting_info
        expr: increase(kube_pod_container_status_restarts_total{pod=~"vulnerability-advisor.*"}[1h]) > 5
        for: 10m
        labels:
          severity: info
        annotations:
          # description: 'Pod {{  $labels.pod  }} in namespace {{  $labels.namespace  }} is restarting a lot'
          description: '재시작 많은 Pod : {{$labels.namespace}}/{{$labels.pod}} '
          summary: Pod restarting a lot
      - alert: pods_restarting
        expr: increase(kube_pod_container_status_restarts_total{pod!~"vulnerability-advisor.*"}[1h]) > 5
        for: 10m
        labels:
          severity: warning
        annotations:
          # description: 'Pod {{  $labels.pod  }} in namespace {{  $labels.namespace  }} is restarting a lot'
          description: '재시작 많은 Pod : {{$labels.namespace}}/{{$labels.pod}} '
          summary: Pod restarting a lot
      - alert: pod_restart
        expr: rate(kube_pod_container_status_restarts_total[1h]) * 3600 > 1
        for: 5s
        labels:
          severity: info
          action_required: "true"
        annotations:
          description: '1 시간 내에 한번 이상 재시작한 Pod : {{$labels.namespace}}/{{$labels.pod}} '
          summary: Pod restarting a lot
      - alert: monitoring_target_down
        expr: 100 * (count by(job) (up == 0) / count by(job) (up)) > 10
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: Targets are down
          description: '{{ $value }}% or more of job[*{{ $labels.job }}*] targets are down.'
      - alert: AKS-MonitoringHeartbeat
        expr: vector(1)
        labels:
          severity: none
        annotations:
          summary: Alerting Heartbeat
          description: This is a Hearbeat event meant to ensure that the entire Alerting pipeline is functional.  
  alerts: |
    {}
  prometheus.yml: |
    global:
      evaluation_interval: 1m
      scrape_interval: 1m
      scrape_timeout: 10s
    rule_files:
    - /etc/config/recording_rules.yml
    - /etc/config/alerting_rules.yml
    - /etc/config/rules
    - /etc/config/alerts
    scrape_configs:
    - job_name: prometheus
      static_configs:
      - targets:
        - localhost:9090
    - bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      job_name: kubernetes-apiservers
      kubernetes_sd_configs:
      - role: endpoints
      relabel_configs:
      - action: keep
        regex: default;kubernetes;https
        source_labels:
        - __meta_kubernetes_namespace
        - __meta_kubernetes_service_name
        - __meta_kubernetes_endpoint_port_name
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        insecure_skip_verify: true
    - bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      job_name: kubernetes-nodes
      kubernetes_sd_configs:
      - role: node
      relabel_configs:
      - action: labelmap
        regex: __meta_kubernetes_node_label_(.+)
      - replacement: kubernetes.default.svc:443
        target_label: __address__
      - regex: (.+)
        replacement: /api/v1/nodes/$1/proxy/metrics
        source_labels:
        - __meta_kubernetes_node_name
        target_label: __metrics_path__
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        insecure_skip_verify: true
    - bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      job_name: kubernetes-nodes-cadvisor
      kubernetes_sd_configs:
      - role: node
      relabel_configs:
      - action: labelmap
        regex: __meta_kubernetes_node_label_(.+)
      - replacement: kubernetes.default.svc:443
        target_label: __address__
      - regex: (.+)
        replacement: /api/v1/nodes/$1/proxy/metrics/cadvisor
        source_labels:
        - __meta_kubernetes_node_name
        target_label: __metrics_path__
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        insecure_skip_verify: true
    - job_name: kubernetes-service-endpoints
      kubernetes_sd_configs:
      - role: endpoints
      relabel_configs:
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scrape
      - action: drop
        regex: true
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scrape_slow
      - action: replace
        regex: (https?)
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scheme
        target_label: __scheme__
      - action: replace
        regex: (.+)
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_path
        target_label: __metrics_path__
      - action: replace
        regex: ([^:]+)(?::\d+)?;(\d+)
        replacement: $1:$2
        source_labels:
        - __address__
        - __meta_kubernetes_service_annotation_prometheus_io_port
        target_label: __address__
      - action: labelmap
        regex: __meta_kubernetes_service_annotation_prometheus_io_param_(.+)
        replacement: __param_$1
      - action: labelmap
        regex: __meta_kubernetes_service_label_(.+)
      - action: replace
        source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - action: replace
        source_labels:
        - __meta_kubernetes_service_name
        target_label: service
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_node_name
        target_label: node
    - job_name: kubernetes-service-endpoints-slow
      kubernetes_sd_configs:
      - role: endpoints
      relabel_configs:
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scrape_slow
      - action: replace
        regex: (https?)
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_scheme
        target_label: __scheme__
      - action: replace
        regex: (.+)
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_path
        target_label: __metrics_path__
      - action: replace
        regex: ([^:]+)(?::\d+)?;(\d+)
        replacement: $1:$2
        source_labels:
        - __address__
        - __meta_kubernetes_service_annotation_prometheus_io_port
        target_label: __address__
      - action: labelmap
        regex: __meta_kubernetes_service_annotation_prometheus_io_param_(.+)
        replacement: __param_$1
      - action: labelmap
        regex: __meta_kubernetes_service_label_(.+)
      - action: replace
        source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - action: replace
        source_labels:
        - __meta_kubernetes_service_name
        target_label: service
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_node_name
        target_label: node
      scrape_interval: 5m
      scrape_timeout: 30s
    - honor_labels: true
      job_name: prometheus-pushgateway
      kubernetes_sd_configs:
      - role: service
      relabel_configs:
      - action: keep
        regex: pushgateway
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_probe
    - job_name: kubernetes-services
      kubernetes_sd_configs:
      - role: service
      metrics_path: /probe
      params:
        module:
        - http_2xx
      relabel_configs:
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_service_annotation_prometheus_io_probe
      - source_labels:
        - __address__
        target_label: __param_target
      - replacement: blackbox
        target_label: __address__
      - source_labels:
        - __param_target
        target_label: instance
      - action: labelmap
        regex: __meta_kubernetes_service_label_(.+)
      - source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - source_labels:
        - __meta_kubernetes_service_name
        target_label: service
    - job_name: kubernetes-pods
      kubernetes_sd_configs:
      - role: pod
      relabel_configs:
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scrape
      - action: drop
        regex: true
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scrape_slow
      - action: replace
        regex: (https?)
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scheme
        target_label: __scheme__
      - action: replace
        regex: (.+)
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_path
        target_label: __metrics_path__
      - action: replace
        regex: ([^:]+)(?::\d+)?;(\d+)
        replacement: $1:$2
        source_labels:
        - __address__
        - __meta_kubernetes_pod_annotation_prometheus_io_port
        target_label: __address__
      - action: labelmap
        regex: __meta_kubernetes_pod_annotation_prometheus_io_param_(.+)
        replacement: __param_$1
      - action: labelmap
        regex: __meta_kubernetes_pod_label_(.+)
      - action: replace
        source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_name
        target_label: pod
      - action: drop
        regex: Pending|Succeeded|Failed|Completed
        source_labels:
        - __meta_kubernetes_pod_phase
    - job_name: kubernetes-pods-slow
      kubernetes_sd_configs:
      - role: pod
      relabel_configs:
      - action: keep
        regex: true
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scrape_slow
      - action: replace
        regex: (https?)
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_scheme
        target_label: __scheme__
      - action: replace
        regex: (.+)
        source_labels:
        - __meta_kubernetes_pod_annotation_prometheus_io_path
        target_label: __metrics_path__
      - action: replace
        regex: ([^:]+)(?::\d+)?;(\d+)
        replacement: $1:$2
        source_labels:
        - __address__
        - __meta_kubernetes_pod_annotation_prometheus_io_port
        target_label: __address__
      - action: labelmap
        regex: __meta_kubernetes_pod_annotation_prometheus_io_param_(.+)
        replacement: __param_$1
      - action: labelmap
        regex: __meta_kubernetes_pod_label_(.+)
      - action: replace
        source_labels:
        - __meta_kubernetes_namespace
        target_label: namespace
      - action: replace
        source_labels:
        - __meta_kubernetes_pod_name
        target_label: pod
      - action: drop
        regex: Pending|Succeeded|Failed|Completed
        source_labels:
        - __meta_kubernetes_pod_phase
      scrape_interval: 5m
      scrape_timeout: 30s
    alerting:
      alertmanagers:
      - kubernetes_sd_configs:
          - role: pod
        tls_config:
          ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
        relabel_configs:
        - source_labels: [__meta_kubernetes_namespace]
          regex: monitoring
          action: keep
        - source_labels: [__meta_kubernetes_pod_label_app]
          regex: prometheus
          action: keep
        - source_labels: [__meta_kubernetes_pod_label_component]
          regex: alertmanager
          action: keep
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_probe]
          regex: .*
          action: keep
        - source_labels: [__meta_kubernetes_pod_container_port_number]
          regex: "9093"
          action: keep
  recording_rules.yml: |
    {}
  rules: |
    {}
kind: ConfigMap
metadata:
  annotations:
    meta.helm.sh/release-name: prometheus
    meta.helm.sh/release-namespace: monitoring
  labels:
    app: prometheus
    app.kubernetes.io/managed-by: Helm
    chart: prometheus-15.4.0
    component: server
    heritage: Helm
    release: prometheus
  name: prometheus-server
  namespace: monitoring
```

### 외부에 노출 하기 (Ingress 만들기)  
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /$1
  name: prometheus-ing
  namespace: monitoring
spec:
  rules:
  - host: prometheus.nodespringboot.org
    http:
      paths:
      - path: /prometheus-server(/|$)(.*)
        pathType: Prefix
        backend:
          service:
            name: prometheus-server 
            port:
              number: 80               # 포트를 맞춤 (이름 혹은 숫자)
      - path: /(.*)
        pathType: Prefix
        backend:
          service:
            name: prometheus-server 
            port:
              number: 80
  - host: alert-manager.nodespringboot.org
    http:
      paths:
      - path: /prometheus-alertmanager(/|$)(.*)
        pathType: Prefix
        backend:
          service:
            name: prometheus-alertmanager 
            port:
              number: 80               # 포트를 맞춤 (이름 혹은 숫자)
      - path: /(.*)
        pathType: Prefix
        backend:
          service:
            name: prometheus-alertmanager 
            port:
              number: 80
```

### http://prometheus.nodespringboot.org/
![prometheus.nodespringboot.org.png](./img/prometheus.nodespringboot.org.png)  

### http://alert-manager.nodespringboot.org/
![alert-manager.nodespringboot.org.png](./img/alert-manager.nodespringboot.org.png)  