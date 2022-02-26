# Jenkins

## 설치 명령어
```
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm search repo jenkins
helm fetch jenkins/jenkins
tar -xzvf jenkins-3.11.4.tgz
mv jenkins jenkins-3.11.4
cd jenkins-3.11.4
cp values.yaml values.yaml.org
helm install jenkins -n cicd -f values.yaml .
```
```
helm show values jenkins/jenkins > values.yaml
helm install jenkins -n cicd -f values.yaml .
```

## 설치 로그
### jenkins 검색
```
helm search repo jenkins
NAME            CHART VERSION   APP VERSION     DESCRIPTION
bitnami/jenkins 8.0.5           2.289.2         The leading open source automation server
jenkins/jenkins 3.5.8           2.289.2         Jenkins - Build great things at any scale! The ...
stable/jenkins  2.5.4           lts             DEPRECATED - Open source continuous integration...
```

### jenkins option (values.yaml)
```
.
.
.
controller:
  .
  .
  .
  adminUser: "skccadmin"
  adminPassword: "dlatl!00"
  admin:
    existingSecret: ""
    userKey: jenkins-admin-user
    passwordKey: jenkins-admin-password
.
.
.
```


### helm 설치 로그
- helm install jenkins -n cicd -f values.yaml .
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\jenkins\jenkins-3.11.4> helm install jenkins -n cicd -f values.yaml .
NAME: jenkins
LAST DEPLOYED: Sat Feb 26 16:49:27 2022
NAMESPACE: cicd
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:
  kubectl exec --namespace cicd -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  echo http://127.0.0.1:8080
  kubectl --namespace cicd port-forward svc/jenkins 8080:8080

3. Login with the password from step 1 and the username: admin
4. Configure security realm and authorization strategy
5. Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file, see documentation: http:///configuration-as-code and examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos

For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine

For more information about Jenkins Configuration as Code, visit:
https://jenkins.io/projects/jcasc/


NOTE: Consider using a custom image with pre-installed plugins
PS C:\workspace\AzureBasic\2.AKS\GitOps\jenkins\jenkins-3.11.4> 
```

### ingress 생성

### 배포 확인
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\jenkins> kubectl -n cicd get pvc,pod,svc,ep -l app.kubernetes.io/name=jenkins
NAME                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/jenkins   Bound    pvc-768ced20-b12b-4e1c-a8d8-fcec38940485   8Gi        RWO            default        5m23s

NAME            READY   STATUS    RESTARTS   AGE
pod/jenkins-0   2/2     Running   0          5m23s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)     AGE
service/jenkins         ClusterIP   10.0.102.182   <none>        8080/TCP    5m23s
service/jenkins-agent   ClusterIP   10.0.71.202    <none>        50000/TCP   5m23s

NAME                      ENDPOINTS            AGE
endpoints/jenkins         10.244.3.112:8080    5m23s
endpoints/jenkins-agent   10.244.3.112:50000   5m23s
PS C:\workspace\AzureBasic\2.AKS\GitOps\jenkins> kubectl -n cicd get pvc,pod,svc,ep,ing -l app.kubernetes.io/name=jenkins
NAME                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/jenkins   Bound    pvc-768ced20-b12b-4e1c-a8d8-fcec38940485   8Gi        RWO            default        5m30s

NAME            READY   STATUS    RESTARTS   AGE
pod/jenkins-0   2/2     Running   0          5m30s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)     AGE
service/jenkins         ClusterIP   10.0.102.182   <none>        8080/TCP    5m30s
service/jenkins-agent   ClusterIP   10.0.71.202    <none>        50000/TCP   5m30s

NAME                      ENDPOINTS            AGE
endpoints/jenkins         10.244.3.112:8080    5m30s
endpoints/jenkins-agent   10.244.3.112:50000   5m30s

NAME                                    CLASS    HOSTS                        ADDRESS   PORTS   AGE
ingress.networking.k8s.io/jenkins-ing   <none>   jenkins.nodespringboot.org             80      21s
PS C:\workspace\AzureBasic\2.AKS\GitOps\jenkins> 
```

## Plug-In 설치 항목
### **"Jenkins 관리 > 플러그인 관리"** 에서 설치  
| ID | Plugin 명 | Plugin Version | 기본 설치 여부 |  
| :--- | :--- | :--- |:---|  
| kubernetes | kubernetes | 3538.v6b_005a_ddced1 | ○ |   
| Pipeline:job | workflow-job | 1167.v8fe861b_09ef9  | ○ |     
| Pipeline | workflow-aggregator | 2.6 | ○ |      
| Credentials Binding | credentials-binding | 1.27.1 | ○ |     
| git | git | 4.10.3 | ○ |      
| gitea | gitea | 1.41 | |   
| Configuration as Code | configuration-as-code | 1413.vb_1b_8cb_c67a_f4 | ○ |        
| Keycloak Authentication | keycloak | 2.3.0 | |     
| Slack Notification | slack | 602.v0da_f7458945d | |  
| Docker | docker-plugin | 1.2.6 | |
| docker-build-step | docker-build-step | 2.8 | |  
| Prometheus metrics | prometheus | 2.0.10 | |    
  

- Jenkins 관리 > 플러그인 관리 > 위의 Plug-in 검색   
  https://plugins.jenkins.io/${plugin-item}/

## troubleshooting
### 오류
```
$ kc get pods
NAME                                                             READY   STATUS    RESTARTS   AGE
jenkins-0                                                        2/2     Running   0          2m49s
jenkins-slave-44ed87b6-18b2-46de-906a-0363a90b2754-w6jxx-230wg   2/3     Error     0          9s

$ kc logs -f jenkins-slave-44ed87b6-18b2-46de-906a-0363a90b2754-w6jxx-230wg -c jnlp
Aug 02, 2021 2:26:30 PM hudson.remoting.jnlp.Main createEngine
INFO: Setting up agent: jenkins-slave-44ed87b6-18b2-46de-906a-0363a90b2754-w6jxx-230wg
Aug 02, 2021 2:26:30 PM hudson.remoting.jnlp.Main$CuiListener <init>
INFO: Jenkins agent is running in headless mode.
Aug 02, 2021 2:26:30 PM hudson.remoting.Engine startEngine
INFO: Using Remoting version: 4.3
Exception in thread "main" java.io.IOException: The specified working directory should be fully accessible to the remoting executable (RWX):  /home/jenkins/agent
        at org.jenkinsci.remoting.engine.WorkDirManager.verifyDirectory(WorkDirManager.java:249)
        at org.jenkinsci.remoting.engine.WorkDirManager.initializeWorkDir(WorkDirManager.java:201)
        at hudson.remoting.Engine.startEngine(Engine.java:288)
        at hudson.remoting.Engine.startEngine(Engine.java:264)
        at hudson.remoting.jnlp.Main.main(Main.java:284)
        at hudson.remoting.jnlp.Main._main(Main.java:279)
        at hudson.remoting.jnlp.Main.main(Main.java:231)
[da-user@ip-10-0-1-117 jenkins-3.5.9]$
```
- READWRITEMANY 가 되는 EFS Storage Class 로 변경하여 재배함
- 아래은 Jenkins Pipeline 수행 로그
```
Started by an SCM change
Obtained Jenkinsfile from git http://gitea.a-tcl-da.net/daadmin/nodejs-bot.git
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] podTemplate
[Pipeline] {
[Pipeline] node
Created Pod: kubernetes cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Scheduled] Successfully assigned cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk to ip-192-168-188-37.ap-northeast-2.compute.internal
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Pulled] Container image "iankoulski/tree" already present on machine
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Created] Created container tree
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Started] Started container tree
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Pulled] Container image "jpetazzo/dind" already present on machine
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Created] Created container docker
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Started] Started container docker
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Pulled] Container image "jenkins/inbound-agent:4.3-4" already present on machine
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Created] Created container jnlp
[Normal][cicd/jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk][Started] Started container jnlp
Still waiting to schedule task
‘jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk’ is offline
Agent jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk is provisioned from template jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z
---
apiVersion: "v1"
kind: "Pod"
metadata:
  annotations:
    buildUrl: "http://jenkins.cicd.svc.cluster.local:8080/job/nodejs-bot/2/"
    runUrl: "job/nodejs-bot/2/"
  labels:
    jenkins/jenkins-jenkins-agent: "true"
    jenkins/label-digest: "f5e1c54f245b275a009ea0238821db725240c7f5"
    jenkins/label: "jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286"
  name: "jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk"
spec:
  containers:
  - command:
    - "cat"
    image: "iankoulski/tree"
    imagePullPolicy: "IfNotPresent"
    name: "tree"
    resources:
      limits: {}
      requests: {}
    tty: true
    volumeMounts:
    - mountPath: "/home/jenkins/agent"
      name: "workspace-volume"
      readOnly: false
  - command:
    - "dockerd"
    - "--host=unix:///var/run/docker.sock"
    image: "jpetazzo/dind"
    imagePullPolicy: "IfNotPresent"
    name: "docker"
    resources:
      limits: {}
      requests: {}
    securityContext:
      privileged: true
    tty: true
    volumeMounts:
    - mountPath: "/home/jenkins/agent"
      name: "workspace-volume"
      readOnly: false
  - env:
    - name: "JENKINS_SECRET"
      value: "********"
    - name: "JENKINS_TUNNEL"
      value: "jenkins-agent.cicd.svc.cluster.local:50000"
    - name: "JENKINS_AGENT_NAME"
      value: "jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk"
    - name: "JENKINS_NAME"
      value: "jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk"
    - name: "JENKINS_AGENT_WORKDIR"
      value: "/home/jenkins/agent"
    - name: "JENKINS_URL"
      value: "http://jenkins.cicd.svc.cluster.local:8080/"
    image: "jenkins/inbound-agent:4.3-4"
    name: "jnlp"
    resources:
      limits: {}
      requests:
        memory: "256Mi"
        cpu: "100m"
    volumeMounts:
    - mountPath: "/home/jenkins/agent"
      name: "workspace-volume"
      readOnly: false
  nodeSelector:
    kubernetes.io/os: "linux"
  restartPolicy: "Never"
  serviceAccountName: "jenkins"
  volumes:
  - name: "workspace-volume"
    persistentVolumeClaim:
      claimName: "cicd-workspace"
      readOnly: false

Running on jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk in /home/jenkins/agent/workspace/nodejs-bot
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Preparation)
[Pipeline] echo
Current workspace : /home/jenkins/agent/workspace/nodejs-bot
[Pipeline] slackSend
Slack Send Pipeline step running, values are - baseUrl: <empty>, teamDomain: a-tcl-da, channel: alert, color: #0000FF, botUser: false, tokenCredentialId: Slack, notifyCommitters: false, iconEmoji: <empty>, username: Jenkins, timestamp: <empty>
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] sh
+ rm -f /home/jenkins/agent/workspace/nodejs-bot/.git/index.lock
[Pipeline] checkout
The recommended git tool is: NONE
using credential Gitea
Fetching changes from the remote Git repository
Checking out Revision 89d018a9febf93f1f4e8969c360a1d407a6d4989 (refs/remotes/origin/master)
 > git rev-parse --resolve-git-dir /home/jenkins/agent/workspace/nodejs-bot/.git # timeout=10
 > git config remote.origin.url http://gitea.a-tcl-da.net/daadmin/nodejs-bot.git # timeout=10
Fetching upstream changes from http://gitea.a-tcl-da.net/daadmin/nodejs-bot.git
 > git --version # timeout=10
 > git --version # 'git version 2.20.1'
using GIT_ASKPASS to set credentials 
 > git fetch --tags --force --progress -- http://gitea.a-tcl-da.net/daadmin/nodejs-bot.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 89d018a9febf93f1f4e8969c360a1d407a6d4989 # timeout=10
Commit message: "tree 수정"
 > git rev-list --no-walk 80a1f23c5c657d8a05eb8f7544587cc1a155439f # timeout=10
[Pipeline] slackSend
Slack Send Pipeline step running, values are - baseUrl: <empty>, teamDomain: a-tcl-da, channel: alert, color: #0000FF, botUser: false, tokenCredentialId: Slack, notifyCommitters: false, iconEmoji: <empty>, username: Jenkins, timestamp: <empty>
[Pipeline] container
[Pipeline] {
[Pipeline] sh
+ env
JENKINS_HOME=/var/jenkins_home
HARBOR_JOBSERVICE_PORT_8001_TCP_ADDR=10.100.0.62
ARGOCD_SERVER_METRICS_SERVICE_HOST=10.100.186.217
KUBERNETES_PORT=tcp://10.100.0.1:443
ARGOCD_SERVER_SERVICE_PORT=80
ARGOCD_APPLICATION_CONTROLLER_SERVICE_HOST=10.100.106.227
HARBOR_REGISTRY_PORT_5000_TCP_PORT=5000
HARBOR_CORE_PORT_80_TCP_PORT=80
KUBERNETES_SERVICE_PORT=443
HARBOR_CHARTMUSEUM_PORT_80_TCP_ADDR=10.100.178.74
ARGOCD_SERVER_PORT=tcp://10.100.3.46:80
HARBOR_NOTARY_SERVER_PORT_4443_TCP=tcp://10.100.187.15:4443
HARBOR_REGISTRY_PORT_5000_TCP_PROTO=tcp
HARBOR_REGISTRY_PORT_8001_TCP_ADDR=10.100.80.27
GITEA_MARIADB_PORT_3306_TCP_ADDR=10.100.136.161
HARBOR_CORE_PORT_80_TCP_PROTO=tcp
ARGOCD_DEX_SERVER_SERVICE_HOST=10.100.200.242
HARBOR_EXPORTER_PORT_8001_TCP_ADDR=10.100.197.58
CI=true
GITEA_SSH_PORT_22_TCP=tcp://10.100.4.242:22
ARGOCD_SERVER_METRICS_PORT_8083_TCP_ADDR=10.100.186.217
ARGOCD_APPLICATION_CONTROLLER_PORT_8082_TCP_ADDR=10.100.106.227
HARBOR_JOBSERVICE_PORT_8001_TCP_PORT=8001
ARGOCD_REPO_SERVER_SERVICE_PORT_HTTPS_REPO_SERVER=8081
RUN_CHANGES_DISPLAY_URL=http://jenkins:8080/job/nodejs-bot/2/display/redirect?page=changes
HARBOR_CHARTMUSEUM_PORT_80_TCP_PORT=80
CM_ACME_HTTP_SOLVER_G2GTN_SERVICE_HOST=10.100.192.231
HARBOR_NOTARY_SIGNER_PORT_7899_TCP=tcp://10.100.199.220:7899
HARBOR_JOBSERVICE_PORT_8001_TCP_PROTO=tcp
HOSTNAME=jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk
NODE_LABELS=jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286 jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk
HUDSON_URL=http://jenkins:8080/
SHLVL=3
GITEA_MARIADB_PORT_3306_TCP_PORT=3306
HARBOR_REGISTRY_PORT_8001_TCP_PORT=8001
HARBOR_CHARTMUSEUM_PORT_80_TCP_PROTO=tcp
HARBOR_PORTAL_SERVICE_PORT=80
HARBOR_EXPORTER_PORT_8001_TCP_PORT=8001
HARBOR_PORTAL_PORT=tcp://10.100.166.174:80
OLDPWD=/
HOME=/root
HARBOR_REGISTRY_PORT_8001_TCP_PROTO=tcp
CM_ACME_HTTP_SOLVER_2M25B_PORT_8089_TCP=tcp://10.100.23.213:8089
GITEA_MARIADB_PORT_3306_TCP_PROTO=tcp
GITEA_MARIADB_SERVICE_HOST=10.100.136.161
HARBOR_EXPORTER_PORT_8001_TCP_PROTO=tcp
HARBOR_JOBSERVICE_SERVICE_PORT_HTTP_METRICS=8001
ARGOCD_APPLICATION_CONTROLLER_PORT_8082_TCP_PORT=8082
ARGOCD_SERVER_METRICS_PORT_8083_TCP_PORT=8083
HARBOR_REDIS_PORT_6379_TCP=tcp://10.100.212.106:6379
BUILD_URL=http://jenkins:8080/job/nodejs-bot/2/
ARGOCD_APPLICATION_CONTROLLER_PORT_8082_TCP_PROTO=tcp
HARBOR_JOBSERVICE_SERVICE_HOST=10.100.0.62
ARGOCD_APPLICATION_CONTROLLER_METRICS_SERVICE_HOST=10.100.61.120
ARGOCD_SERVER_METRICS_PORT=tcp://10.100.186.217:8083
GITEA_MARIADB_SERVICE_PORT_MYSQL=3306
ARGOCD_SERVER_PORT_80_TCP_ADDR=10.100.3.46
ARGOCD_SERVER_METRICS_PORT_8083_TCP_PROTO=tcp
ARGOCD_DEX_SERVER_PORT_5556_TCP_ADDR=10.100.200.242
ARGOCD_SERVER_METRICS_SERVICE_PORT=8083
ARGOCD_APPLICATION_CONTROLLER_PORT=tcp://10.100.106.227:8082
ARGOCD_APPLICATION_CONTROLLER_SERVICE_PORT=8082
ARGOCD_DEX_SERVER_PORT_5557_TCP_ADDR=10.100.200.242
HARBOR_EXPORTER_SERVICE_PORT_HTTP_METRICS=8001
HARBOR_REGISTRY_SERVICE_PORT_HTTP_METRICS=8001
ARGOCD_APPLICATION_CONTROLLER_SERVICE_PORT_HTTPS_CONTROLLER=8082
JENKINS_SERVER_COOKIE=durable-aa19f811612d72f3179969f0b7cbb591
ARGOCD_DEX_SERVER_SERVICE_PORT=5556
ARGOCD_REPO_SERVER_SERVICE_HOST=10.100.229.35
HARBOR_REGISTRY_PORT_8080_TCP_ADDR=10.100.80.27
ARGOCD_APPLICATION_CONTROLLER_METRICS_PORT_8082_TCP_ADDR=10.100.61.120
HARBOR_REGISTRY_SERVICE_HOST=10.100.80.27
ARGOCD_DEX_SERVER_PORT=tcp://10.100.200.242:5556
HARBOR_EXPORTER_SERVICE_HOST=10.100.197.58
HARBOR_CORE_PORT_80_TCP=tcp://10.100.35.97:80
GITEA_SSH_SERVICE_PORT_SSH=22
HARBOR_REGISTRY_PORT_5000_TCP=tcp://10.100.80.27:5000
ARGOCD_REPO_SERVER_PORT_8081_TCP_ADDR=10.100.229.35
ARGOCD_DEX_SERVER_PORT_5556_TCP_PORT=5556
ARGOCD_SERVER_PORT_80_TCP_PORT=80
CM_ACME_HTTP_SOLVER_G2GTN_PORT=tcp://10.100.192.231:8089
ARGOCD_DEX_SERVER_PORT_5557_TCP_PORT=5557
CM_ACME_HTTP_SOLVER_G2GTN_SERVICE_PORT=8089
ARGOCD_DEX_SERVER_PORT_5556_TCP_PROTO=tcp
ARGOCD_SERVER_PORT_80_TCP_PROTO=tcp
HARBOR_PORTAL_PORT_80_TCP_ADDR=10.100.166.174
HARBOR_REGISTRY_SERVICE_PORT_HTTP_CONTROLLER=8080
WORKSPACE=/home/jenkins/agent/workspace/nodejs-bot
ARGOCD_APPLICATION_CONTROLLER_METRICS_PORT_8082_TCP_PORT=8082
HARBOR_JOBSERVICE_PORT_8001_TCP=tcp://10.100.0.62:8001
HARBOR_REGISTRY_PORT_8080_TCP_PORT=8080
GITEA_HTTP_PORT_3000_TCP_ADDR=10.100.247.200
ARGOCD_DEX_SERVER_PORT_5557_TCP_PROTO=tcp
GITEA_MARIADB_PORT=tcp://10.100.136.161:3306
HARBOR_CHARTMUSEUM_PORT_80_TCP=tcp://10.100.178.74:80
CM_ACME_HTTP_SOLVER_G2GTN_PORT_8089_TCP_ADDR=10.100.192.231
GITEA_MARIADB_SERVICE_PORT=3306
JENKINS_AGENT_PORT_50000_TCP_ADDR=10.100.146.111
ARGOCD_APPLICATION_CONTROLLER_METRICS_PORT_8082_TCP_PROTO=tcp
ARGOCD_REPO_SERVER_PORT_8081_TCP_PORT=8081
ARGOCD_SERVER_METRICS_SERVICE_PORT_METRICS=8083
HARBOR_REGISTRY_PORT_8080_TCP_PROTO=tcp
HARBOR_JOBSERVICE_PORT=tcp://10.100.0.62:80
HARBOR_JOBSERVICE_SERVICE_PORT=80
ARGOCD_REPO_SERVER_PORT_8081_TCP_PROTO=tcp
ARGOCD_APPLICATION_CONTROLLER_METRICS_SERVICE_PORT=8082
GITEA_MARIADB_PORT_3306_TCP=tcp://10.100.136.161:3306
HARBOR_PORTAL_PORT_80_TCP_PORT=80
JENKINS_SERVICE_PORT_HTTP=8080
HARBOR_REGISTRY_PORT_8001_TCP=tcp://10.100.80.27:8001
ARGOCD_APPLICATION_CONTROLLER_METRICS_PORT=tcp://10.100.61.120:8082
ARGOCD_DEX_SERVER_SERVICE_PORT_GRPC=5557
HARBOR_EXPORTER_PORT_8001_TCP=tcp://10.100.197.58:8001
HARBOR_NOTARY_SIGNER_SERVICE_HOST=10.100.199.220
POD_CONTAINER=tree
NODE_NAME=jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk
HARBOR_PORTAL_PORT_80_TCP_PROTO=tcp
ARGOCD_APPLICATION_CONTROLLER_PORT_8082_TCP=tcp://10.100.106.227:8082
ARGOCD_SERVER_METRICS_PORT_8083_TCP=tcp://10.100.186.217:8083
JENKINS_AGENT_SERVICE_HOST=10.100.146.111
ARGOCD_REDIS_SERVICE_HOST=10.100.4.120
GITEA_HTTP_PORT_3000_TCP_PORT=3000
RUN_ARTIFACTS_DISPLAY_URL=http://jenkins:8080/job/nodejs-bot/2/display/redirect?page=artifacts
JENKINS_AGENT_PORT_50000_TCP_PORT=50000
ARGOCD_REPO_SERVER_SERVICE_PORT=8081
HARBOR_REGISTRY_SERVICE_PORT=5000
HARBOR_EXPORTER_PORT=tcp://10.100.197.58:8001
HARBOR_EXPORTER_SERVICE_PORT=8001
CM_ACME_HTTP_SOLVER_G2GTN_PORT_8089_TCP_PORT=8089
GITEA_HTTP_PORT_3000_TCP_PROTO=tcp
ARGOCD_REPO_SERVER_PORT=tcp://10.100.229.35:8081
HARBOR_REGISTRY_PORT=tcp://10.100.80.27:5000
STAGE_NAME=Checkout
EXECUTOR_NUMBER=0
HARBOR_DATABASE_PORT_5432_TCP_ADDR=10.100.208.26
HARBOR_CORE_PORT_8001_TCP_ADDR=10.100.35.97
CM_ACME_HTTP_SOLVER_2M25B_SERVICE_PORT_HTTP=8089
CM_ACME_HTTP_SOLVER_G2GTN_PORT_8089_TCP_PROTO=tcp
JENKINS_AGENT_PORT_50000_TCP_PROTO=tcp
GITEA_HTTP_SERVICE_PORT_HTTP=3000
RUN_TESTS_DISPLAY_URL=http://jenkins:8080/job/nodejs-bot/2/display/redirect?page=tests
BUILD_DISPLAY_NAME=#2
KUBERNETES_PORT_443_TCP_ADDR=10.100.0.1
ARGOCD_SERVER_PORT_80_TCP=tcp://10.100.3.46:80
HARBOR_TRIVY_SERVICE_PORT_HTTP_TRIVY=8080
ARGOCD_SERVER_PORT_443_TCP_ADDR=10.100.3.46
HARBOR_DATABASE_SERVICE_HOST=10.100.208.26
ARGOCD_DEX_SERVER_PORT_5556_TCP=tcp://10.100.200.242:5556
JOB_BASE_NAME=nodejs-bot
HUDSON_HOME=/var/jenkins_home
HARBOR_JOBSERVICE_PORT_80_TCP_ADDR=10.100.0.62
ARGOCD_APPLICATION_CONTROLLER_METRICS_SERVICE_PORT_METRICS=8082
HARBOR_CORE_PORT_8001_TCP_PORT=8001
ARGOCD_DEX_SERVER_PORT_5557_TCP=tcp://10.100.200.242:5557
HARBOR_DATABASE_PORT_5432_TCP_PORT=5432
HARBOR_NOTARY_SIGNER_SERVICE_PORT=7899
HARBOR_NOTARY_SIGNER_PORT=tcp://10.100.199.220:7899
GITEA_SSH_SERVICE_HOST=10.100.4.242
HARBOR_DATABASE_PORT_5432_TCP_PROTO=tcp
JENKINS_SERVICE_HOST=10.100.158.19
HARBOR_CORE_PORT_8001_TCP_PROTO=tcp
ARGOCD_APPLICATION_CONTROLLER_METRICS_PORT_8082_TCP=tcp://10.100.61.120:8082
JENKINS_PORT_8080_TCP_ADDR=10.100.158.19
HARBOR_REGISTRY_PORT_8080_TCP=tcp://10.100.80.27:8080
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
BUILD_ID=2
ARGOCD_REDIS_PORT=tcp://10.100.4.120:6379
HARBOR_CORE_SERVICE_PORT_HTTP_WEB=80
JENKINS_AGENT_PORT=tcp://10.100.146.111:50000
JENKINS_AGENT_SERVICE_PORT=50000
ARGOCD_SERVER_PORT_443_TCP_PORT=443
ARGOCD_REDIS_SERVICE_PORT=6379
ARGOCD_REPO_SERVER_PORT_8081_TCP=tcp://10.100.229.35:8081
KUBERNETES_PORT_443_TCP_PORT=443
BUILD_TAG=jenkins-nodejs-bot-2
JENKINS_AGENT_SERVICE_PORT_AGENT_LISTENER=50000
HARBOR_PORTAL_PORT_80_TCP=tcp://10.100.166.174:80
ARGOCD_SERVER_PORT_443_TCP_PROTO=tcp
GITEA_MEMCACHED_PORT_11211_TCP_ADDR=10.100.210.240
KUBERNETES_PORT_443_TCP_PROTO=tcp
HARBOR_CORE_SERVICE_PORT_HTTP_METRICS=8001
HARBOR_JOBSERVICE_PORT_80_TCP_PORT=80
JENKINS_URL=http://jenkins:8080/
ARGOCD_REDIS_PORT_6379_TCP_ADDR=10.100.4.120
GITEA_MEMCACHED_SERVICE_HOST=10.100.210.240
HARBOR_CORE_SERVICE_HOST=10.100.35.97
HARBOR_REDIS_SERVICE_HOST=10.100.212.106
HARBOR_JOBSERVICE_SERVICE_PORT_HTTP_JOBSERVICE=80
JENKINS_PORT_8080_TCP_PORT=8080
GITEA_HTTP_PORT_3000_TCP=tcp://10.100.247.200:3000
CM_ACME_HTTP_SOLVER_2M25B_SERVICE_HOST=10.100.23.213
HARBOR_TRIVY_PORT_8080_TCP_ADDR=10.100.101.52
HARBOR_JOBSERVICE_PORT_80_TCP_PROTO=tcp
HARBOR_TRIVY_SERVICE_HOST=10.100.101.52
JOB_URL=http://jenkins:8080/job/nodejs-bot/
CM_ACME_HTTP_SOLVER_G2GTN_PORT_8089_TCP=tcp://10.100.192.231:8089
GITEA_HTTP_SERVICE_HOST=10.100.247.200
JENKINS_PORT_8080_TCP_PROTO=tcp
JENKINS_AGENT_PORT_50000_TCP=tcp://10.100.146.111:50000
BUILD_NUMBER=2
GITEA_MEMCACHED_PORT_11211_TCP_PORT=11211
GITEA_MEMCACHED_SERVICE_PORT_MEMCACHE=11211
ARGOCD_SERVER_SERVICE_PORT_HTTP=80
HARBOR_DATABASE_SERVICE_PORT=5432
HARBOR_DATABASE_PORT=tcp://10.100.208.26:5432
JENKINS_NODE_COOKIE=f0f9b292-ad4c-48e3-a6e1-b561fb62c4c3
HARBOR_TRIVY_PORT_8080_TCP_PORT=8080
HARBOR_CHARTMUSEUM_SERVICE_HOST=10.100.178.74
GITEA_MEMCACHED_PORT_11211_TCP_PROTO=tcp
ARGOCD_REDIS_PORT_6379_TCP_PORT=6379
RUN_DISPLAY_URL=http://jenkins:8080/job/nodejs-bot/2/display/redirect
GITEA_SSH_SERVICE_PORT=22
JENKINS_SERVICE_PORT=8080
ARGOCD_REDIS_PORT_6379_TCP_PROTO=tcp
HARBOR_TRIVY_PORT_8080_TCP_PROTO=tcp
HARBOR_NOTARY_SERVER_PORT_4443_TCP_ADDR=10.100.187.15
JENKINS_PORT=tcp://10.100.158.19:8080
GITEA_SSH_PORT=tcp://10.100.4.242:22
HARBOR_REGISTRY_SERVICE_PORT_HTTP_REGISTRY=5000
HUDSON_SERVER_COOKIE=5d25f24e4769328f
HARBOR_DATABASE_PORT_5432_TCP=tcp://10.100.208.26:5432
HARBOR_NOTARY_SERVER_SERVICE_HOST=10.100.187.15
HARBOR_CORE_PORT_8001_TCP=tcp://10.100.35.97:8001
JOB_DISPLAY_URL=http://jenkins:8080/job/nodejs-bot/display/redirect
GITEA_SSH_PORT_22_TCP_ADDR=10.100.4.242
CLASSPATH=
HARBOR_TRIVY_PORT=tcp://10.100.101.52:8080
GITEA_MEMCACHED_PORT=tcp://10.100.210.240:11211
KUBERNETES_SERVICE_PORT_HTTPS=443
CM_ACME_HTTP_SOLVER_2M25B_SERVICE_PORT=8089
GITEA_MEMCACHED_SERVICE_PORT=11211
HARBOR_CORE_PORT=tcp://10.100.35.97:80
HARBOR_NOTARY_SIGNER_PORT_7899_TCP_ADDR=10.100.199.220
HARBOR_REDIS_PORT=tcp://10.100.212.106:6379
CM_ACME_HTTP_SOLVER_2M25B_PORT=tcp://10.100.23.213:8089
HARBOR_CORE_SERVICE_PORT=80
ARGOCD_SERVER_SERVICE_PORT_HTTPS=443
HARBOR_TRIVY_SERVICE_PORT=8080
HARBOR_REDIS_SERVICE_PORT=6379
HARBOR_NOTARY_SERVER_PORT_4443_TCP_PORT=4443
ARGOCD_SERVER_PORT_443_TCP=tcp://10.100.3.46:443
KUBERNETES_PORT_443_TCP=tcp://10.100.0.1:443
JOB_NAME=nodejs-bot
GITEA_HTTP_SERVICE_PORT=3000
GITEA_HTTP_PORT=tcp://10.100.247.200:3000
HARBOR_JOBSERVICE_PORT_80_TCP=tcp://10.100.0.62:80
HARBOR_NOTARY_SERVER_PORT_4443_TCP_PROTO=tcp
PWD=/home/jenkins/agent/workspace/nodejs-bot
JENKINS_PORT_8080_TCP=tcp://10.100.158.19:8080
HARBOR_REDIS_PORT_6379_TCP_ADDR=10.100.212.106
KUBERNETES_SERVICE_HOST=10.100.0.1
GITEA_SSH_PORT_22_TCP_PORT=22
ARGOCD_SERVER_SERVICE_HOST=10.100.3.46
CM_ACME_HTTP_SOLVER_2M25B_PORT_8089_TCP_ADDR=10.100.23.213
HARBOR_CHARTMUSEUM_PORT=tcp://10.100.178.74:80
GITEA_SSH_PORT_22_TCP_PROTO=tcp
ARGOCD_DEX_SERVER_SERVICE_PORT_HTTP=5556
HARBOR_NOTARY_SIGNER_PORT_7899_TCP_PORT=7899
HARBOR_CHARTMUSEUM_SERVICE_PORT=80
HARBOR_NOTARY_SIGNER_PORT_7899_TCP_PROTO=tcp
GITEA_MEMCACHED_PORT_11211_TCP=tcp://10.100.210.240:11211
WORKSPACE_TMP=/home/jenkins/agent/workspace/nodejs-bot@tmp
CM_ACME_HTTP_SOLVER_G2GTN_SERVICE_PORT_HTTP=8089
ARGOCD_REDIS_PORT_6379_TCP=tcp://10.100.4.120:6379
HARBOR_TRIVY_PORT_8080_TCP=tcp://10.100.101.52:8080
CM_ACME_HTTP_SOLVER_2M25B_PORT_8089_TCP_PORT=8089
HARBOR_NOTARY_SERVER_PORT=tcp://10.100.187.15:4443
HARBOR_NOTARY_SERVER_SERVICE_PORT=4443
HARBOR_REDIS_PORT_6379_TCP_PORT=6379
HARBOR_PORTAL_SERVICE_HOST=10.100.166.174
HARBOR_REDIS_PORT_6379_TCP_PROTO=tcp
HARBOR_CORE_PORT_80_TCP_ADDR=10.100.35.97
HARBOR_REGISTRY_PORT_5000_TCP_ADDR=10.100.80.27
CM_ACME_HTTP_SOLVER_2M25B_PORT_8089_TCP_PROTO=tcp
[Pipeline] sh
+ tree
.
├── Dockerfile
├── Dockerfile.centos
├── Dockerfile.org
├── Jenkinsfile
├── Jenkinsfile.20200722
├── Jenkinsfile.20200722.01
├── Jenkinsfile.nodejs-bot
├── README.md
├── README.txt
├── ca.crt
├── ctl.sh
├── ctl.sh.20191031
├── ctl.sh.20191031.01
├── ctl.sh_
├── delete-evicted-pod.sh
├── get-redis-master.sh
├── jenkins-robot-biding-crb.yaml
├── jenkins-robot-sa.yaml
├── logger.js
├── match.js
├── nodejs-bot-deploy.yaml
├── nodejs-bot-deploy.yaml.20191031
├── nodejs-bot-redis-info-cm.yaml
├── nodejs-bot-role.yaml
├── nodejs-bot-script-cm.yaml
├── nodejs-bot-script-cm.yaml.20191031
├── nodejs-bot-svc.yaml
├── nodejs-exporter.js
├── package-lock.json
├── package.json
├── package.json.20200721
├── redis-ha.js
├── redis-pass.yaml
├── repo
│   ├── CentOS-Base.repo
│   └── CentOS-fasttrack.repo
├── scripts
│   ├── README.txt
│   ├── apache-tomcat-8.0.35.tar.gz
│   ├── bash_profile
│   ├── catalina.sh
│   ├── create_admin_user.sh
│   ├── kubectl
│   ├── netstat
│   ├── nslookup
│   └── tomcat.sh
├── server.js
├── server.js.20191031
├── shell.js
└── support
    └── demo.gif

3 directories, 48 files
[Pipeline] }
[Pipeline] // container
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build Node.js Project & Docker Image)
[Pipeline] container
[Pipeline] {
[Pipeline] sh
+ docker build --rm=true --network=host --tag nodejs-bot:1.0.0 .
Sending build context to Docker daemon  105.1MB

Step 1/35 : FROM centos:7.6.1810
7.6.1810: Pulling from library/centos
ac9208207ada: Pulling fs layer
ac9208207ada: Verifying Checksum
ac9208207ada: Download complete
ac9208207ada: Pull complete
Digest: sha256:62d9e1c2daa91166139b51577fe4f4f6b4cc41a3a2c7fc36bd895e2a17a3e4e6
Status: Downloaded newer image for centos:7.6.1810
 ---> f1cb7c7d58b7
Step 2/35 : MAINTAINER taeeyoul <taeeyoul@sk.com>
 ---> Running in 32727e344a61
Removing intermediate container 32727e344a61
 ---> 6e2094476ad4
Step 3/35 : LABEL Vendor="CentOS"       License=GPLv2       Version=8.0.38
 ---> Running in 367f08672425
Removing intermediate container 367f08672425
 ---> c185f0439064
Step 4/35 : USER  root
 ---> Running in ad0b37ff43e0
Removing intermediate container ad0b37ff43e0
 ---> cb909d8fb62b
Step 5/35 : RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
 ---> Running in eee154b95afc
Removing intermediate container eee154b95afc
 ---> 51cf15bdd041
Step 6/35 : COPY repo/CentOS-Base.repo /etc/yum.repos.d
 ---> f34005f1795f
Step 7/35 : COPY repo/CentOS-fasttrack.repo /etc/yum.repos.d
 ---> a7fffb7b725d
Step 8/35 : ENV LANG=en_US.UTF8
 ---> Running in 2f12c76b76e1
Removing intermediate container 2f12c76b76e1
 ---> 74d3bc205186
Step 9/35 : ENV LC_ALL=en_US.UTF8
 ---> Running in 4e0e62dd424f
Removing intermediate container 4e0e62dd424f
 ---> 41f270db4b03
Step 10/35 : ENV APP nodejs-bot
 ---> Running in 5b3ce687cf19
Removing intermediate container 5b3ce687cf19
 ---> 624538b92315
Step 11/35 : RUN echo 'LANGUAGE=en_US.UTF8; export LANG' >> /etc/environment &&     echo 'LANG=en_US.UTF8; export LANG' >> /etc/environment &&     echo 'LC_ALL=en_US.UTF8; export LC_ALL' >> /etc/environment &&     echo 'LANG=en_US.UTF8:en_US:ko:en_US.UTF-8:en_US:en' >> /etc/sysconfig/i18n &&     echo 'SYSFONT=latarcyrheb-sun16' >> /etc/sysconfig/i18n &&     echo 'LC_CTYPE=en_US.UTF8; export LC_CTYPE' >> /etc/sysconfig/i18n &&     echo 'LC_MESSAGES=en_US.UTF8; export LC_MESSAGES' >> /etc/sysconfig/i18n &&     echo 'LANG=en_US.UTF8; export LANG' >> /etc/bashrc &&     echo 'LC_ALL=en_US.UTF8; export LC_ALL' >> /etc/bashrc &&     echo 'LANG=en_US.UTF8' > /etc/locale.conf &&     echo 'LC_ALL=en_US.UTF8; export LC_ALL' >> /etc/profile &&     echo 'LANG=en_US.UTF8' > /etc/profile &&     echo 'DOCKER_CONTAINER_TRUST=1; export DOCKER_CONTAINER_TRUST' > /etc/bash &&     echo 'DOCKER_CONTAINER_TRUST=1; export DOCKER_CONTAINER_TRUST' > /etc/profile
 ---> Running in 3264d96e5e27
Removing intermediate container 3264d96e5e27
 ---> 603a2ea86244
Step 12/35 : RUN sed -i 's/^PASS_MIN_LEN.*/PASS_MIN_LEN 9/g' /etc/login.defs &&     sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 70/g' /etc/login.defs &&     sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 7/g' /etc/login.defs
 ---> Running in eefb23819739
Removing intermediate container eefb23819739
 ---> c193c37e979f
Step 13/35 : RUN userdel lp
 ---> Running in 1cf5bcfa70d8
Removing intermediate container 1cf5bcfa70d8
 ---> f17050df1b35
Step 14/35 : RUN echo "umask 022" >> /etc/profile;     chmod u-s /sbin/unix_chkpwd;     chmod u-s /usr/bin/newgrp;     touch /etc/hosts.equiv;     chown root /etc/hosts.equiv;     chmod 000 /etc/hosts.equiv;     touch /root/.rhosts;     chown root /root/.rhosts;     chmod 000 /root/.rhosts;     echo "# This system is for the use of authorized users only. #" >> /etc/issue;     echo "export TMOUT=3600" >> /etc/profile
 ---> Running in 7d9fde5a995c
Removing intermediate container 7d9fde5a995c
 ---> b8360deb7846
Step 15/35 : RUN find / -perm +6000 -type f -exec chmod a-s {} \; || true
 ---> Running in 117b38a6a7d1
[91mfind: warning: you are using `-perm +MODE'.  The interpretation of `-perm +omode' changed in findutils-4.5.11.  The syntax `-perm +omode' was removed in findutils-4.5.12, in favour of `-perm /omode'.
[0m[91mfind: [0m[91m‘/proc/5/task/5/fdinfo/5’[0m[91m: No such file or directory[0m[91m
[0m[91mfind: [0m[91m‘/proc/5/fdinfo/6’[0m[91m: No such file or directory[0m[91m
[0mRemoving intermediate container 117b38a6a7d1
 ---> 61706280ba12
Step 16/35 : RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i ==     systemd-tmpfiles-setup.service ] || rm -f $i; done);     rm -f /lib/systemd/system/multi-user.target.wants/*;    rm -f /etc/systemd/system/*.wants/*;    rm -f /lib/systemd/system/local-fs.target.wants/*;     rm -f /lib/systemd/system/sockets.target.wants/*udev*;     rm -f /lib/systemd/system/sockets.target.wants/*initctl*;     rm -f /lib/systemd/system/basic.target.wants/*;    rm -f /lib/systemd/system/anaconda.target.wants/*;
 ---> Running in e3910a50922c
Removing intermediate container e3910a50922c
 ---> d29cf0c6ca2c
Step 17/35 : VOLUME [ "/sys/fs/cgroup" ]
 ---> Running in 9f15ad0ca9a0
Removing intermediate container 9f15ad0ca9a0
 ---> 3202109210b4
Step 18/35 : CMD ["/usr/sbin/init"]
 ---> Running in 672e2523161a
Removing intermediate container 672e2523161a
 ---> bff7a6ec49cb
Step 19/35 : RUN mkdir -p /home/nodejs ;     mkdir -p /home/appadmin ;     groupadd -g 1004 nodejs ;     useradd -d /home/nodejs -m -s /bin/bash -u 1004 -g 1004 nodejs
 ---> Running in 303e0e3fefeb
[91museradd: warning: the home directory already exists.
Not copying any file from skel directory into it.
[0mRemoving intermediate container 303e0e3fefeb
 ---> f82ca3ab8718
Step 20/35 : COPY ./scripts/bash_profile /root/.bash_profile
 ---> 45fb34bc3a19
Step 21/35 : COPY ./scripts/bash_profile /home/nodejs/.bash_profile
 ---> edcf7e5a22d6
Step 22/35 : COPY ./scripts/netstat  /usr/local/bin
 ---> 32ddad66a4e2
Step 23/35 : COPY ./scripts/nslookup /usr/local/bin
 ---> 8844ba6dcdc5
Step 24/35 : COPY ./scripts/kubectl  /usr/local/bin
 ---> e46be1069b13
Step 25/35 : RUN  chmod +777 /usr/local/bin/netstat &&      chmod +777 /usr/local/bin/nslookup &&      chmod +777 /usr/local/bin/kubectl &&      chown -R nodejs:nodejs /home/nodejs
 ---> Running in 536daef56468
Removing intermediate container 536daef56468
 ---> 15275657f8aa
Step 26/35 : RUN yum erase nodejs -y &&     curl --silent --location https://rpm.nodesource.com/setup_14.x | bash - &&     yum -y install nodejs npm &&     yum -y install wget which &&     yum clean all
 ---> Running in afe2c4cc15a2
Loaded plugins: fastestmirror, ovl
[91mNo Match for argument: nodejs
[0mNo Packages marked for removal
## Installing the NodeSource Node.js 14.x repo...


## Inspecting system...

+ rpm -q --whatprovides redhat-release || rpm -q --whatprovides centos-release || rpm -q --whatprovides cloudlinux-release || rpm -q --whatprovides sl-release || rpm -q --whatprovides fedora-release
+ uname -m

## Confirming "el7-x86_64" is supported...

+ curl -sLf -o /dev/null 'https://rpm.nodesource.com/pub_14.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm'

## Downloading release setup RPM...

+ mktemp
+ curl -sL -o '/tmp/tmp.w3bR2ITifM' 'https://rpm.nodesource.com/pub_14.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm'
## Installing release setup RPM...

+ rpm -i --nosignature --force '/tmp/tmp.w3bR2ITifM'

## Cleaning up...

+ rm -f '/tmp/tmp.w3bR2ITifM'

## Checking for existing installations...

+ rpm -qa 'node|npm' | grep -v nodesource

## Run `sudo yum install -y nodejs` to install Node.js 14.x and npm.
## You may also need development tools to build native addons:
     sudo yum install gcc-c++ make
## To install the Yarn package manager, run:
     curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
     sudo yum install yarn

Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
No package npm available.
Resolving Dependencies
--> Running transaction check
---> Package nodejs.x86_64 2:14.17.4-1nodesource will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package      Arch         Version                       Repository        Size
================================================================================
Installing:
 nodejs       x86_64       2:14.17.4-1nodesource         nodesource        32 M

Transaction Summary
================================================================================
Install  1 Package

Total download size: 32 M
Installed size: 92 M
Downloading packages:
[91mwarning: /var/cache/yum/x86_64/7/nodesource/packages/nodejs-14.17.4-1nodesource.x86_64.rpm: Header V4 RSA/SHA512 Signature, key ID 34fa74dd: NOKEY
[0mPublic key for nodejs-14.17.4-1nodesource.x86_64.rpm is not installed
Retrieving key from file:///etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL
[91mImporting GPG key 0x34FA74DD:
 Userid     : "NodeSource <gpg-rpm@nodesource.com>"
 Fingerprint: 2e55 207a 95d9 944b 0cc9 3261 5ddb e8d4 34fa 74dd
 Package    : nodesource-release-el7-1.noarch (installed)
 From       : /etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL
[0mRunning transaction check
Running transaction test
Transaction test succeeded
Running transaction
[91mWarning: RPMDB altered outside of yum.
[0m  Installing : 2:nodejs-14.17.4-1nodesource.x86_64                          1/1 
  Verifying  : 2:nodejs-14.17.4-1nodesource.x86_64                          1/1 

Installed:
  nodejs.x86_64 2:14.17.4-1nodesource                                           

Complete!
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
Resolving Dependencies
--> Running transaction check
---> Package wget.x86_64 0:1.14-18.el7_6.1 will be installed
---> Package which.x86_64 0:2.20-7.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package        Arch            Version                     Repository     Size
================================================================================
Installing:
 wget           x86_64          1.14-18.el7_6.1             base          547 k
 which          x86_64          2.20-7.el7                  base           41 k

Transaction Summary
================================================================================
Install  2 Packages

Total download size: 588 k
Installed size: 2.0 M
Downloading packages:
[91mwarning: [0m[91m/var/cache/yum/x86_64/7/base/packages/which-2.20-7.el7.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
[0mPublic key for which-2.20-7.el7.x86_64.rpm is not installed
--------------------------------------------------------------------------------
Total                                              3.5 MB/s | 588 kB  00:00     
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
[91mImporting GPG key 0xF4A80EB5:
 Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
 Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
 Package    : centos-release-7-6.1810.2.el7.centos.x86_64 (@CentOS)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
[0mRunning transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : wget-1.14-18.el7_6.1.x86_64                                  1/2 
install-info: No such file or directory for /usr/share/info/wget.info.gz
  Installing : which-2.20-7.el7.x86_64                                      2/2 
install-info: No such file or directory for /usr/share/info/which.info.gz
  Verifying  : which-2.20-7.el7.x86_64                                      1/2 
  Verifying  : wget-1.14-18.el7_6.1.x86_64                                  2/2 

Installed:
  wget.x86_64 0:1.14-18.el7_6.1            which.x86_64 0:2.20-7.el7           

Complete!
Loaded plugins: fastestmirror, ovl
Cleaning repos: base extras nodesource updates
Cleaning up list of fastest mirrors
Removing intermediate container afe2c4cc15a2
 ---> 67b7a2eef728
Step 27/35 : WORKDIR /home/appadmin
Removing intermediate container 8b84f3a295e5
 ---> 266d2050b949
Step 28/35 : COPY package*.json ./
 ---> 368620fd56f4
Step 29/35 : RUN npm install && npm cache clean --force
 ---> Running in ae98a53d2526
> gc-stats@1.4.0 install /home/appadmin/node_modules/gc-stats
> node-pre-gyp install --fallback-to-build

[91mnode-pre-gyp[0m[91m WARN Using request for node-pre-gyp https download[0m[91m 
[0m[91mnode-pre-gyp[0m[91m WARN Tried to download(403): https://node-binaries.s3.amazonaws.com/gcstats/v1.4.0/Release/node-v83-linux-x64.tar.gz 
node-pre-gyp WARN Pre-built binaries not found for gc-stats@1.4.0 and node@14.17.4 (node-v83 ABI, glibc) (falling back to source compile with node-gyp) 
[0m[91mgyp[0m[91m ERR![0m[91m build error 
[0m[91mgyp [0m[91mERR! stack Error: not found: make
gyp ERR! stack     at getNotFoundError (/usr/lib/node_modules/npm/node_modules/which/which.js:13:12)
gyp ERR! stack     at F (/usr/lib/node_modules/npm/node_modules/which/which.js:68:19)
gyp ERR! stack[0m[91m     at E (/usr/lib/node_modules/npm/node_modules/which/which.js:80:29)
gyp ERR! stack     at /usr/lib/node_modules/npm/node_modules/which/which.js:89:16
gyp ERR! stack     at /usr/lib/node_modules/npm/node_modules/isexe/index.js:42:5
gyp ERR! stack     at /usr/lib/node_modules/npm/node_modules/isexe/mode.js:8:5
gyp ERR! stack     at FSReqCallback.oncomplete (fs.js:192:21)
[0m[91mgyp ERR! System Linux 5.4.117-58.216.amzn2.x86_64
[0m[91mgyp ERR! command "/usr/bin/node" "/usr/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js" "build" "--fallback-to-build" "--module=/home/appadmin/node_modules/gc-stats/build/gcstats/v1.4.0/Release/node-v83-linux-x64/gcstats.node" "--module_name=gcstats" "--module_path=/home/appadmin/node_modules/gc-stats/build/gcstats/v1.4.0/Release/node-v83-linux-x64" "--napi_version=8" "--node_abi_napi=napi" "--napi_build_version=0" "--node_napi_label=node-v83"
gyp ERR! cwd /home/appadmin/node_modules/gc-stats
gyp ERR! node -v v14.17.4
gyp ERR! node-gyp -v v5.1.0
gyp ERR! not ok 
[0m[91mnode-pre-gyp[0m[91m [0m[91mERR! [0m[91mbuild error[0m[91m 
[0m[91mnode-pre-gyp[0m[91m ERR! stack Error: Failed to execute '/usr/bin/node /usr/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js build --fallback-to-build --module=/home/appadmin/node_modules/gc-stats/build/gcstats/v1.4.0/Release/node-v83-linux-x64/gcstats.node --module_name=gcstats --module_path=/home/appadmin/node_modules/gc-stats/build/gcstats/v1.4.0/Release/node-v83-linux-x64 --napi_version=8 --node_abi_napi=napi --napi_build_version=0 --node_napi_label=node-v83' (1)
[0m[91mnode-pre-gyp ERR! stack     at ChildProcess.<anonymous> (/home/appadmin/node_modules/gc-stats/node_modules/node-pre-gyp/lib/util/compile.js:83:29)
node-pre-gyp ERR! stack     at ChildProcess.emit (events.js:400:28)
node-pre-gyp ERR! stack     at maybeClose (internal/child_process.js:1055:16)
node-pre-gyp ERR! stack     at Process.ChildProcess._handle.onexit (internal/child_process.js:288:5)
[0m[91mnode-pre-gyp ERR! System Linux 5.4.117-58.216.amzn2.x86_64
[0m[91mnode-pre-gyp ERR! command "/usr/bin/node" "/home/appadmin/node_modules/gc-stats/node_modules/.bin/node-pre-gyp" "install" "--fallback-to-build"
node-pre-gyp ERR! cwd[0m[91m /home/appadmin/node_modules/gc-stats
node-pre-gyp ERR! node -v v14.17.4
node-pre-gyp ERR! node-pre-gyp -v v0.13.0
node-pre-gyp ERR! not ok 
[0mFailed to execute '/usr/bin/node /usr/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js build --fallback-to-build --module=/home/appadmin/node_modules/gc-stats/build/gcstats/v1.4.0/Release/node-v83-linux-x64/gcstats.node --module_name=gcstats --module_path=/home/appadmin/node_modules/gc-stats/build/gcstats/v1.4.0/Release/node-v83-linux-x64 --napi_version=8 --node_abi_napi=napi --napi_build_version=0 --node_napi_label=node-v83' (1)

> core-js@2.6.9 postinstall /home/appadmin/node_modules/core-js
> node scripts/postinstall || echo "ignore"

[96mThank you for using core-js ([94m https://github.com/zloirock/core-js [96m) for polyfilling JavaScript standard library![0m

[96mThe project needs your help! Please consider supporting of core-js on Open Collective or Patreon: [0m
[96m>[94m https://opencollective.com/core-js [0m
[96m>[94m https://www.patreon.com/zloirock [0m

[96mAlso, the author of core-js ([94m https://github.com/zloirock [96m) is looking for a good job -)[0m

[91mnpm WARN optional SKIPPING OPTIONAL DEPENDENCY: gc-stats@1.4.0 (node_modules/gc-stats):
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: gc-stats@1.4.0 install: `node-pre-gyp install --fallback-to-build`
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: Exit status 1

[0madded 587 packages from 460 contributors and audited 655 packages in 16.529s
found 2344 vulnerabilities (1159 low, 5 moderate, 1180 high)
  run `npm audit fix` to fix them, or `npm audit` for details
[91mnpm[0m[91m [0m[91mWARN[0m[91m [0m[91musing --force[0m[91m I sure hope you know what you are doing.
[0mRemoving intermediate container ae98a53d2526
 ---> 5d3da656d6bc
Step 30/35 : COPY nodejs-exporter.js ./
 ---> eea440286c1d
Step 31/35 : COPY logger.js ./
 ---> 09480e87909c
Step 32/35 : COPY redis-ha.js ./
 ---> 3606d0fdfca1
Step 33/35 : COPY server.js ./
 ---> 789087173ce0
Step 34/35 : EXPOSE 8080
 ---> Running in 6ee676176fe3
Removing intermediate container 6ee676176fe3
 ---> 548aeb647747
Step 35/35 : CMD [ "npm", "start" ]
 ---> Running in b81ba410f656
Removing intermediate container b81ba410f656
 ---> b4779272f4a5
Successfully built b4779272f4a5
Successfully tagged nodejs-bot:1.0.0
[Pipeline] sh
+ docker tag nodejs-bot:1.0.0 harbor.a-tcl-da.net/app/nodejs-bot:1.0.0
[Pipeline] slackSend
Slack Send Pipeline step running, values are - baseUrl: <empty>, teamDomain: a-tcl-da, channel: alert, color: #0000FF, botUser: false, tokenCredentialId: Slack, notifyCommitters: false, iconEmoji: <empty>, username: Jenkins, timestamp: <empty>
[Pipeline] }
[Pipeline] // container
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Push Docker Image)
[Pipeline] container
[Pipeline] {
[Pipeline] withDockerRegistry
Executing sh script inside container docker of pod jenkins-slave-99241c77-1739-4c08-aa0a-877eff823286-slh1z-mh8wk
Executing command: "docker" "login" "-u" "admin" "-p" ******** "http://harbor.a-tcl-da.net" 
exit
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
Error response from daemon: Get https://harbor.a-tcl-da.net/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
[Pipeline] // withDockerRegistry
[Pipeline] slackSend
Slack Send Pipeline step running, values are - baseUrl: <empty>, teamDomain: a-tcl-da, channel: #alert, color: #FF0000, botUser: false, tokenCredentialId: Slack, notifyCommitters: false, iconEmoji: <empty>, username: Jenkins, timestamp: <empty>
[Pipeline] echo
hudson.AbortException: docker login failed
[Pipeline] }
[Pipeline] // container
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] }
[Pipeline] // podTemplate
[Pipeline] End of Pipeline
ERROR: docker login failed
Finished: FAILURE

```

