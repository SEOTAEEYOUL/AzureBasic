# AutoScaler 구성
Pod, Node AutoScaler 구성 및 모니터링 하기
- deployment
- Storage Class
- Prometheus/AlertManager, Grafana


## AutoScaler
### metric server

## Montoring 도구
### [Prometheus](./Prometheus.md)  
오픈소스 시스템 모니터링 및 경고 툴킷  

### [Grafana](./Grafana.md) 
시계열 데이터(Metric)에 대한 시각화 도구  

### [EFK(ElasticSearch, FluentBit, Kibana)](ElasticSearch.md)
커스텀 로깅 솔루션을 구축할 때 가장 많이 쓰이는 컴포넌트의 조합  
Pod 의 로그를 수집, 저장, 시각화(검색)  
- Fluentd : 로그 수집
- ElasticSearch : 로그 저장
- Kibana : 로그 검색 및 시각화 도구