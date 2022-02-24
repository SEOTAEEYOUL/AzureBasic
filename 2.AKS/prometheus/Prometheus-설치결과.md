
```
PS C:\workspace\AzureBasic\2.AKS\prometheus> helm fetch prometheus-community/kube-prometheus-stack
PS C:\workspace\AzureBasic\2.AKS\prometheus> dir

    Directory: C:\workspace\AzureBasic\2.AKS\prometheus

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----        2022-02-24  오후 7:58                kube-prometheus-stack
-a---        2022-02-24  오후 7:55          11156 get_helm.sh
-a---        2022-02-24  오후 7:58         371737 kube-prometheus-stack-32.2.1.tgz

PS C:\workspace\AzureBasic\2.AKS\prometheus> tar  
tar.exe: Must specify one of -c, -r, -t, -u, -x
PS C:\workspace\AzureBasic\2.AKS\prometheus> tar -xzvf prometheus-15.4.0.tgz
x prometheus/Chart.yaml
x prometheus/Chart.lock
x prometheus/values.yaml
x prometheus/templates/NOTES.txt
x prometheus/templates/_helpers.tpl
x prometheus/templates/alertmanager/clusterrole.yaml
x prometheus/templates/alertmanager/clusterrolebinding.yaml
x prometheus/templates/alertmanager/cm.yaml
x prometheus/templates/alertmanager/deploy.yaml
x prometheus/templates/alertmanager/headless-svc.yaml
x prometheus/templates/alertmanager/ingress.yaml
x prometheus/templates/alertmanager/netpol.yaml
x prometheus/templates/alertmanager/pdb.yaml
x prometheus/templates/alertmanager/psp.yaml
x prometheus/templates/alertmanager/pvc.yaml
x prometheus/templates/alertmanager/role.yaml
x prometheus/templates/alertmanager/rolebinding.yaml
x prometheus/templates/alertmanager/service.yaml
x prometheus/templates/alertmanager/serviceaccount.yaml
x prometheus/templates/alertmanager/sts.yaml
x prometheus/templates/node-exporter/daemonset.yaml
x prometheus/templates/node-exporter/psp.yaml
x prometheus/templates/node-exporter/role.yaml
x prometheus/templates/node-exporter/rolebinding.yaml
x prometheus/templates/node-exporter/serviceaccount.yaml
x prometheus/templates/node-exporter/svc.yaml
x prometheus/templates/pushgateway/clusterrole.yaml
x prometheus/templates/pushgateway/clusterrolebinding.yaml
x prometheus/templates/pushgateway/deploy.yaml
x prometheus/templates/pushgateway/ingress.yaml
x prometheus/templates/pushgateway/netpol.yaml
x prometheus/templates/pushgateway/pdb.yaml
x prometheus/templates/pushgateway/psp.yaml
x prometheus/templates/pushgateway/pvc.yaml
x prometheus/templates/pushgateway/service.yaml
x prometheus/templates/pushgateway/serviceaccount.yaml
x prometheus/templates/pushgateway/vpa.yaml
x prometheus/templates/server/clusterrole.yaml
x prometheus/templates/server/clusterrolebinding.yaml
x prometheus/templates/server/cm.yaml
x prometheus/templates/server/deploy.yaml
x prometheus/templates/server/headless-svc.yaml
x prometheus/templates/server/ingress.yaml
x prometheus/templates/server/netpol.yaml
x prometheus/templates/server/pdb.yaml
x prometheus/templates/server/psp.yaml
x prometheus/templates/server/pvc.yaml
x prometheus/templates/server/rolebinding.yaml
x prometheus/templates/server/service.yaml
x prometheus/templates/server/serviceaccount.yaml
x prometheus/templates/server/sts.yaml
x prometheus/templates/server/vpa.yaml
x prometheus/.helmignore
x prometheus/README.md
x prometheus/charts/kube-state-metrics/Chart.yaml
x prometheus/charts/kube-state-metrics/values.yaml
x prometheus/charts/kube-state-metrics/templates/NOTES.txt
x prometheus/charts/kube-state-metrics/templates/_helpers.tpl
x prometheus/charts/kube-state-metrics/templates/clusterrolebinding.yaml
x prometheus/charts/kube-state-metrics/templates/deployment.yaml
x prometheus/charts/kube-state-metrics/templates/kubeconfig-secret.yaml
x prometheus/charts/kube-state-metrics/templates/pdb.yaml
x prometheus/charts/kube-state-metrics/templates/podsecuritypolicy.yaml
x prometheus/charts/kube-state-metrics/templates/psp-clusterrole.yaml
x prometheus/charts/kube-state-metrics/templates/psp-clusterrolebinding.yaml
x prometheus/charts/kube-state-metrics/templates/role.yaml
x prometheus/charts/kube-state-metrics/templates/rolebinding.yaml
x prometheus/charts/kube-state-metrics/templates/service.yaml
x prometheus/charts/kube-state-metrics/templates/serviceaccount.yaml
x prometheus/charts/kube-state-metrics/templates/servicemonitor.yaml
x prometheus/charts/kube-state-metrics/templates/stsdiscovery-role.yaml
x prometheus/charts/kube-state-metrics/templates/stsdiscovery-rolebinding.yaml
x prometheus/charts/kube-state-metrics/.helmignore
x prometheus/charts/kube-state-metrics/README.mdPS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl get node
NAME                                STATUS   ROLES   AGE     VERSION
aks-homeeee01-39011919-vmss000002   Ready    agent   4h25m   v1.21.9
PS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl create ns monitoring
namespace/monitoring created
PS C:\workspace\AzureBasic\2.AKS\prometheus>
```

```
PS C:\workspace\AzureBasic\2.AKS\prometheus\prometheus-15.4.0> helm uninstall prometheus -n monitoring 
release "prometheus" uninstalled
PS C:\workspace\AzureBasic\2.AKS\prometheus\prometheus-15.4.0> helm install prometheus  -n monitoring -f values.yaml .
NAME: prometheus
LAST DEPLOYED: Thu Feb 24 20:41:00 2022
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-server.monitoring.svc.cluster.local


Get the Prometheus server URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace monitoring port-forward $POD_NAME 9090


The Prometheus alertmanager can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-alertmanager.monitoring.svc.cluster.local


Get the Alertmanager URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=alertmanager" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace monitoring port-forward $POD_NAME 9093
#################################################################################
######   WARNING: Pod Security Policy has been moved to a global property.  #####
######            use .Values.podSecurityPolicy.enabled with pod-based      #####
######            annotations                                               #####
######            (e.g. .Values.nodeExporter.podSecurityPolicy.annotations) #####
#################################################################################


The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
prometheus-pushgateway.monitoring.svc.cluster.local


Get the PushGateway URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace monitoring port-forward $POD_NAME 9091

For more information on running Prometheus, visit:
https://prometheus.io/
PS C:\workspace\AzureBasic\2.AKS\prometheus\prometheus-15.4.0> kubectl get pod,pvc,svc,ep -n monitoring
NAME                                                 READY   STATUS    RESTARTS   AGE
pod/prometheus-alertmanager-f68df6679-7nxmq          1/2     Running   0          37s
pod/prometheus-kube-state-metrics-6c44ff7fb6-hbmlg   1/1     Running   0          37s
pod/prometheus-node-exporter-pvcqs                   1/1     Running   0          37s
pod/prometheus-pushgateway-8b677dc7c-qj54r           1/1     Running   0          37s
pod/prometheus-server-5f54d5759-w4dsm                1/2     Running   0          37s

NAME                                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/prometheus-alertmanager   Bound    pvc-ae66ff4b-77b2-4ee7-ad16-ed50dd2a17fa   2Gi        RWO            default        38s
persistentvolumeclaim/prometheus-pushgateway    Bound    pvc-70ae0ef8-f196-4d6d-a714-f6bda41c9b86   2Gi        RWO            default        38s
persistentvolumeclaim/prometheus-server         Bound    pvc-2b36e0df-046d-4162-b0a8-762d27d6183b   8Gi        RWO            default        38s

NAME                                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/prometheus-alertmanager         ClusterIP   10.0.21.232    <none>        80/TCP     37s
service/prometheus-kube-state-metrics   ClusterIP   10.0.167.67    <none>        8080/TCP   37s
service/prometheus-node-exporter        ClusterIP   None           <none>        9100/TCP   37s
service/prometheus-pushgateway          ClusterIP   10.0.225.250   <none>        9091/TCP   37s
service/prometheus-server               ClusterIP   10.0.114.170   <none>        80/TCP     37s

NAME                                      ENDPOINTS          AGE
endpoints/prometheus-alertmanager                            37s
endpoints/prometheus-kube-state-metrics   10.244.2.21:8080   37s
endpoints/prometheus-node-exporter        10.240.0.6:9100    37s
endpoints/prometheus-pushgateway          10.244.2.24:9091   37s
endpoints/prometheus-server                                  37s
PS C:\workspace\AzureBasic\2.AKS\prometheus\prometheus-15.4.0> 
PS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl -n monitoring get cm prometheus-alertmanager -o yaml > prometheus-alertmanager-cm.yaml
PS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl -n monitoring get cm prometheus-server -o yaml > prometheus-server-cm.yaml          
```

```
PS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl apply -f prometheus-alertmanager-cm.yaml
Warning: resource configmaps/prometheus-alertmanager is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
configmap/prometheus-alertmanager configured
PS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl apply -f prometheus-alertmanager-cm.yaml
configmap/prometheus-alertmanager unchanged
PS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl apply -f prometheus-server-cm.yaml      
Warning: resource configmaps/prometheus-server is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
configmap/prometheus-server configured
PS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl apply -f prometheus-server-cm.yaml
configmap/prometheus-server unchanged
PS C:\workspace\AzureBasic\2.AKS\prometheus> kubectl -n monitoring logs -f prometheus-alertmanager-f68df6679-2wg7w -c prometheus-alertmanager                
level=info ts=2022-02-24T12:56:31.583Z caller=main.go:225 msg="Starting Alertmanager" version="(version=0.23.0, branch=HEAD, revision=61046b17771a57cfd4c4a51be370ab930a4d7d54)"
level=info ts=2022-02-24T12:56:31.583Z caller=main.go:226 build_context="(go=go1.16.7, user=root@e21a959be8d2, date=20210825-10:48:55)"
level=info ts=2022-02-24T12:56:31.619Z caller=coordinator.go:113 component=configuration msg="Loading configuration file" file=/etc/config/alertmanager.yml
level=info ts=2022-02-24T12:56:31.619Z caller=coordinator.go:126 component=configuration msg="Completed loading of configuration file" file=/etc/config/alertmanager.yml
level=info ts=2022-02-24T12:56:31.621Z caller=main.go:518 msg=Listening address=:9093
level=info ts=2022-02-24T12:56:31.622Z caller=tls_config.go:191 msg="TLS is disabled." http2=false
```