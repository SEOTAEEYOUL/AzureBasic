# helm 명령어

## [설치](https://helm.sh/ko/docs/intro/install/)
### Windows 
```powershell
choco install kubernetes-helm
```

## Helm Repo
### 공식 헬름 stable 차트
```
helm repo add stable https://charts.helm.sh/stable
helm repo add incubator https://charts.helm.sh/incubator
helm repo update
```

### Linux
```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
#### 최신버전
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## 사용 예
### 찾기
```bash
helm search repo stable
```

### 설치하기
```
helm repo update              # Make sure we get the latest list of charts
helm install stable/mysql --generate-name
```

```bash
988  kubectl edit ing backend-ingress
989  ls -lt
990  kubectl edit ing backend-ingress
991  kubectl get node
992  eksctl get cluster
993  ls -lt
994  docker images
995  docker images | grep flask
996  kubectl get node
997  kubectl get node -lrole=worker
998* kubectl get node -lrole=contro
999  kubectl get node -lrole=worker
1000  kubectl get ns
1001  helm repo list
1002  helm search repo prometheus
1003  helm fetch bitnami/prometheus-operator
1004  ls -l
1005  ls -lt
1006  tar -tzvf prometheus-operator-0.31.1.tgz
1007  tar -xzvf prometheus-operator-0.31.1.tgz
1008  cd pro*r
1009  ls -lt
1010  cp values.yaml custom-values.yaml
1011  vi custom-values.yaml
1012  kubectl create ns monitoring
1013  kubectl get ns
1014  helm install prometheus -f custom-values.yaml -n monitoring .
1015  ls -lt
1016  vi custom-values.yaml
1017  ls -lt
1018  helm list
1019  helm list -n montoring
1020  helm list -n monitoring
1021  kubectl get pod -n monitoring
1022  kubectl get pod,svc,ep,ing -n monitoring
1023  ls -lt
1024  vi custom-values.yaml
1025  ls -lt
1026  helm list -n monitoring
1027  helm delete prometheus -n monitoring
1028  helm list -n monitoring
1029  kubectl get pod,svc,ep,ing -n monitoring
1030  helm install prometheus -f custom-values.yaml -n monitoring .
1031  helm list -n monitoring
1032  kubectl get pod,svc,ep,ing -n monitoring
1033  vi custom-values.yaml
1034  helm delete prometheus -n monitoring
1035  helm list -n monitoring
1036  helm install prometheus -f custom-values.yaml -n monitoring .
1037  helm list -n monitoring
1038  kubectl get pod,svc,ep,ing -n monitoring
1039  history
```