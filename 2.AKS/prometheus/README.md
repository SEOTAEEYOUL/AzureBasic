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

### 서비스에 수집 대상임을 적용하는 방법
서비스의 'metadata' 에 아래와 같이 'annotation' 적용
```
metadata:
  name: springmysql 
  namespace: homeeee 
  annotations:
   prometheus.io/scrape: 'true'
   prometheus.io/port: "8090"
```

### prometheus 서버 Monitoring Rule 등록
서버에 수집된 Metric 을 기반하여 Alert Rule 을 등록함
- [prometheus-server-cm.yaml](./prometheus-server-cm.yaml)

### Alert Manager Alert Channel(Slack Webhook) 등록 
Alert 이 발생했을 경우 이를 보낼 채널 설정
- [prometheus-alertmanager-cm.yaml](./prometheus-alertmanager-cm.yaml)

### 외부에 노출 하기(Ingress 만들기)  
- [prometheus-server-ing.yaml](./prometheus-server-ing.yaml)

#### http://prometheus.nodespringboot.org/
![prometheus.nodespringboot.org.png](../img/prometheus.nodespringboot.org.png)  

#### http://alert-manager.nodespringboot.org/
![alert-manager.nodespringboot.org.png](../img/alert-manager.nodespringboot.org.png)  