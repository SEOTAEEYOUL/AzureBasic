# [Grafana](https://grafana.com/)
시계열 데이터(Metric)에 대한 시각화 도구

> [Grafana란?](https://medium.com/finda-tech/grafana%EB%9E%80-f3c7c1551c38)  
---   
### Helm Chart 가져오기
#### repo 추가 & 갱신
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

#### helm 조회 및 가져오기/Monitoring Folder 에 풀기
```
helm fetch bitnami/grafana
tar -xzvf grafana-5.2.17.tgz
mv prometheus prometheus-15.4.0
cd prometheus-15.4.0
cp values.yaml values.yaml.org
```


```
helm search repo prometheus 
helm fetch prometheus-community/prometheus

tar -xzvf prometheus-15.4.0.tgz
mv prometheus prometheus-15.4.0
cd prometheus-15.4.0
cp values.yaml values.yaml.org
```


#### values.yaml 설정
admin ip, pw 설정
```
admin:
  ## @param admin.user Grafana admin username
  ##
  user: "skccadmin"
  ## @param admin.password Admin password. If a password is not provided a random password will be generated
  ##
  password: "dlatl!00"

```

#### 설치하기
```
helm install grafana -f values-custom.yaml -n monitoring .
```

#### 설치 확인
```
kubectl get all -n monitoring -lapp.kubernetes.io/component=grafana
```

## 설정하기


