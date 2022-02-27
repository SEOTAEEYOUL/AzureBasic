```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> helm fetch harbor/harbor --version 1.7.0
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> ls

    Directory: C:\workspace\AzureBasic\2.AKS\GitOps\harbor

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----        2022-02-27 오전 11:30                harbor-1.4.1
d----        2022-02-27 오후 12:31                harbor-1.8.1
d----        2022-02-27  오후 1:16                harbor-11.2.4
-a---        2022-02-27 오전 11:29          43344 harbor-1.4.1.tgz
-a---        2022-02-27  오후 2:35          48691 harbor-1.7.0.tgz
-a---        2022-02-26  오후 5:47          50207 harbor-1.8.1.tgz
-a---        2022-02-27  오후 1:16         222247 harbor-11.2.4.tgz
-a---        2022-02-27 오전 11:35           1971 harbor-harbor-ingress.yaml.org
-a---        2022-02-27  오후 1:42           1961 harbor-ingress-bitnami copy.yaml
-a---        2022-02-27  오후 1:56           2194 harbor-ingress-bitnami.yaml
-a---        2022-02-27  오후 1:42           1093 harbor-ingress-notary-bitnami copy.yaml
-a---        2022-02-27  오후 1:42           1093 harbor-ingress-notary-bitnami.yaml
-a---        2022-02-26 오후 11:56            999 harbor-ingress-notary.yaml
-a---        2022-02-27 오후 12:36           1037 harbor-ingress-notary.yaml.org
-a---        2022-02-27 오후 12:40           1843 harbor-ingress.yaml
-a---        2022-02-27  오후 1:00           2013 harbor-ingress.yaml.org
-a---        2022-02-27  오후 1:35          12379 README.md

PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> tar -zxvf harbor-1.7.0.tgz 
x harbor/Chart.yaml
x harbor/values.yaml
x harbor/templates/NOTES.txt
x harbor/templates/_helpers.tpl
x harbor/templates/chartmuseum/chartmuseum-cm.yaml
x harbor/templates/chartmuseum/chartmuseum-dpl.yaml
x harbor/templates/chartmuseum/chartmuseum-pvc.yaml
x harbor/templates/chartmuseum/chartmuseum-secret.yaml
x harbor/templates/chartmuseum/chartmuseum-svc.yaml
x harbor/templates/chartmuseum/chartmuseum-tls.yaml
x harbor/templates/core/core-cm.yaml
x harbor/templates/core/core-dpl.yaml
x harbor/templates/core/core-secret.yaml
x harbor/templates/core/core-svc.yaml
x harbor/templates/core/core-tls.yaml
x harbor/templates/database/database-secret.yaml
x harbor/templates/database/database-ss.yaml
x harbor/templates/database/database-svc.yaml
x harbor/templates/exporter/exporter-cm-env.yaml
x harbor/templates/exporter/exporter-dpl.yaml
x harbor/templates/exporter/exporter-secret.yaml
x harbor/templates/exporter/exporter-svc.yaml
x harbor/templates/ingress/ingress.yaml
x harbor/templates/ingress/secret.yaml
x harbor/templates/internal/auto-tls.yaml
x harbor/templates/jobservice/jobservice-cm-env.yaml
x harbor/templates/jobservice/jobservice-cm.yaml
x harbor/templates/jobservice/jobservice-dpl.yaml
x harbor/templates/jobservice/jobservice-pvc.yaml
x harbor/templates/jobservice/jobservice-secrets.yaml
x harbor/templates/jobservice/jobservice-svc.yaml
x harbor/templates/jobservice/jobservice-tls.yaml
x harbor/templates/metrics/metrics-svcmon.yaml
x harbor/templates/nginx/configmap-http.yaml
x harbor/templates/nginx/configmap-https.yaml
x harbor/templates/nginx/deployment.yaml
x harbor/templates/nginx/secret.yaml
x harbor/templates/nginx/service.yaml
x harbor/templates/notary/notary-secret.yaml
x harbor/templates/notary/notary-server.yaml
x harbor/templates/notary/notary-signer.yaml
x harbor/templates/notary/notary-svc.yaml
x harbor/templates/portal/configmap.yaml
x harbor/templates/portal/deployment.yaml
x harbor/templates/portal/service.yaml
x harbor/templates/portal/tls.yaml
x harbor/templates/redis/service.yaml
x harbor/templates/redis/statefulset.yaml
x harbor/templates/registry/registry-cm.yaml
x harbor/templates/registry/registry-dpl.yaml
x harbor/templates/registry/registry-pvc.yaml
x harbor/templates/registry/registry-secret.yaml
x harbor/templates/registry/registry-svc.yaml
x harbor/templates/registry/registry-tls.yaml
x harbor/templates/trivy/trivy-secret.yaml
x harbor/templates/trivy/trivy-sts.yaml
x harbor/templates/trivy/trivy-svc.yaml
x harbor/templates/trivy/trivy-tls.yaml
x harbor/.helmignore
x harbor/LICENSE
x harbor/README.md
x harbor/cert/tls.crt
x harbor/cert/tls.key
x harbor/conf/notary-server.json
x harbor/conf/notary-signer.json
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> mv harbor harbor-1.7.0    
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> dir

    Directory: C:\workspace\AzureBasic\2.AKS\GitOps\harbor

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----        2022-02-27 오전 11:30                harbor-1.4.1
d----        2022-02-27  오후 2:35                harbor-1.7.0
d----        2022-02-27 오후 12:31                harbor-1.8.1
d----        2022-02-27  오후 1:16                harbor-11.2.4
-a---        2022-02-27 오전 11:29          43344 harbor-1.4.1.tgz
-a---        2022-02-27  오후 2:35          48691 harbor-1.7.0.tgz
-a---        2022-02-26  오후 5:47          50207 harbor-1.8.1.tgz
-a---        2022-02-27  오후 1:16         222247 harbor-11.2.4.tgz
-a---        2022-02-27 오전 11:35           1971 harbor-harbor-ingress.yaml.org
-a---        2022-02-27  오후 1:42           1961 harbor-ingress-bitnami copy.yaml
-a---        2022-02-27  오후 1:56           2194 harbor-ingress-bitnami.yaml
-a---        2022-02-27  오후 1:42           1093 harbor-ingress-notary-bitnami copy.yaml
-a---        2022-02-27  오후 1:42           1093 harbor-ingress-notary-bitnami.yaml
-a---        2022-02-26 오후 11:56            999 harbor-ingress-notary.yaml
-a---        2022-02-27 오후 12:36           1037 harbor-ingress-notary.yaml.org
-a---        2022-02-27 오후 12:40           1843 harbor-ingress.yaml
-a---        2022-02-27  오후 1:00           2013 harbor-ingress.yaml.org
-a---        2022-02-27  오후 1:35          12379 README.md

PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> cd harbor-1.7.0    
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> cp values.yaml values.yaml.org
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> helm install harbor --debug -f values.yaml -n cicd .       
install.go:178: [debug] Original chart version: ""
install.go:195: [debug] CHART PATH: C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0

client.go:128: [debug] creating 40 resource(s)
NAME: harbor
LAST DEPLOYED: Sun Feb 27 14:38:33 2022
NAMESPACE: cicd
STATUS: deployed
REVISION: 1
TEST SUITE: None
USER-SUPPLIED VALUES:
caSecretName: ""
chartmuseum:
  absoluteUrl: false
  affinity: {}
  automountServiceAccountToken: false
  enabled: true
  image:
    repository: goharbor/chartmuseum-photon
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  priorityClassName: null
  replicas: 1
  serviceAccountName: ""
  tolerations: []
core:
  affinity: {}
  automountServiceAccountToken: false
  image:
    repository: goharbor/harbor-core
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  priorityClassName: null
  replicas: 1
  secret: ""
  secretName: ""
  serviceAccountName: ""
  startupProbe:
    enabled: true
    initialDelaySeconds: 10
  tolerations: []
  xsrfKey: ""
database:
  external:
    coreDatabase: registry
    host: 192.168.0.1
    notaryServerDatabase: notary_server
    notarySignerDatabase: notary_signer
    password: password
    port: "5432"
    sslmode: disable
    username: user
  internal:
    affinity: {}
    automountServiceAccountToken: false
    image:
      repository: goharbor/harbor-db
      tag: v2.3.0
    initContainer:
      migrator: {}
      permissions: {}
    nodeSelector: {}
    password: changeit
    priorityClassName: null
    serviceAccountName: ""
    shmSizeLimit: 512Mi
    tolerations: []
  maxIdleConns: 100
  maxOpenConns: 900
  podAnnotations: {}
  type: internal
exporter:
  affinity: {}
  automountServiceAccountToken: false
  cacheCleanInterval: 14400
  cacheDuration: 23
  image:
    repository: goharbor/harbor-exporter
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  priorityClassName: null
  replicas: 1
  serviceAccountName: ""
  tolerations: []
expose:
  clusterIP:
    annotations: {}
    name: harbor
    ports:
      httpPort: 80
      httpsPort: 443
      notaryPort: 4443
  ingress:
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt
      ingress.kubernetes.io/proxy-body-size: "0"
      ingress.kubernetes.io/ssl-redirect: "true"
      kubernetes.io/ingress.class: nginx
      nginx.ingress.kubernetes.io/proxy-body-size: "0"
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
    controller: default
    harbor:
      annotations: {}
    hosts:
      core: harbor.nodespringboot.org
      notary: notary.nodespringboot.org
    notary:
      annotations: {}
  loadBalancer:
    IP: ""
    annotations: {}
    name: harbor
    ports:
      httpPort: 80
      httpsPort: 443
      notaryPort: 4443
    sourceRanges: []
  nodePort:
    name: harbor
    ports:
      http:
        nodePort: 30002
        port: 80
      https:
        nodePort: 30003
        port: 443
      notary:
        nodePort: 30004
        port: 4443
  tls:
    auto:
      commonName: ""
    certSource: auto
    enabled: true
    secret:
      notarySecretName: ""
      secretName: ""
  type: ingress
externalURL: https://harbor.nodespringboot.org
harborAdminPassword: dlatl!00
imagePullPolicy: IfNotPresent
imagePullSecrets: null
internalTLS:
  certSource: auto
  chartmuseum:
    crt: ""
    key: ""
    secretName: ""
  core:
    crt: ""
    key: ""
    secretName: ""
  enabled: false
  jobservice:
    crt: ""
    key: ""
    secretName: ""
  portal:
    crt: ""
    key: ""
    secretName: ""
  registry:
    crt: ""
    key: ""
    secretName: ""
  trivy:
    crt: ""
    key: ""
    secretName: ""
  trustCa: ""
jobservice:
  affinity: {}
  automountServiceAccountToken: false
  image:
    repository: goharbor/harbor-jobservice
    tag: v2.3.0
  jobLoggers:
  - file
  maxJobWorkers: 10
  nodeSelector: {}
  podAnnotations: {}
  priorityClassName: null
  replicas: 1
  secret: ""
  serviceAccountName: ""
  tolerations: []
logLevel: info
metrics:
  core:
    path: /metrics
    port: 8001
  enabled: false
  exporter:
    path: /metrics
    port: 8001
  jobservice:
    path: /metrics
    port: 8001
  registry:
    path: /metrics
    port: 8001
  serviceMonitor:
    additionalLabels: {}
    enabled: false
    interval: ""
    metricRelabelings: []
    relabelings: []
nginx:
  affinity: {}
  automountServiceAccountToken: false
  image:
    repository: goharbor/nginx-photon
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  priorityClassName: null
  replicas: 1
  serviceAccountName: ""
  tolerations: []
notary:
  enabled: true
  secretName: ""
  server:
    affinity: {}
    automountServiceAccountToken: false
    image:
      repository: goharbor/notary-server-photon
      tag: v2.3.0
    nodeSelector: {}
    podAnnotations: {}
    priorityClassName: null
    replicas: 1
    serviceAccountName: ""
    tolerations: []
  signer:
    affinity: {}
    automountServiceAccountToken: false
    image:
      repository: goharbor/notary-signer-photon
      tag: v2.3.0
    nodeSelector: {}
    podAnnotations: {}
    priorityClassName: null
    replicas: 1
    serviceAccountName: ""
    tolerations: []
persistence:
  enabled: true
  imageChartStorage:
    azure:
      accountkey: base64encodedaccountkey
      accountname: accountname
      container: containername
    disableredirect: false
    filesystem:
      rootdirectory: /storage
    gcs:
      bucket: bucketname
      encodedkey: base64-encoded-json-key-file
    oss:
      accesskeyid: accesskeyid
      accesskeysecret: accesskeysecret
      bucket: bucketname
      region: regionname
    s3:
      bucket: bucketname
      region: us-west-1
    swift:
      authurl: https://storage.myprovider.com/v3/auth
      container: containername
      password: password
      username: username
    type: filesystem
  persistentVolumeClaim:
    chartmuseum:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 5Gi
      storageClass: ""
      subPath: ""
    database:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 1Gi
      storageClass: ""
      subPath: ""
    jobservice:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 1Gi
      storageClass: ""
      subPath: ""
    redis:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 1Gi
      storageClass: ""
      subPath: ""
    registry:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 5Gi
      storageClass: ""
      subPath: ""
    trivy:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 5Gi
      storageClass: ""
      subPath: ""
  resourcePolicy: keep
portal:
  affinity: {}
  automountServiceAccountToken: false
  image:
    repository: goharbor/harbor-portal
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  priorityClassName: null
  replicas: 1
  serviceAccountName: ""
  tolerations: []
proxy:
  components:
  - core
  - jobservice
  - trivy
  httpProxy: null
  httpsProxy: null
  noProxy: 127.0.0.1,localhost,.local,.internal
redis:
  external:
    addr: 192.168.0.2:6379
    chartmuseumDatabaseIndex: "3"
    coreDatabaseIndex: "0"
    jobserviceDatabaseIndex: "1"
    password: ""
    registryDatabaseIndex: "2"
    sentinelMasterSet: ""
    trivyAdapterIndex: "5"
  internal:
    affinity: {}
    automountServiceAccountToken: false
    image:
      repository: goharbor/redis-photon
      tag: v2.3.0
    nodeSelector: {}
    priorityClassName: null
    serviceAccountName: ""
    tolerations: []
  podAnnotations: {}
  type: internal
registry:
  affinity: {}
  automountServiceAccountToken: false
  controller:
    image:
      repository: goharbor/harbor-registryctl
      tag: v2.3.0
  credentials:
    htpasswd: harbor_registry_user:$2y$10$9L4Tc0DJbFFMB6RdSCunrOpTHdwhid4ktBJmLD00bYgqkkGOvll3m
    password: harbor_registry_password
    username: harbor_registry_user
  middleware:
    cloudFront:
      baseurl: example.cloudfront.net
      duration: 3000s
      ipfilteredby: none
      keypairid: KEYPAIRID
      privateKeySecret: my-secret
    enabled: false
    type: cloudFront
  nodeSelector: {}
  podAnnotations: {}
  priorityClassName: null
  registry:
    image:
      repository: goharbor/registry-photon
      tag: v2.3.0
  relativeurls: false
  replicas: 1
  secret: ""
  serviceAccountName: ""
  tolerations: []
secretKey: not-a-secure-key
trivy:
  affinity: {}
  automountServiceAccountToken: false
  debugMode: false
  enabled: true
  gitHubToken: ""
  ignoreUnfixed: false
  image:
    repository: goharbor/trivy-adapter-photon
    tag: v2.3.0
  insecure: false
  nodeSelector: {}
  podAnnotations: {}
  priorityClassName: null
  replicas: 1
  resources:
    limits:
      cpu: 1
      memory: 1Gi
    requests:
      cpu: 200m
      memory: 512Mi
  serviceAccountName: ""
  severity: UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL
  skipUpdate: false
  tolerations: []
  vulnType: os,library
updateStrategy:
  type: RollingUpdate

COMPUTED VALUES:
caSecretName: ""
chartmuseum:
  absoluteUrl: false
  affinity: {}
  automountServiceAccountToken: false
  enabled: true
  image:
    repository: goharbor/chartmuseum-photon
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  replicas: 1
  serviceAccountName: ""
  tolerations: []
core:
  affinity: {}
  automountServiceAccountToken: false
  image:
    repository: goharbor/harbor-core
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  replicas: 1
  secret: ""
  secretName: ""
  serviceAccountName: ""
  startupProbe:
    enabled: true
    initialDelaySeconds: 10
  tolerations: []
  xsrfKey: ""
database:
  external:
    coreDatabase: registry
    host: 192.168.0.1
    notaryServerDatabase: notary_server
    notarySignerDatabase: notary_signer
    password: password
    port: "5432"
    sslmode: disable
    username: user
  internal:
    affinity: {}
    automountServiceAccountToken: false
    image:
      repository: goharbor/harbor-db
      tag: v2.3.0
    initContainer:
      migrator: {}
      permissions: {}
    nodeSelector: {}
    password: changeit
    serviceAccountName: ""
    shmSizeLimit: 512Mi
    tolerations: []
  maxIdleConns: 100
  maxOpenConns: 900
  podAnnotations: {}
  type: internal
exporter:
  affinity: {}
  automountServiceAccountToken: false
  cacheCleanInterval: 14400
  cacheDuration: 23
  image:
    repository: goharbor/harbor-exporter
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  replicas: 1
  serviceAccountName: ""
  tolerations: []
expose:
  clusterIP:
    annotations: {}
    name: harbor
    ports:
      httpPort: 80
      httpsPort: 443
      notaryPort: 4443
  ingress:
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt
      ingress.kubernetes.io/proxy-body-size: "0"
      ingress.kubernetes.io/ssl-redirect: "true"
      kubernetes.io/ingress.class: nginx
      nginx.ingress.kubernetes.io/proxy-body-size: "0"
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
    controller: default
    harbor:
      annotations: {}
    hosts:
      core: harbor.nodespringboot.org
      notary: notary.nodespringboot.org
    notary:
      annotations: {}
  loadBalancer:
    IP: ""
    annotations: {}
    name: harbor
    ports:
      httpPort: 80
      httpsPort: 443
      notaryPort: 4443
    sourceRanges: []
  nodePort:
    name: harbor
    ports:
      http:
        nodePort: 30002
        port: 80
      https:
        nodePort: 30003
        port: 443
      notary:
        nodePort: 30004
        port: 4443
  tls:
    auto:
      commonName: ""
    certSource: auto
    enabled: true
    secret:
      notarySecretName: ""
      secretName: ""
  type: ingress
externalURL: https://harbor.nodespringboot.org
harborAdminPassword: dlatl!00
imagePullPolicy: IfNotPresent
internalTLS:
  certSource: auto
  chartmuseum:
    crt: ""
    key: ""
    secretName: ""
  core:
    crt: ""
    key: ""
    secretName: ""
  enabled: false
  jobservice:
    crt: ""
    key: ""
    secretName: ""
  portal:
    crt: ""
    key: ""
    secretName: ""
  registry:
    crt: ""
    key: ""
    secretName: ""
  trivy:
    crt: ""
    key: ""
    secretName: ""
  trustCa: ""
jobservice:
  affinity: {}
  automountServiceAccountToken: false
  image:
    repository: goharbor/harbor-jobservice
    tag: v2.3.0
  jobLoggers:
  - file
  maxJobWorkers: 10
  nodeSelector: {}
  podAnnotations: {}
  replicas: 1
  secret: ""
  serviceAccountName: ""
  tolerations: []
logLevel: info
metrics:
  core:
    path: /metrics
    port: 8001
  enabled: false
  exporter:
    path: /metrics
    port: 8001
  jobservice:
    path: /metrics
    port: 8001
  registry:
    path: /metrics
    port: 8001
  serviceMonitor:
    additionalLabels: {}
    enabled: false
    interval: ""
    metricRelabelings: []
    relabelings: []
nginx:
  affinity: {}
  automountServiceAccountToken: false
  image:
    repository: goharbor/nginx-photon
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  replicas: 1
  serviceAccountName: ""
  tolerations: []
notary:
  enabled: true
  secretName: ""
  server:
    affinity: {}
    automountServiceAccountToken: false
    image:
      repository: goharbor/notary-server-photon
      tag: v2.3.0
    nodeSelector: {}
    podAnnotations: {}
    replicas: 1
    serviceAccountName: ""
    tolerations: []
  signer:
    affinity: {}
    automountServiceAccountToken: false
    image:
      repository: goharbor/notary-signer-photon
      tag: v2.3.0
    nodeSelector: {}
    podAnnotations: {}
    replicas: 1
    serviceAccountName: ""
    tolerations: []
persistence:
  enabled: true
  imageChartStorage:
    azure:
      accountkey: base64encodedaccountkey
      accountname: accountname
      container: containername
    disableredirect: false
    filesystem:
      rootdirectory: /storage
    gcs:
      bucket: bucketname
      encodedkey: base64-encoded-json-key-file
    oss:
      accesskeyid: accesskeyid
      accesskeysecret: accesskeysecret
      bucket: bucketname
      region: regionname
    s3:
      bucket: bucketname
      region: us-west-1
    swift:
      authurl: https://storage.myprovider.com/v3/auth
      container: containername
      password: password
      username: username
    type: filesystem
  persistentVolumeClaim:
    chartmuseum:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 5Gi
      storageClass: ""
      subPath: ""
    database:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 1Gi
      storageClass: ""
      subPath: ""
    jobservice:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 1Gi
      storageClass: ""
      subPath: ""
    redis:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 1Gi
      storageClass: ""
      subPath: ""
    registry:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 5Gi
      storageClass: ""
      subPath: ""
    trivy:
      accessMode: ReadWriteOnce
      existingClaim: ""
      size: 5Gi
      storageClass: ""
      subPath: ""
  resourcePolicy: keep
portal:
  affinity: {}
  automountServiceAccountToken: false
  image:
    repository: goharbor/harbor-portal
    tag: v2.3.0
  nodeSelector: {}
  podAnnotations: {}
  replicas: 1
  serviceAccountName: ""
  tolerations: []
proxy:
  components:
  - core
  - jobservice
  - trivy
  noProxy: 127.0.0.1,localhost,.local,.internal
redis:
  external:
    addr: 192.168.0.2:6379
    chartmuseumDatabaseIndex: "3"
    coreDatabaseIndex: "0"
    jobserviceDatabaseIndex: "1"
    password: ""
    registryDatabaseIndex: "2"
    sentinelMasterSet: ""
    trivyAdapterIndex: "5"
  internal:
    affinity: {}
    automountServiceAccountToken: false
    image:
      repository: goharbor/redis-photon
      tag: v2.3.0
    nodeSelector: {}
    serviceAccountName: ""
    tolerations: []
  podAnnotations: {}
  type: internal
registry:
  affinity: {}
  automountServiceAccountToken: false
  controller:
    image:
      repository: goharbor/harbor-registryctl
      tag: v2.3.0
  credentials:
    htpasswd: harbor_registry_user:$2y$10$9L4Tc0DJbFFMB6RdSCunrOpTHdwhid4ktBJmLD00bYgqkkGOvll3m
    password: harbor_registry_password
    username: harbor_registry_user
  middleware:
    cloudFront:
      baseurl: example.cloudfront.net
      duration: 3000s
      ipfilteredby: none
      keypairid: KEYPAIRID
      privateKeySecret: my-secret
    enabled: false
    type: cloudFront
  nodeSelector: {}
  podAnnotations: {}
  registry:
    image:
      repository: goharbor/registry-photon
      tag: v2.3.0
  relativeurls: false
  replicas: 1
  secret: ""
  serviceAccountName: ""
  tolerations: []
secretKey: not-a-secure-key
trivy:
  affinity: {}
  automountServiceAccountToken: false
  debugMode: false
  enabled: true
  gitHubToken: ""
  ignoreUnfixed: false
  image:
    repository: goharbor/trivy-adapter-photon
    tag: v2.3.0
  insecure: false
  nodeSelector: {}
  podAnnotations: {}
  replicas: 1
  resources:
    limits:
      cpu: 1
      memory: 1Gi
    requests:
      cpu: 200m
      memory: 512Mi
  serviceAccountName: ""
  severity: UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL
  skipUpdate: false
  tolerations: []
  vulnType: os,library
updateStrategy:
  type: RollingUpdate

HOOKS:
MANIFEST:
---
# Source: harbor/templates/chartmuseum/chartmuseum-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: "harbor-chartmuseum"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
type: Opaque
data:
  CACHE_REDIS_PASSWORD: ""
---
# Source: harbor/templates/core/core-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: harbor-core
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
type: Opaque
data:
  secretKey: "bm90LWEtc2VjdXJlLWtleQ=="
  secret: "YVVsejl6QnRKNGFkbDdVUQ=="
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUUwekNDQXJ1Z0F3SUJBZ0lKQVBZL096TE1lVnEyTUEwR0NTcUdTSWIzRFFFQkN3VUFNQUF3SGhjTk1Ua3cKTkRFNE1ESXlOek0zV2hjTk1qa3dOREUxTURJeU56TTNXakFBTUlJQ0lqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQwpBZzhBTUlJQ0NnS0NBZ0VBM3hsVUpzMmIvYUkyTkxveTRPSVErZG4veU1iL085OWlLRFJ5WktwSDhyU09tUytvCkY5dW5tU0F6TDY1WEEvdjZuWTBPTEkvZEFTRGprcWtCcElkVEd6b2dSNWY4VWlCNm9zdUVZN1Y3MVhaZHpXTHIKUGpuSnE2WkxBYW9LbXdHODBXNStXZDZWOFB5Z094NTJta3IxdzdJV0t6KzFaTEk1aXpicHBvbjdYVkdWUmFBVApSdk5aRGlKNkNlSnBjSjVINzIzbGtmNVJ2SldhdFpMQ1lJWURiUmZUaUtzeVEvU2xSY3Y1QlZmSGcvTEpTSDlRCkxHUmhQTUFSbGRsOXd5WkN3WlpESHhoZUk0YSsyNmFhOE1ZM3U5c3QvbDAvT282VkNUR3BNaUVoaUdGMkxWanAKVVdxLytCUDRTRkV2SmZxL0R1aW5JMTM5Vy81YVpaNy9Id1JQbG1ZVTZwWFRSTHlJZzdqZCsxOWZKd1I3WDM3cQp3MG84dDA2RmhqbXJDemFZQ1Vqb1JlcURtSGFObVpOL2Rkdkc3alpXQnUrak5oMFlhdnN5UXlDSVZtdjZ5cVNjCmpQaUQ5dWl2eHFUd2pKaWRJQlJmdVVyejNhRVJRN2NRZ2YwcWhxakl6Zmx6SGJGS2hJTG9jQldxN3p5Tmw5aHIKdlVHVC9XWmN3MHQvT3RNNzJTUGFwbG1UZ1ZiYlFSeGYyVkh6eXB0R0l2dHlkbFhLOHRoeE9NcFhvNGUrU2w4ZAoxZ2RRY0M0b2lzTjlGMjlvTnM4UDV5RlFQLy94WXV2OEM2MDduQ2oxRHpySWQ1YXZHL05WZktCL2ZiREtFRmdOCjJXaEhJblR6UExFY2pGNGZFcmNVQUV1V1cwYnVYLzZGSENHM2lUdHJxeUQ5MktUVkRmTjFKNTZycmNzQ0F3RUEKQWFOUU1FNHdIUVlEVlIwT0JCWUVGRmhOaFRvNFVBQzJQVXNmOGpZYVdqMTYwdkdFTUI4R0ExVWRJd1FZTUJhQQpGRmhOaFRvNFVBQzJQVXNmOGpZYVdqMTYwdkdFTUF3R0ExVWRFd1FGTUFNQkFmOHdEUVlKS29aSWh2Y05BUUVMCkJRQURnZ0lCQU1Bc0V0VmxFTE13ZHRjaWZIZU9UMGtPbWY1d285SW4vZUZTZ3NjQ3pCTURhUngyQjNxMzZBb1MKSWw3WFdBWnBldmFSN1c3eWVBUkthQXNoQkxoeWdVcUxEMHpXYktsU045SHByZDF3ZHBNMGZmeVBwTjVkeE9ZQQplcjA0eTEyR1JuQ2JNWXFpNGN2enRQNFRpblhxcTJ5SFNZaExiTzlxa0k1Z2JXVnhrUnVJY01Ldml4ZGRsbE5ZClEzb2JKYURESG1vdk0zK2cvRysxWUZndDRxRVMzOFhuSjdCclNzaEhubjVFSVFoMjg2eGZKcml5cksyaEhiTEoKcXowWXVGNkczRFhQZVdHZ1h2ajBIaXBjMGY4VURaa0tray9lR0VJNnZFa3l0eXZvZXBvWkkyWGJBZi9aTXk1bgpLd3VoRW40aGhrRk13V2FTV3AvaDBRZE1DYXhrNEJWU09xbU5WYUxTQjcrRmpzSWo0Q2FzRm90WWl5SjJncFJCCk5mOFFhUzRiejBUbjFlQmJDOGtzaitlM1pXZVgyYjV3Vk1qcWw5alR0MlgxSUNzOEtLZTN2RUJranFUMkFVaTIKNTJUdEt6bTczYVdyei9HUHkvUTJMQ29yM0ZoOUZHVlNCT0JCRFhHeTZNSnBOSEpuWVZIOUVFTkZHT2g4NW9sMQoycEFET0JCNXZBVS9rTEI1TEhQajJrdWUvRk1pSGFObnJTWUlHck1sQlNYMmpqOUVZYTF1dVVIK3BkNE1CajFGCjV1SDhPUmlhUTZodDIrV0hrbHhpYzFSajV5VFlRd1ZsSDcwQ0JPbitxVkVkbzYzeVF3ekFNSktGSXdsR1VRRVgKamlsamdjODZxNGNadFVURnJjd01pZGJrKzhRNitKYkRWZzdIVi8rcG5DK3dudjE5N2t3ZQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
  tls.key: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKS1FJQkFBS0NBZ0VBM3hsVUpzMmIvYUkyTkxveTRPSVErZG4veU1iL085OWlLRFJ5WktwSDhyU09tUytvCkY5dW5tU0F6TDY1WEEvdjZuWTBPTEkvZEFTRGprcWtCcElkVEd6b2dSNWY4VWlCNm9zdUVZN1Y3MVhaZHpXTHIKUGpuSnE2WkxBYW9LbXdHODBXNStXZDZWOFB5Z094NTJta3IxdzdJV0t6KzFaTEk1aXpicHBvbjdYVkdWUmFBVApSdk5aRGlKNkNlSnBjSjVINzIzbGtmNVJ2SldhdFpMQ1lJWURiUmZUaUtzeVEvU2xSY3Y1QlZmSGcvTEpTSDlRCkxHUmhQTUFSbGRsOXd5WkN3WlpESHhoZUk0YSsyNmFhOE1ZM3U5c3QvbDAvT282VkNUR3BNaUVoaUdGMkxWanAKVVdxLytCUDRTRkV2SmZxL0R1aW5JMTM5Vy81YVpaNy9Id1JQbG1ZVTZwWFRSTHlJZzdqZCsxOWZKd1I3WDM3cQp3MG84dDA2RmhqbXJDemFZQ1Vqb1JlcURtSGFObVpOL2Rkdkc3alpXQnUrak5oMFlhdnN5UXlDSVZtdjZ5cVNjCmpQaUQ5dWl2eHFUd2pKaWRJQlJmdVVyejNhRVJRN2NRZ2YwcWhxakl6Zmx6SGJGS2hJTG9jQldxN3p5Tmw5aHIKdlVHVC9XWmN3MHQvT3RNNzJTUGFwbG1UZ1ZiYlFSeGYyVkh6eXB0R0l2dHlkbFhLOHRoeE9NcFhvNGUrU2w4ZAoxZ2RRY0M0b2lzTjlGMjlvTnM4UDV5RlFQLy94WXV2OEM2MDduQ2oxRHpySWQ1YXZHL05WZktCL2ZiREtFRmdOCjJXaEhJblR6UExFY2pGNGZFcmNVQUV1V1cwYnVYLzZGSENHM2lUdHJxeUQ5MktUVkRmTjFKNTZycmNzQ0F3RUEKQVFLQ0FnRUFrOHE4czRQcnZZYnk3OVVWbFdKTktxY2V5a3dCa3hFMWZqcllPUldRMmhpQWlyeEdWNSs4bERULwprNnVqbTFFV3diNUswSHh4UktrYitQRWExSHFOTkhFNkp4TnBKS0s5ZXhEbFlBUSt4N2RGQnFWci8ybmF6bW80Ck1COE1MWWxtSXp0V1dvU1l3ZThvMm1FZzRxK2J4WXM1SW1kdTdBa2hFN2RKNjNobTIzZ0xNZmVNTGFsUnFvcHUKWEJQd0U1blhQNmFHdVVOSHRHMUs4dFFKRGxaWStMRWJBZU9mUmVOUWhUOU5kUnVrWVNXNTc5dmZLYmxKclN2egp1bGc4OXNWbTNjV0VLNXBCNnJqOXdKYks5NHZvS2Z0VnFiYnVCd1dqZDFhOXBpYktod1ZCZTJMMkZXaHBTWmM1CkYvY29DN25qVGFZVDZ0cjkxeTVWaGhKaElaUUNmL3Z2NFpsNVhoRkhzNVZUWk5iTS9PZnF5RlFMWVhWSk80OEsKRjd0bWF6QUVRUUJRd1ZacUg5QzlOUWR6UEhXbWMzOE9raHRjMXd6YXFuL3JnOSsxc2dBTUQ4aFdDdFFKVWU5NwpiOXltaDVBMFo0UVhLcHlGVDBiK3BYY0QxalJoYTA3VXRrWCsvekxKOUhwQVhjVW16a0crajVDWE5wbnhzSXE1CmZKRmVxM2hCajl3Nm40aCs1ME00VzBGc2U1WW9FVXNjM0IwZno4QmxRQmIrWUpMRkxOSDM0TUg4cDFsMFpEWUoKeWFlMHBzeGxCaWpnNE9QWitXQ0JhK2p0Rlc0TGlXZ0VjeHdnejh3K2hFT0FRcjJhMURjN3c4amQrWTRJSzhVbQpsVFZzNWRicDRtT21QTWxSdi9HTTdrRHVkRnFiTWczWUZ3WGczUWJxdVZxTFp6RXpqVmtDZ2dFQkFQSktaYkNXCllmTGVqa1MvZmtSeVYzVkliNTRtS3dRSG9NV3ViODh0UGdHdVh6anNKeWQ1UVRRNThQcFVqWHJMSG1uOGxTMisKdmlFOEdKeWxLd04xeU1sWnc0MCtrWmhwSFVwQ1d4LzJaS2pBcXZxQTlPT0tvMmZ2NkhkL3dPQW5VNEN0aW9DMQpwcmk3bEtGWVhvUDhEdFFWd0hZdkl6Q1JxRG5oYzRtd0pEcXpUQzl4ZHVJK3N2eHpsNHhIODJmeDBqclBpRlkrCi93T2RYanlmSVBqeWhIQzRqUFRXYmFpcndYUzlkQmpTbDEyOGFJUlQ1ODAveVhFL1NZQXVnZzA1akt0ZzV6UUEKU28xM01UZXpYUkhYZE8wZGkzdEVNSEdSRUVrRnBlVm5uUFF2Q0NlZEswRFYzNmlOd2lXYzhwd2RmTE1WbmVUdApES3daZWRDeCtvLzdldjBDZ2dFQkFPdTQ4REdFSkpKekh4VlI1bVkxSzJBbFp5WXRwVE9XZWhLMXpYNzRKdk0zCll4TjRuZCtaeDVuOXVTUG1tS3pxRjNUVSs0NFJWdGRKSzZlam9GRThkTURUTldhU0xXL1pEbU4xblQwbmp2T24KSVdKbjU5eW5PQ2hXV0taZ1haLzlVcUdSN1B0Nk94U2trZXg5Yy9mWUJzTVgveHVzZFhRaWdlb2dsMGlPWVZGVwpnWElpaUxSTEhwSEpzSy91TnhJaXpqMGhUWVluN3VEN1BSRU53RlJjQ1lmOEoxZVVGYmQ2RHVDVldlUUNLV2dmCk5kMnRTV29pMFZ5bGo0dVVYOEl3MHRqTE5NRDVDUkVKRWs0R1N2NEVEU212VWR2MUxpQktKQ0wybEVjZ29QZUMKb09EMmlDYzVLcWdubVFyYVJpbEZGazhSVlhBOVBXWkdZM0MwYjZUVm1tY0NnZ0VBTlpPMkFPS0FMbENBYlR0YgpGSStrUDA4UlA0dDVINThBTWpac2l3ZWFHbzBRaVduUERxK0ZkNk1JWXBLbjVtdGNBbHZVTVJWb3ZiaW9TSnROCmM2cHNCL3BOZjhKQ044Mm1xSEViN1dseXdNNDZBTUxiWkNXWUZMZThWQkJ2K2lFNEdkQkdQRWZ1NGhLNHZ5VG4KWVpBdlJ6NjRIR280QWRsenRiamc3NlYvbld0Z2dXMDV1TFhjcG01NUtKQVFodisyV1VMakJ3OVBIT0dEb1N3ZgpBbTIrVTU2N3JMaHQ3MHByc1FEajEwbGFKMlF1U0hTMVlYR2xmZUZjdzNlRlVwOVROK0pwdmRvQ29sMmxDSWdsCklIamdaajZPUldmQ3Zwb3hXN1JnQnVadWtxQ0QwUjYwSGRZdGF2eE4zanRpZXBzYXBBODNweE8wSmFwTWdaV1oKcnBVUmtRS0NBUUJPY0V2OUxpdTlUL0dYOXBqa2llelZJWjBoWnk4QjY2RFRlUXZZcEZyUnRDeVQzaDhxdU5GaQp2THRPNXYwSERSNmhFZjVqV0FHOXdldDA3VTM3dWxKZmwraTlLUWRWb0xUWkE5bys3MXJ5V1RzU3MrREQzQ0VqCnl4ZlV4VnhpVUxtZWFpQ2h6aHE2MDhoN0dZUHRoVVU2eGxGdHRBV2hqNW9MZnF6WXlBZzZPTDc2YStOeG0wMmcKMWF5bDNtOFU2ZUFYRjIza3BvVW0rSE5wcVZuR3VKbXpWb1VBNzVZS1orTnJlRWRoU0JiZlB3TjlzSnd0WlVpbAp1N0g0a0hjTTk1SXg4ZXlzQ2pLcUtJcWV6QmxJVGJEVG5qTnZMamNiSjVDKzBhNmx2SVhUMXZRUjUvZUdsYzlNCkJXRTM2MHBOa1YvTEQ4bU9mOUplcGkyUTQzb0RMOUVoQW9JQkFRRFRXSW1meTBLOWdHekEyclB5MTY5bVdZUUsKT2xjbkQzK2hRcTZ4NTFabjFlL3RleEZlVmxoSG40cnJuUmRDRk9BcDQ3dUZrSjJtNzJHQ1ZENzRFd1F1Y0s5eQpBRDVqb3JxZ1ZIcUNLWmRrSGpiMlY2ME16bTZnM3J0TDlXSlhGVkx2TkJiL1FHQjJ2Z0hWT08wenFpcUdaajRlCkV4N2wybS8vNVNFNERMdG43MEo5Q2dHMUh0WENTOGRXckdQTDFwekRuazhWWHRub1h6YjBMQ2hMVUZFZ1pSbWgKY1Y2QUZIRUsySDh3Qkh2aU55ZWhzUlFpRGtsMkFpV09jSk52a3pXNjhjazJuSmpSV3lQWUsxSkwzTkNLcEIzUQpPb2hyUDBmSGNXQVhNVzk3d0ZYWmhSZm5RZkR4eElPbGozTWNZVDBBbGFuWGQwRjROR2MyTnZtcGh4MDQKLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K
  HARBOR_ADMIN_PASSWORD: "ZGxhdGwhMDA="
  POSTGRESQL_PASSWORD: "Y2hhbmdlaXQ="
  REGISTRY_CREDENTIAL_PASSWORD: "aGFyYm9yX3JlZ2lzdHJ5X3Bhc3N3b3Jk"
  CSRF_KEY: "ZzdmZXF3MGZtbEUyd1Njb2JIVXhORk9MVHFDNEw4OTk="
---
# Source: harbor/templates/database/database-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: "harbor-database"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
type: Opaque
data:
  POSTGRES_PASSWORD: "Y2hhbmdlaXQ="
---
# Source: harbor/templates/ingress/secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: "harbor-ingress"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
type: kubernetes.io/tls
data:
  tls.crt: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURaVENDQWsyZ0F3SUJBZ0lRT3N3Z250YXZwL1Q4SVoxZE5EM3h1ekFOQmdrcWhraUc5dzBCQVFzRkFEQVUKTVJJd0VBWURWUVFERXdsb1lYSmliM0l0WTJFd0hoY05Nakl3TWpJM01EVXpPRE0wV2hjTk1qTXdNakkzTURVegpPRE0wV2pBa01TSXdJQVlEVlFRREV4bG9ZWEppYjNJdWJtOWtaWE53Y21sdVoySnZiM1F1YjNKbk1JSUJJakFOCkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQXpueXlhQllvcTljMGw2dThlTE5mNHNic201eXUKdEtyMUJ3aXdPd1lleTdheTBQa2tPcXVwb29SM21USVlabWhGaVFMUkNHVnU1Mm92aDIvTk1UVDlMOTZyRExVSQpIRWxMNW5jTGc5NjhvVEhBRjNHMzcxRzB5RVgxZmowQnlmTUlrdXE4WWtHTHR0a2Z0bFlraG9ZQXkyYjN2WjNHCllBaHRqWTA4WTRneVpUK1FwMHZQQVBqcnZMVkplYUUzU3Z6dTl0bUVtbHhpT3BMdlhKUmE3Und1VCtjVWhEYnkKUTVNRkx5SStpZm5GWS9rYlU3aENVUm11ak5QUXpEbHBiL3N6cW9wa0d6S0tLQU41YXdGRHpOc2dFSDl4Vk5CbgpUVXBwZ08zUHhjdXFWTFYrWVdvNTd6QzllN053K2MxQm42MWkvdVcxYTRRY3lGRUxkRFFBaHY2dml3SURBUUFCCm80R2lNSUdmTUE0R0ExVWREd0VCL3dRRUF3SUZvREFkQmdOVkhTVUVGakFVQmdnckJnRUZCUWNEQVFZSUt3WUIKQlFVSEF3SXdEQVlEVlIwVEFRSC9CQUl3QURBZkJnTlZIU01FR0RBV2dCUjFldFM4aWFrSXBhdGZLeWlCZW9xSgp4MEZ6Z1RBL0JnTlZIUkVFT0RBMmdobG9ZWEppYjNJdWJtOWtaWE53Y21sdVoySnZiM1F1YjNKbmdobHViM1JoCmNua3VibTlrWlhOd2NtbHVaMkp2YjNRdWIzSm5NQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUFaSGlBckpXNmwKc2p3RDFidXVJRVVpZXM5RVVnZTFMOE80V3JRTTBTZFBOMks5TEtIL3pKbWpCRVFQOGhmZThDcFUxWGY3Zi9yYgp5eUw0SXU2T2RYZU0yM0RTK1lZbVpieDAwWWtGa1c1NVhQYjNNc0tBYlc0QlEyVGFGK0lMSVFQcG1KTjJoUXdCCng2ZEJMczlFNEpGNTJJOUN3RWs0eHBUdzBwV0M1YzVteUxlNGNRM2ZNT3dTVjlpOVI0eExlbjhmczFlOEt2OVQKRUw0RHJJNi9WQ1djRkRhYXVtNGxRZGZHZ2p0SmROMVJid1FtaW9ISHdnWnRaeVREalR4dnl4ZDVKYnF0THVKdwo1eTdLN1RrWVJqSHl6MTNxcDRmbytTd1dESm9ZOC8wa0xxYkNKbkJMU1I3N3RWNHZhWU9KRXlSbHlqRmFFZ0RrClQzSVJiRHJJMWJ4bAotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
  tls.key: "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBem55eWFCWW9xOWMwbDZ1OGVMTmY0c2JzbTV5dXRLcjFCd2l3T3dZZXk3YXkwUGtrCk9xdXBvb1IzbVRJWVptaEZpUUxSQ0dWdTUyb3ZoMi9OTVRUOUw5NnJETFVJSEVsTDVuY0xnOTY4b1RIQUYzRzMKNzFHMHlFWDFmajBCeWZNSWt1cThZa0dMdHRrZnRsWWtob1lBeTJiM3ZaM0dZQWh0alkwOFk0Z3laVCtRcDB2UApBUGpydkxWSmVhRTNTdnp1OXRtRW1seGlPcEx2WEpSYTdSd3VUK2NVaERieVE1TUZMeUkraWZuRlkva2JVN2hDClVSbXVqTlBRekRscGIvc3pxb3BrR3pLS0tBTjVhd0ZEek5zZ0VIOXhWTkJuVFVwcGdPM1B4Y3VxVkxWK1lXbzUKN3pDOWU3TncrYzFCbjYxaS91VzFhNFFjeUZFTGREUUFodjZ2aXdJREFRQUJBb0lCQUdWaTN1cXlycWVwbEg1QQphZHRPSCsrbXd2aXBWek1JbWlVcEEvY0hTMG0xWEZtMWF5K1BxRXhQQkxabzNZZ3kvS21JZzRDKzVWU2xVODhKCmUxUUU4NmgwaWNKRWhVWDJTMWxPN0kyRWFWUXdyR1FXaHp6di9uY3p1cFdRZVBkaTZMdlNuRXNXYWZhTzU3NU0KejhScHVhd2wwOUQ3empMTEVKZW5XSlo2Z2x3cGx2dllFMldZNWxTNEZqMG5HWDNoOTdKcURQeWVVdzlmZ1V4VwpqcHR1UFVGQmJZQVdMVm5LVTA5eXJ6eWVwc3RsYklNVExhRU5XeHJ2TE0wL1RDRTRiNEw4VzhUUExFQ0ZvNWx5Cng5Um9rVVo1WGpqUkhNOVB4UkUxTmhCRmZqOHZQbjhTNUlUUWJqNk1jcU5tVmI5NWliNVNmYkJhUzM3T0kxSE0KTE1Wbm5ia0NnWUVBN201MEpCbTF1YnU3TmpqVmp5azU2enNLT21TRDE5QzZjUE9OWnZ4Nkl0VFZndlVxSVdzdgpCMUI3am1GMis3aU44eWl1RGpkcjVyQVgvak1ISjIzUGZiU3JuTGZ6T0hYUWpNVTY3UEpUQ2dkQzFaRzdqN05zCld3U0pFbERKVXU0QmlyV2gyMlZJTy9Ud0V2blRIZktJSGgyS2lpZVBzU3dYL2JaMW1EUjhNQ2NDZ1lFQTNiT3MKeFFZY2psaW90dk9Wc0lKWWlKaHE3NStxM04zZE90eUNwVHAyRThwUTNVNlV6Ym9iU1J0UDFSMzRnb3dNWGl5Tgp5akhqTldZeHkvM3pzVnVEczJNd0VmSCtTbGIxU3N6WlllMGF3WlNHUTB1Z2Z2a3hpK21Zci9Qbkl5OFE5RVBoCmV1Y0RCM1VZc0R5em51SjZHdElZZWx3NkpMLzBOSzhSNVZ5NnYvMENnWUVBNC85UkpoaERzMGoyZTZJYmJWdUIKM0JQSDh4Q2RGcW10TDBkbWh2MlZtV3NtaEtVRjFaRVdGb3Q2cXlzK1NQVXhJRDFkTzVENXFFM3BrNVdlR0xFawpBZFBiYXZCb0x5eFI4ZHJFUDBKMTc1Z0Q3QkFBYUNpdHk5ZHBiODg2eFFkOUIvUXB3NDkxWklnVGJrSGhCTGtnCk9wUUxINU0zRDdmWGRUQ2VBSjdueG04Q2dZRUFrNXQzSWs2cFlKVGk3N3hLSTVVRlFSekp4ZlQybThzVDZvYTYKYlN2NVJiL2tDeFN3dWpCNHpqbmk4eS9iTDMvekZCaHg1dmRFSVYrRE5DQkd5Z1QyTU0rUFI4Tm8zVEg4YXVycwpxT2htY2hCalBCYjBLdFhiQ1I1a1RISUZxRVZEOG4zbmVCNnF3NkpRNTdYaW1aeU1VNk1pTFFXT3FMMHM2STdQClNYaHQxamtDZ1lBbzZpSVZVWDJPK1BTQlNwV1F2RmJhUW1JVE1CbUIxbVltSzMzdDVCaDl0U01GSlRGSGVIQzEKdDRua3hYOVgyOFEzN08vdE83Wk8yVmprWmhKTTgwcXV5UkNYNmNDL0RGNDIvWVhUbXVESFdDRXVpVXBDdFNvWgpRVDBXMkprMmk1V0lIV3BQOEsxYW1WZCtPQ3Y1QjBrb3J5N0ZhL3RwUHkrYlFWdEo0djJlRGc9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo="
  ca.crt: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURFekNDQWZ1Z0F3SUJBZ0lRWm9WeFZOdC9uSkNmY2JBeWxHVEx6VEFOQmdrcWhraUc5dzBCQVFzRkFEQVUKTVJJd0VBWURWUVFERXdsb1lYSmliM0l0WTJFd0hoY05Nakl3TWpJM01EVXpPRE0wV2hjTk1qTXdNakkzTURVegpPRE0wV2pBVU1SSXdFQVlEVlFRREV3bG9ZWEppYjNJdFkyRXdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCCkR3QXdnZ0VLQW9JQkFRQzZTZEdHWVpjK05aMjcySzZWdWlEN2hOQk8yOUczTkNlNHdhZWFQK2N2eTUrZ3pGSkcKYnVwQTBGOXlHaHczL21nb3Uya00xa01SMitBZUFzSVlxUjVEdmM0Ky8rMy9YRC95TkFXcmZtMmNvZ2h1anExVgpHaU82TTBFdmVud2duekFWdFVYci9yRVFCcEF5WFcxcHRDMlh3a1FoWVRyZE9XajYzbXVQaVBiazZCVEtxZ0hoCm9YYjBDSVNuY1pUWmxZdGNmczBBWjNPOEVacC9vVXozY0V5cjh0VW9GNWk1cGRvdm45SGdjTE9hU1VVV0l4ZHUKQ1dML0owVytEUUtsNGQ2L2hmV1FSamhEQjRVZHBOVkdSb1VrVEZnOUpKQ1A0cUVqa3hEZHBNWGc3SjdQV0FndwpabUxzUDM4LzEvOTBCNkxyZzJoOGE3VmIwWEx0V2pWNDl6cTdBZ01CQUFHallUQmZNQTRHQTFVZER3RUIvd1FFCkF3SUNwREFkQmdOVkhTVUVGakFVQmdnckJnRUZCUWNEQVFZSUt3WUJCUVVIQXdJd0R3WURWUjBUQVFIL0JBVXcKQXdFQi96QWRCZ05WSFE0RUZnUVVkWHJVdkltcENLV3JYeXNvZ1hxS2ljZEJjNEV3RFFZSktvWklodmNOQVFFTApCUUFEZ2dFQkFFUnJLNjFUUCtPcHllRkVKUzEwbTlMSDRxOVdYMEphM3RIZkFmWDV3UnhHRkthd1pheFlGYWI4ClVrMFdwVmg4TmZlZWkweVhBeTZHVHlpMllKeUNBRWQ2aVRJSXZjVG9kNnZTVkh2TkdBc3ZKSjJtbEdxcU1UQXQKMHJJK05JdkxVTE95b1ZDVHEzaDNWZjhQRG5uNUsvL3FMU3dEaGhpYVBMQWxna2ZrczdJR2RGOTBJOGoxZG96Ugp4WU85eGN3THNZdDRIMk5iR1hLWWtVYmYrSkZVbkY3dUFVL0RoNzFaeU0rNllMUTdDRlFFQ0oxT2dnQXhSby9KCmlvbkg2cmFyR3VHbXFTNHVpUnhjVk8xa3M4a3IvZ1dHb0p2eGRnc2d3ZS9QVmVkTzNzS1JLWVdybG9ScFNWRTkKZTBlQTF5bGl4VjBOS21ld2lQY0g0Q1ZwbFBoQ0d2Yz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
---
# Source: harbor/templates/jobservice/jobservice-secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: "harbor-jobservice"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
type: Opaque
data:
  JOBSERVICE_SECRET: "ZzFUVnZPRXRBQVlNN1pvOQ=="
  REGISTRY_CREDENTIAL_PASSWORD: "aGFyYm9yX3JlZ2lzdHJ5X3Bhc3N3b3Jk"
---
# Source: harbor/templates/notary/notary-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: harbor-notary-server
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: notary
type: Opaque
data:
  ca.crt: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJVENDQWdtZ0F3SUJBZ0lRRUljbzJkR3h5VGJMTERtZlc5M0RaREFOQmdrcWhraUc5dzBCQVFzRkFEQWIKTVJrd0Z3WURWUVFERXhCb1lYSmliM0l0Ym05MFlYSjVMV05oTUI0WERUSXlNREl5TnpBMU16Z3pNMW9YRFRJegpNREl5TnpBMU16Z3pNMW93R3pFWk1CY0dBMVVFQXhNUWFHRnlZbTl5TFc1dmRHRnllUzFqWVRDQ0FTSXdEUVlKCktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQUpob2ZwMVZzN1RhOEQxdmt0YlpFd2s1ckpqUmtWTFcKajhOUU93bWlHNC9DeUJJUVNRcVpuM0o1WGw3alJRVklsazZPOUJCS1JlNmhwaFZKS29jQnJGRFZPY2VyMUR0aQp2bm03SXRXNGdSNFRWR01EbHNoMlArVVpiSGl4OWVJOU1vcnZZdlpSKzZKcjd1TWJnUDV2SzhtV09CUFE5N1J2CllnTkVQSUxhZ0tMRVF4aWFQenlFZzhtZFh4WDE4aTBxVjd4S2pDTjRGcE9zZVMvT2VDTU4yZDNOWmJPdFFuT2wKRERCQ0VoSUVIaE1PbXgvZUdBRm5sQlBhMlNKdjdVbjI4LzVBU1gzN3QveGpJSGVvZFM1Nnhia0xocU9BRmZZYQpDOGFpSzJYUHppUkJjZkh0VTAzQTJvRE04OHM1K0NJREFTSjJOTTBXa05tS1M4RXkrY2tJcUtzQ0F3RUFBYU5oCk1GOHdEZ1lEVlIwUEFRSC9CQVFEQWdLa01CMEdBMVVkSlFRV01CUUdDQ3NHQVFVRkJ3TUJCZ2dyQmdFRkJRY0QKQWpBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSRGlpNm9PbDVISVgvWTBjQWF1RnlQb1Y3SwpkVEFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBTmJNbmZnZitTY2V4T0FqL0RKWEtYdGFSVXBQU3pZQkZNU3hKCkxyKzNVUm1OZVRNaDE0VWhqZmh2VHk1K2dsVDY2SEZwUlBHMmpkVFFzSk5DT3g4U1VSTnZlYzUva2lOdVJ2aVEKZjNIUzdPS0ljSzlNMksxTFBrQTUwTG8wb1RQWVVpTzFPbGJVQ2ZXNlNqU0JYbTRuVGkrN3k5ZXhGQmZLa3FoMQpQbmF0OTV2LzhQYkFCNSt3R0l3MTc0anpmNnlRMUNacjNjZ1dwbCtrOHIyZlZJSnFvOSszdVE3WTVIdnJNTUVzCjExSTFyQktJRzhDMUNieStwSEZsMkt1R2NuaGc3c2ZBWmZBOXZiTy9ua0dmd3JVMGVHNS8vV0lvdFlEZHNMRnoKRkplcVpocllQd0lJQnZjS3BOV0RDVDl0VXhHbXFVTmhmdWNyR0k0eFZlaUUxbnJtR3c9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
  tls.crt: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURSakNDQWk2Z0F3SUJBZ0lRYllXRXl3MkhiU1pwVEJRUVhlbW1EREFOQmdrcWhraUc5dzBCQVFzRkFEQWIKTVJrd0Z3WURWUVFERXhCb1lYSmliM0l0Ym05MFlYSjVMV05oTUI0WERUSXlNREl5TnpBMU16Z3pORm9YRFRJegpNREl5TnpBMU16Z3pORm93SHpFZE1Cc0dBMVVFQXhNVWFHRnlZbTl5TFc1dmRHRnllUzF6YVdkdVpYSXdnZ0VpCk1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRQ3dCeEhyWmtsYkJ2ZzViWmQ3WnZwMFpQV04Kb2xkUDVxd3doMGphV2J0dUVESExpUWFsdEFwYTVRYjh6WEtzS0FBMTBHYWdFTlNkMm0xNXEyWVJIRlhKV3E1awpXOG9jNHB1eURMU2FFN0ZLZHVIeHlwOGxlUkdhNFFPWmt0SUxxV2t4S2NkNjlSdHZKdDFoTzJrM25BZ2xtaS9qCnhRaW5JWG5JUEpSbGxnYUozUGtOQVNabTYvL0JTNVBVRDY1L0g0UStGckp1QXgxNVRKczFvS1l5L0RhK2dyZWoKa0o4Uk1ITDNuYS9JbHdFUnpkeE1MWXFjdFZNMGlzcldET0hndXdXb2VVMncwbk9SMzdNNXRTbUtZVXp0bmkyUwp3NFhDc25qYno4TUlCRTRqSTdSU1UzR240UldUNmdrdUFiZEErUys2dENScEtVdzJGbnMzSElIeklsK0RBZ01CCkFBR2pnWUV3ZnpBT0JnTlZIUThCQWY4RUJBTUNCYUF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0cKQVFVRkJ3TUNNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVRNG91cURwZVJ5Ri8yTkhBR3JoYwpqNkZleW5Vd0h3WURWUjBSQkJnd0ZvSVVhR0Z5WW05eUxXNXZkR0Z5ZVMxemFXZHVaWEl3RFFZSktvWklodmNOCkFRRUxCUUFEZ2dFQkFGYnZWQlYxVmtNd2lyeE5ubG5SZTBwTit0bVBwSkU4TWg1QTM4Vk5kZjAyVjU2aWYxNkcKTjVnVUlqa3RuSE90SG1TY2huaC9SWXB0dXo1TVNTblA3Tm1RU0NGUnpXT3FidjFrOHlCR1pVM3M5TFFJaGpoQgo5U1FGK3FmRi9tMDl5M09qaG9DYkdmU1JyV1p3T2JTQWE2RUJhUThiMGpjOHdBT05NVUhDMldjV1dxeTdxNXRJCjl4Y3NpdmRkUXJpQUp2enoyai9QdXZiMGVoWWlXMmU4U2JDWTlGMUFTamdwVVgwM2k5QWxGU0tra05SRGFFakMKbHBodnJKekEyZWFvOG42ZTNtR1orQzYydnQ0T2tGRjlvRHIydDNZNG5zQkFjbzd5VXRna2RpTW4zMUZzaGdKTQpWSjlmUEIzazYxcnhDRUYzQUUzSTd4dTYwWnNaN25sVlJPRT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
  tls.key: "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBc0FjUjYyWkpXd2I0T1cyWGUyYjZkR1QxamFKWFQrYXNNSWRJMmxtN2JoQXh5NGtHCnBiUUtXdVVHL00xeXJDZ0FOZEJtb0JEVW5kcHRlYXRtRVJ4VnlWcXVaRnZLSE9LYnNneTBtaE94U25iaDhjcWYKSlhrUm11RURtWkxTQzZscE1TbkhldlViYnliZFlUdHBONXdJSlpvdjQ4VUlweUY1eUR5VVpaWUdpZHo1RFFFbQpadXYvd1V1VDFBK3VmeCtFUGhheWJnTWRlVXliTmFDbU12dzJ2b0szbzVDZkVUQnk5NTJ2eUpjQkVjM2NUQzJLCm5MVlROSXJLMWd6aDRMc0ZxSGxOc05KemtkK3pPYlVwaW1GTTdaNHRrc09Gd3JKNDI4L0RDQVJPSXlPMFVsTngKcCtFVmsrb0pMZ0czUVBrdnVyUWthU2xNTmhaN054eUI4eUpmZ3dJREFRQUJBb0lCQUdFK2RxTFI3aUp3ZGo3YgprVHptQmVTNVJZSktOZXY1SmhUbEY5VXdqei9kaUhURnJUdHJlL0Q4NTJCUGExTTZBZXU0eG9rVTR6Q1ZVN2RNCmZlVmovdXh1d1RyR0RxRG9lMVRnZWdGSWNjQU9id0h4aXZ2YnAyTWxmYVNnbkpNK3N0TXJIbjJKM084SnpIRUQKcmp1L1lpekx3anNWUlpOM0JkMGR3bWxnZVJvOVl2KzF6TC9NV0VMZjdsMUlCNEs3d001TlBkUWpjaEtEVlM3Qwo1SjVydytkNkVFdFhBa1F1ZEg3b0hJWmkzaUljSWswNWtveVhFK1BQOFUzOWtXWHdINFlQV1VuZzY2dmEyWWpyCkQ5TzNBNGtOcUFwTTF0WW1ibEMvOWp0NktiaDhaNDNMdllsclV2VkdsSTRuYWdKWEk5SUJ1bGVKSHl1bGwvNG4KUkNSL1Ewa0NnWUVBNGpRYjlzU09OM2c1L0ppMTR3N2QvaEp6eDRvdndaMVRTQ2RYOUU5Q3daVGgwMHZiVTRLWgpvVUtIRk1nR0szRFhMbWg2VmNzRXdyM20yUDRTeE94L3FwYi9pTEp0OVBaeUxibHAvbE9qZUJaUFg3NjU1VEpmCmhadm9SNEl3UnZnY0djcklNb2VKWXp4S2FuR2pJOFlTQVVZKzIwOEFRSXJFZmtlRFdZTHVwSzhDZ1lFQXh6YjEKekorLzNKV1M3QUtCWkpTZ1k4eDJaRGtWZmErK0w1K0V4QjkvcUlRMm5KZUZPdlhhajJiSURXbDh2aGNQR1Z0UgpoR0VOd3dHeVpZMHM2RVhNSmpaZlN6WC9CL1c5ZEdRdXk1aXFzL2ZjVTR1Y25YQkRUbUp0NE5MY3dJVEhjVWJYCjlvSHpFMm5ucUxiMEVSaHRJelJEM3p4UStnc1JlZWFhTWY0Z0QyMENnWUJwcWxuZHZoZUpCZHBnaXAxOGdYZGwKdGd6cml6dWZ2L1FsWW11TnJuREtxTmVNc29TenovQWdDa203aFd5TVlsdkNTLy9KajlxYmRjWWVXeUU5YUJTRApCYUk4b3MwR2Z4RDdGdi9TVkJPcWh4Rnc4bEU0SlgzRmxmeTlXcTFlbVl2VzZJajRRYVFGL1NYdDcwTjc5SXg0CmwrM0kySENQdGNMd0VrdmpSbXhmOVFLQmdHQXErdXRsN3NPNGZPMXJwRFQrdnBLT3dGUlBiajEzV2pNNUtXbFgKMzFObFI4dStKWFc1KzJFZ2Q5QnByT3RDekdvc09DVFVpVVVyQzRpVVp5cFZqMkNlL00rYzZGbGFXclBXTFBUaAo1UDN0MkRHSWd2bEptV1E4aGRoelVsZXBnWElBaGY2YzZzL2pYdzZHQ3pvNWRXMzZMQTJXMjJ4cGJXMVFVZjF5Ck5OM2RBb0dCQUw1YVFEcEZZV1dxVDZFYmh2alpLcHFyc0YxdXNmeEw3aHJ3U0dUMXhLVnJWWjFpWU1hWUdBcHEKNTNWM0xUeklKQkFsYjhLTlpGOFNmMlNNRklQdjJRRGgzc0xkQkloaklqV1hEZUI0NktoeElrWmh4aHNYTzJIcwp5WDlLNVhKY2ZMMjlJcm4rYklLQjZYZWxhTkRTTXNRckhhMjRFRVFBS09GblplbHlENnhsCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg=="
  server.json: ewogICJzZXJ2ZXIiOiB7CiAgICAiaHR0cF9hZGRyIjogIjo0NDQzIgogIH0sCiAgInRydXN0X3NlcnZpY2UiOiB7CiAgICAidHlwZSI6ICJyZW1vdGUiLAogICAgImhvc3RuYW1lIjogImhhcmJvci1ub3Rhcnktc2lnbmVyIiwKICAgICJwb3J0IjogIjc4OTkiLAogICAgInRsc19jYV9maWxlIjogIi9ldGMvc3NsL25vdGFyeS9jYS5jcnQiLAogICAgImtleV9hbGdvcml0aG0iOiAiZWNkc2EiCiAgfSwKICAibG9nZ2luZyI6IHsKICAgICJsZXZlbCI6ICJpbmZvIgogIH0sCiAgInN0b3JhZ2UiOiB7CiAgICAiYmFja2VuZCI6ICJwb3N0Z3JlcyIsCiAgICAiZGJfdXJsIjogInBvc3RncmVzOi8vcG9zdGdyZXM6Y2hhbmdlaXRAaGFyYm9yLWRhdGFiYXNlOjU0MzIvbm90YXJ5c2VydmVyP3NzbG1vZGU9ZGlzYWJsZSIKICB9LAogICJhdXRoIjogewogICAgInR5cGUiOiAidG9rZW4iLAogICAgIm9wdGlvbnMiOiB7CiAgICAgICJyZWFsbSI6ICJodHRwczovL2hhcmJvci5ub2Rlc3ByaW5nYm9vdC5vcmcvc2VydmljZS90b2tlbiIsCiAgICAgICJzZXJ2aWNlIjogImhhcmJvci1ub3RhcnkiLAogICAgICAiaXNzdWVyIjogImhhcmJvci10b2tlbi1pc3N1ZXIiLAogICAgICAicm9vdGNlcnRidW5kbGUiOiAiL3Jvb3QuY3J0IgogICAgfQogIH0KfQ==
  signer.json: ewogICJzZXJ2ZXIiOiB7CiAgICAiZ3JwY19hZGRyIjogIjo3ODk5IiwKICAgICJ0bHNfY2VydF9maWxlIjogIi9ldGMvc3NsL25vdGFyeS90bHMuY3J0IiwKICAgICJ0bHNfa2V5X2ZpbGUiOiAiL2V0Yy9zc2wvbm90YXJ5L3Rscy5rZXkiCiAgfSwKICAibG9nZ2luZyI6IHsKICAgICJsZXZlbCI6ICJpbmZvIgogIH0sCiAgInN0b3JhZ2UiOiB7CiAgICAiYmFja2VuZCI6ICJwb3N0Z3JlcyIsCiAgICAiZGJfdXJsIjogInBvc3RncmVzOi8vcG9zdGdyZXM6Y2hhbmdlaXRAaGFyYm9yLWRhdGFiYXNlOjU0MzIvbm90YXJ5c2lnbmVyP3NzbG1vZGU9ZGlzYWJsZSIsCiAgICAiZGVmYXVsdF9hbGlhcyI6ICJkZWZhdWx0YWxpYXMiCiAgfQp9
---
# Source: harbor/templates/registry/registry-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: "harbor-registry"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
type: Opaque
data:
  REGISTRY_HTTP_SECRET: "YUpReG12V1M2eXJ2a2l4RQ=="
  REGISTRY_REDIS_PASSWORD: ""
---
# Source: harbor/templates/registry/registry-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: "harbor-registry-htpasswd"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
type: Opaque
data:
  REGISTRY_HTPASSWD: "aGFyYm9yX3JlZ2lzdHJ5X3VzZXI6JDJ5JDEwJDlMNFRjMERKYkZGTUI2UmRTQ3Vuck9wVEhkd2hpZDRrdEJKbUxEMDBiWWdxa2tHT3ZsbDNt"
---
# Source: harbor/templates/trivy/trivy-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: harbor-trivy
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
type: Opaque
data:
  redisURL: cmVkaXM6Ly9oYXJib3ItcmVkaXM6NjM3OS81P2lkbGVfdGltZW91dF9zZWNvbmRzPTMw
  gitHubToken: ""
---
# Source: harbor/templates/chartmuseum/chartmuseum-cm.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: "harbor-chartmuseum"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
data:
  PORT: "9999"
  CACHE: "redis"
  CACHE_REDIS_ADDR: "harbor-redis:6379"
  CACHE_REDIS_DB: "3"
  BASIC_AUTH_USER: "chart_controller"
  DEPTH: "1"
  DEBUG: "false"
  LOG_JSON: "true"
  DISABLE_METRICS: "false"
  DISABLE_API: "false"
  DISABLE_STATEFILES: "false"
  ALLOW_OVERWRITE: "true"
  AUTH_ANONYMOUS_GET: "false"
  CONTEXT_PATH: ""
  INDEX_LIMIT: "0"
  MAX_STORAGE_OBJECTS: "0"
  MAX_UPLOAD_SIZE: "20971520"
  CHART_POST_FORM_FIELD_NAME: "chart"
  PROV_POST_FORM_FIELD_NAME: "prov"
  STORAGE: "local"
  STORAGE_LOCAL_ROOTDIR: "/chart_storage"
  STORAGE_TIMESTAMP_TOLERANCE: 1s
---
# Source: harbor/templates/core/core-cm.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: harbor-core
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
data:
  app.conf: |+
    appname = Harbor
    runmode = prod
    enablegzip = true

    [prod]
    httpport = 8080
  PORT: "8080"
  DATABASE_TYPE: "postgresql"
  POSTGRESQL_HOST: "harbor-database"
  POSTGRESQL_PORT: "5432"
  POSTGRESQL_USERNAME: "postgres"
  POSTGRESQL_DATABASE: "registry"
  POSTGRESQL_SSLMODE: "disable"
  POSTGRESQL_MAX_IDLE_CONNS: "100"
  POSTGRESQL_MAX_OPEN_CONNS: "900"
  EXT_ENDPOINT: "https://harbor.nodespringboot.org"
  CORE_URL: "http://harbor-core:80"
  JOBSERVICE_URL: "http://harbor-jobservice"
  REGISTRY_URL: "http://harbor-registry:5000"
  TOKEN_SERVICE_URL: "http://harbor-core:80/service/token"
  WITH_NOTARY: "true"
  NOTARY_URL: "http://harbor-notary-server:4443"
  CORE_LOCAL_URL: "http://127.0.0.1:8080"
  WITH_TRIVY: "true"
  TRIVY_ADAPTER_URL: "http://harbor-trivy:8080"
  REGISTRY_STORAGE_PROVIDER_NAME: "filesystem"
  WITH_CHARTMUSEUM: "true"
  CHART_REPOSITORY_URL: "http://harbor-chartmuseum"
  LOG_LEVEL: "info"
  CONFIG_PATH: "/etc/core/app.conf"
  CHART_CACHE_DRIVER: "redis"
  _REDIS_URL_CORE: "redis://harbor-redis:6379/0?idle_timeout_seconds=30"
  _REDIS_URL_REG: "redis://harbor-redis:6379/2?idle_timeout_seconds=30"
  PORTAL_URL: "http://harbor-portal"
  REGISTRY_CONTROLLER_URL: "http://harbor-registry:8080"
  REGISTRY_CREDENTIAL_USERNAME: "harbor_registry_user"
  HTTP_PROXY: ""
  HTTPS_PROXY: ""
  NO_PROXY: "harbor-core,harbor-jobservice,harbor-database,harbor-chartmuseum,harbor-notary-server,harbor-notary-signer,harbor-registry,harbor-portal,harbor-trivy,harbor-exporter,127.0.0.1,localhost,.local,.internal"
  PERMITTED_REGISTRY_TYPES_FOR_PROXY_CACHE: "docker-hub,harbor,azure-acr,aws-ecr,google-gcr,quay,docker-registry"
---
# Source: harbor/templates/jobservice/jobservice-cm-env.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: "harbor-jobservice-env"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
data:
  CORE_URL: "http://harbor-core:80"
  TOKEN_SERVICE_URL: "http://harbor-core:80/service/token"
  REGISTRY_URL: "http://harbor-registry:5000"
  REGISTRY_CONTROLLER_URL: "http://harbor-registry:8080"
  REGISTRY_CREDENTIAL_USERNAME: "harbor_registry_user"
  HTTP_PROXY: ""
  HTTPS_PROXY: ""
  NO_PROXY: "harbor-core,harbor-jobservice,harbor-database,harbor-chartmuseum,harbor-notary-server,harbor-notary-signer,harbor-registry,harbor-portal,harbor-trivy,harbor-exporter,127.0.0.1,localhost,.local,.internal"
---
# Source: harbor/templates/jobservice/jobservice-cm.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: "harbor-jobservice"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
data:
  config.yml: |+
    #Server listening port
    protocol: "http"
    port: 8080
    worker_pool:
      workers: 10
      backend: "redis"
      redis_pool:
        redis_url: "redis://harbor-redis:6379/1"
        namespace: "harbor_job_service_namespace"
        idle_timeout_second: 3600
    job_loggers:
      - name: "FILE"
        level: INFO
        settings: # Customized settings of logger
          base_dir: "/var/log/jobs"
        sweeper:
          duration: 14 #days
          settings: # Customized settings of sweeper
            work_dir: "/var/log/jobs"
    metric:
      enabled: false
      path: /metrics
      port: 8001
    #Loggers for the job service
    loggers:
      - name: "STD_OUTPUT"
        level: INFO
---
# Source: harbor/templates/portal/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: "harbor-portal"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
data:
  nginx.conf: |+
    worker_processes auto;
    pid /tmp/nginx.pid;
    events {
        worker_connections  1024;
    }
    http {
        client_body_temp_path /tmp/client_body_temp;
        proxy_temp_path /tmp/proxy_temp;
        fastcgi_temp_path /tmp/fastcgi_temp;
        uwsgi_temp_path /tmp/uwsgi_temp;
        scgi_temp_path /tmp/scgi_temp;
        server {
            listen 8080;
            listen [::]:8080;
            server_name  localhost;
            root   /usr/share/nginx/html;
            index  index.html index.htm;
            include /etc/nginx/mime.types;
            gzip on;
            gzip_min_length 1000;
            gzip_proxied expired no-cache no-store private auth;
            gzip_types text/plain text/css application/json application/javascript application/x-javascript text/xml application/xml application/xml+rss text/javascript;
            location / {
                try_files $uri $uri/ /index.html;
            }
            location = /index.html {
                add_header Cache-Control "no-store, no-cache, must-revalidate";
            }
        }
    }
---
# Source: harbor/templates/registry/registry-cm.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: "harbor-registry"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
data:
  config.yml: |+
    version: 0.1
    log:
      level: info
      fields:
        service: registry
    storage:
      filesystem:
        rootdirectory: /storage
      cache:
        layerinfo: redis
      maintenance:
        uploadpurging:
          enabled: false
      delete:
        enabled: true
      redirect:
        disable: false
    redis:
      addr: harbor-redis:6379
      db: 2
      readtimeout: 10s
      writetimeout: 10s
      dialtimeout: 10s
      pool:
        maxidle: 100
        maxactive: 500
        idletimeout: 60s
    http:
      addr: :5000
      relativeurls: false
      # set via environment variable
      # secret: placeholder
      debug:
        addr: localhost:5001
    auth:
      htpasswd:
        realm: harbor-registry-basic-realm
        path: /etc/registry/passwd
    validation:
      disabled: true
    compatibility:
      schema1:
        enabled: true
  ctl-config.yml: |+
    ---
    protocol: "http"
    port: 8080
    log_level: info
    registry_config: "/etc/registry/config.yml"
---
# Source: harbor/templates/chartmuseum/chartmuseum-pvc.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: harbor-chartmuseum
  annotations:
    helm.sh/resource-policy: keep
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: chartmuseum
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
---
# Source: harbor/templates/jobservice/jobservice-pvc.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: harbor-jobservice
  annotations:
    helm.sh/resource-policy: keep
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: jobservice
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
# Source: harbor/templates/registry/registry-pvc.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: harbor-registry
  annotations:
    helm.sh/resource-policy: keep
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: registry
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
---
# Source: harbor/templates/chartmuseum/chartmuseum-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: "harbor-chartmuseum"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
    - port: 80
      targetPort: 9999
  selector:
    release: harbor
    app: "harbor"
    component: chartmuseum
---
# Source: harbor/templates/core/core-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: harbor-core
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
    - name: http-web
      port: 80
      targetPort: 8080
  selector:
    release: harbor
    app: "harbor"
    component: core
---
# Source: harbor/templates/database/database-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: "harbor-database"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
    - port: 5432
  selector:
    release: harbor
    app: "harbor"
    component: database
---
# Source: harbor/templates/jobservice/jobservice-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: "harbor-jobservice"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
    - name: http-jobservice
      port: 80
      targetPort: 8080
  selector:
    release: harbor
    app: "harbor"
    component: jobservice
---
# Source: harbor/templates/notary/notary-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: harbor-notary-server
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
  - port: 4443
  selector:
    release: harbor
    app: "harbor"
    component: notary-server
---
# Source: harbor/templates/notary/notary-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: harbor-notary-signer
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
  - port: 7899
  selector:
    release: harbor
    app: "harbor"
    component: notary-signer
---
# Source: harbor/templates/portal/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: "harbor-portal"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
    - port: 80
      targetPort: 8080
  selector:
    release: harbor
    app: "harbor"
    component: portal
---
# Source: harbor/templates/redis/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: harbor-redis
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
    - port: 6379
  selector:
    release: harbor
    app: "harbor"
    component: redis
---
# Source: harbor/templates/registry/registry-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: "harbor-registry"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
    - name: http-registry
      port: 5000

    - name: http-controller
      port: 8080
  selector:
    release: harbor
    app: "harbor"
    component: registry
---
# Source: harbor/templates/trivy/trivy-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: "harbor-trivy"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
spec:
  ports:
    - name: http-trivy
      protocol: TCP
      port: 8080
  selector:
    release: harbor
    app: "harbor"
    component: trivy
---
# Source: harbor/templates/chartmuseum/chartmuseum-dpl.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "harbor-chartmuseum"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: chartmuseum
spec:
  replicas: 1
  strategy:
    type: RollingUpdate
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: chartmuseum
  template:
    metadata:
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
        component: chartmuseum
      annotations:
        checksum/configmap: 3a145cb777903ca8ff8fcfcb3c25ed9ee7a426a8b01cf024d6e52d92458b4564
        checksum/secret: 12c4400ee99d72e1e816c38dc665ea3e7f6b640478d7a0cca350151b4813b80d
        checksum/secret-core: f182d51672e9bdd6d31766e259d4a7aff3c2976aef53dd7a8b12401de48e21ce
    spec:
      securityContext:
        runAsUser: 10000
        fsGroup: 10000
      automountServiceAccountToken: false
      containers:
      - name: chartmuseum
        image: goharbor/chartmuseum-photon:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /health
            scheme: HTTP
            port: 9999
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /health
            scheme: HTTP
            port: 9999
          initialDelaySeconds: 1
          periodSeconds: 10
        envFrom:
        - configMapRef:
            name: "harbor-chartmuseum"
        - secretRef:
            name: "harbor-chartmuseum"
        env:
          - name: BASIC_AUTH_PASS
            valueFrom:
              secretKeyRef:
                name: harbor-core
                key: secret
          - # Needed to make AWS' client connect correctly (see https://github.com/helm/chartmuseum/issues/280)
            name: AWS_SDK_LOAD_CONFIG
            value: "1"
        ports:
        - containerPort: 9999
        volumeMounts:
        - name: chartmuseum-data
          mountPath: /chart_storage
          subPath:
      volumes:
      - name: chartmuseum-data
        persistentVolumeClaim:
          claimName: harbor-chartmuseum
---
# Source: harbor/templates/core/core-dpl.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: harbor-core
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: core
spec:
  replicas: 1
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: core
  template:
    metadata:
      labels:
        release: harbor
        app: "harbor"
        component: core
      annotations:
        checksum/configmap: bcf5e4efbe144c0fb183c0af32c5401bc9b5fb70ff9a43457c85e726d5a45e63
        checksum/secret: fa17993e0fdf4667a32938ad32c3499c151953299c3b173d3bed42c971963ff5
        checksum/secret-jobservice: a45787f206f13f558b91f69b8e037b06bb4f8b79e3a337ad651aed65a1f29486
    spec:
      securityContext:
        runAsUser: 10000
        fsGroup: 10000
      automountServiceAccountToken: false
      terminationGracePeriodSeconds: 120
      containers:
      - name: core
        image: goharbor/harbor-core:v2.3.0
        imagePullPolicy: IfNotPresent
        startupProbe:
          httpGet:
            path: /api/v2.0/ping
            scheme: HTTP
            port: 8080
          failureThreshold: 360
          initialDelaySeconds: 10
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /api/v2.0/ping
            scheme: HTTP
            port: 8080
          failureThreshold: 2
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /api/v2.0/ping
            scheme: HTTP
            port: 8080
          failureThreshold: 2
          periodSeconds: 10
        envFrom:
        - configMapRef:
            name: "harbor-core"
        - secretRef:
            name: "harbor-core"
        env:
          - name: CORE_SECRET
            valueFrom:
              secretKeyRef:
                name: harbor-core
                key: secret
          - name: JOBSERVICE_SECRET
            valueFrom:
              secretKeyRef:
                name: "harbor-jobservice"
                key: JOBSERVICE_SECRET
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: config
          mountPath: /etc/core/app.conf
          subPath: app.conf
        - name: secret-key
          mountPath: /etc/core/key
          subPath: key
        - name: token-service-private-key
          mountPath: /etc/core/private_key.pem
          subPath: tls.key
        - name: ca-download
          mountPath: /etc/core/ca
        - name: psc
          mountPath: /etc/core/token
      volumes:
      - name: config
        configMap:
          name: harbor-core
          items:
            - key: app.conf
              path: app.conf
      - name: secret-key
        secret:
          secretName: harbor-core
          items:
            - key: secretKey
              path: key
      - name: token-service-private-key
        secret:
          secretName: harbor-core
      - name: ca-download
        secret:
          secretName: "harbor-ingress"
      - name: psc
        emptyDir: {}
---
# Source: harbor/templates/jobservice/jobservice-dpl.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "harbor-jobservice"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: jobservice
spec:
  replicas: 1
  strategy:
    type: RollingUpdate
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: jobservice
  template:
    metadata:
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
        component: jobservice
      annotations:
        checksum/configmap: 41138a089428e6776014e59b1a37c5e69bedc9331ccdb1f382f1950882ec1b7e
        checksum/configmap-env: 5c0e2cf333f81a4f19f13c25cb45f2b2f5353c9bd05f59e8cbb6b59cc0eb7195
        checksum/secret: c86768c6fc56d2c1bf930a4bc3fef256646c177ef9c235d4d07bf3d800616ebc
        checksum/secret-core: ae75d14c776327eb4a91fff14e8f260b9dcfe6c86abd72e5e4a5a26b3bede2f0
    spec:
      securityContext:
        runAsUser: 10000
        fsGroup: 10000
      automountServiceAccountToken: false
      terminationGracePeriodSeconds: 120
      containers:
      - name: jobservice
        image: goharbor/harbor-jobservice:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /api/v1/stats
            scheme: HTTP
            port: 8080
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /api/v1/stats
            scheme: HTTP
            port: 8080
          initialDelaySeconds: 20
          periodSeconds: 10
        env:
          - name: CORE_SECRET
            valueFrom:
              secretKeyRef:
                name: harbor-core
                key: secret
        envFrom:
        - configMapRef:
            name: "harbor-jobservice-env"
        - secretRef:
            name: "harbor-jobservice"
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: jobservice-config
          mountPath: /etc/jobservice/config.yml
          subPath: config.yml
        - name: job-logs
          mountPath: /var/log/jobs
          subPath:
      volumes:
      - name: jobservice-config
        configMap:
          name: "harbor-jobservice"
      - name: job-logs
        persistentVolumeClaim:
          claimName: harbor-jobservice
---
# Source: harbor/templates/notary/notary-server.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: harbor-notary-server
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: notary-server
spec:
  replicas: 1
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: notary-server
  template:
    metadata:
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
        component: notary-server
      annotations:
        checksum/secret: 40e822a96920e04dd3b3dd1d8787cb1ae68cf2995b66b0a1ce00eb8703fd34da
        checksum/secret-core: 82dd7cc38a9af2b2176a699d3e6f7b529028840626e9d6f4086177e26f12ef7f
    spec:
      securityContext:
        runAsUser: 10000
        fsGroup: 10000
      automountServiceAccountToken: false
      containers:
      - name: notary-server
        image: goharbor/notary-server-photon:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /_notary_server/health
            scheme: "HTTP"
            port: 4443
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /_notary_server/health
            scheme: "HTTP"
            port: 4443
          initialDelaySeconds: 20
          periodSeconds: 10
        env:
        - name: MIGRATIONS_PATH
          value: migrations/server/postgresql
        - name: DB_URL
          value: postgres://postgres:changeit@harbor-database:5432/notaryserver?sslmode=disable
        volumeMounts:
        - name: config
          mountPath: /etc/notary/server-config.postgres.json
          subPath: server.json
        - name: token-service-certificate
          mountPath: /root.crt
          subPath: tls.crt
        - name: signer-certificate
          mountPath: /etc/ssl/notary/ca.crt
          subPath: ca.crt
      volumes:
      - name: config
        secret:
          secretName: "harbor-notary-server"
      - name: token-service-certificate
        secret:
          secretName: harbor-core
      - name: signer-certificate
        secret:
          secretName: harbor-notary-server
---
# Source: harbor/templates/notary/notary-signer.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: harbor-notary-signer
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: notary-signer
spec:
  replicas: 1
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: notary-signer
  template:
    metadata:
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
        component: notary-signer
      annotations:
        checksum/secret: 8fc3745fbe2a550aa691fe69ab9705503f0cb7465ac583d1077e4dc29c38e504
    spec:
      securityContext:
        runAsUser: 10000
        fsGroup: 10000
      automountServiceAccountToken: false
      containers:
      - name: notary-signer
        image: goharbor/notary-signer-photon:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /
            scheme: "HTTPS"
            port: 7899
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /
            scheme: "HTTPS"
            port: 7899
          initialDelaySeconds: 20
          periodSeconds: 10
        env:
        - name: MIGRATIONS_PATH
          value: migrations/signer/postgresql
        - name: DB_URL
          value: postgres://postgres:changeit@harbor-database:5432/notarysigner?sslmode=disable
        - name: NOTARY_SIGNER_DEFAULTALIAS
          value: defaultalias
        volumeMounts:
        - name: config
          mountPath: /etc/notary/signer-config.postgres.json
          subPath: signer.json
        - name: signer-certificate
          mountPath: /etc/ssl/notary/tls.crt
          subPath: tls.crt
        - name: signer-certificate
          mountPath: /etc/ssl/notary/tls.key
          subPath: tls.key
      volumes:
      - name: config
        secret:
          secretName: "harbor-notary-server"
      - name: signer-certificate
        secret:
          secretName: harbor-notary-server
---
# Source: harbor/templates/portal/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "harbor-portal"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: portal
spec:
  replicas: 1
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: portal
  template:
    metadata:
      labels:
        release: harbor
        app: "harbor"
        component: portal
      annotations:
    spec:
      securityContext:
        runAsUser: 10000
        fsGroup: 10000
      automountServiceAccountToken: false
      containers:
      - name: portal
        image: goharbor/harbor-portal:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /
            scheme: HTTP
            port: 8080
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /
            scheme: HTTP
            port: 8080
          initialDelaySeconds: 1
          periodSeconds: 10
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: portal-config
          mountPath: /etc/nginx/nginx.conf
          subPath: nginx.conf
      volumes:
      - name: portal-config
        configMap:
          name: "harbor-portal"
---
# Source: harbor/templates/registry/registry-dpl.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "harbor-registry"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: registry
spec:
  replicas: 1
  strategy:
    type: RollingUpdate
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: registry
  template:
    metadata:
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
        component: registry
      annotations:
        checksum/configmap: dbbd548871ae33e48eb16af08dc415671c1a982eea0685ce1a94015b9a0e5dcd
        checksum/secret: cd14f86cf6186b7b1a54cd6438be6538e35b6e0d808e4c7451d36d40ee4536a9
        checksum/secret-jobservice: 50c9ddf5ad787efc0dc45bcbd58ded36747daf8ba2669db0e0f8368e40f6a0e7
        checksum/secret-core: bf68bfc480b43d9c43b178952133d4c7c8ef4a9aa1183c6e5b227e2f3e9d93f4
    spec:
      securityContext:
        runAsUser: 10000
        fsGroup: 10000
      automountServiceAccountToken: false
      terminationGracePeriodSeconds: 120
      containers:
      - name: registry
        image: goharbor/registry-photon:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /
            scheme: HTTP
            port: 5000
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /
            scheme: HTTP
            port: 5000
          initialDelaySeconds: 1
          periodSeconds: 10
        args: ["serve", "/etc/registry/config.yml"]
        envFrom:
        - secretRef:
            name: "harbor-registry"
        env:
        ports:
        - containerPort: 5000
        - containerPort: 5001
        volumeMounts:
        - name: registry-data
          mountPath: /storage
          subPath:
        - name: registry-htpasswd
          mountPath: /etc/registry/passwd
          subPath: passwd
        - name: registry-config
          mountPath: /etc/registry/config.yml
          subPath: config.yml
      - name: registryctl
        image: goharbor/harbor-registryctl:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /api/health
            scheme: HTTP
            port: 8080
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /api/health
            scheme: HTTP
            port: 8080
          initialDelaySeconds: 1
          periodSeconds: 10
        envFrom:
        - secretRef:
            name: "harbor-registry"
        env:
        - name: CORE_SECRET
          valueFrom:
            secretKeyRef:
              name: harbor-core
              key: secret
        - name: JOBSERVICE_SECRET
          valueFrom:
            secretKeyRef:
              name: harbor-jobservice
              key: JOBSERVICE_SECRET
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: registry-data
          mountPath: /storage
          subPath:
        - name: registry-config
          mountPath: /etc/registry/config.yml
          subPath: config.yml
        - name: registry-config
          mountPath: /etc/registryctl/config.yml
          subPath: ctl-config.yml
      volumes:
      - name: registry-htpasswd
        secret:
          secretName: harbor-registry-htpasswd
          items:
            - key: REGISTRY_HTPASSWD
              path: passwd
      - name: registry-config
        configMap:
          name: "harbor-registry"
      - name: registry-data
        persistentVolumeClaim:
          claimName: harbor-registry
---
# Source: harbor/templates/database/database-ss.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: "harbor-database"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: database
spec:
  replicas: 1
  serviceName: "harbor-database"
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: database
  template:
    metadata:
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
        component: database
      annotations:
        checksum/secret: 55b1e7be0855a53d12362dc11834f575bd16ba09cdd84b0551bda85635e15ac1
    spec:
      securityContext:
        runAsUser: 999
        fsGroup: 999
      automountServiceAccountToken: false
      terminationGracePeriodSeconds: 120
      initContainers:
      # as we change the data directory to a sub folder to support psp, the init container here
      # is used to migrate the existing data. See https://github.com/goharbor/harbor-helm/issues/756
      # for more detail.
      # we may remove it after several releases
      - name: "data-migrator"
        image: goharbor/harbor-db:v2.3.0
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh"]
        args: ["-c", "[ -e /var/lib/postgresql/data/postgresql.conf ] && [ ! -d /var/lib/postgresql/data/pgdata ] && mkdir -m 0700 /var/lib/postgresql/data/pgdata && mv /var/lib/postgresql/data/* /var/lib/postgresql/data/pgdata/ || true"]
        volumeMounts:
          - name: database-data
            mountPath: /var/lib/postgresql/data
            subPath:
      # with "fsGroup" set, each time a volume is mounted, Kubernetes must recursively chown() and chmod() all the files and directories inside the volume
      # this causes the postgresql reports the "data directory /var/lib/postgresql/data/pgdata has group or world access" issue when using some CSIs e.g. Ceph
      # use this init container to correct the permission
      # as "fsGroup" applied before the init container running, the container has enough permission to execute the command
      - name: "data-permissions-ensurer"
        image: goharbor/harbor-db:v2.3.0
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh"]
        args: ["-c", "chmod 700 /var/lib/postgresql/data/pgdata || true"]
        volumeMounts:
          - name: database-data
            mountPath: /var/lib/postgresql/data
            subPath:
      containers:
      - name: database
        image: goharbor/harbor-db:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          exec:
            command:
            - /docker-healthcheck.sh
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          exec:
            command:
            - /docker-healthcheck.sh
          initialDelaySeconds: 1
          periodSeconds: 10
        envFrom:
          - secretRef:
              name: "harbor-database"
        env:
          # put the data into a sub directory to avoid the permission issue in k8s with restricted psp enabled
          # more detail refer to https://github.com/goharbor/harbor-helm/issues/756
          - name: PGDATA
            value: "/var/lib/postgresql/data/pgdata"
        volumeMounts:
        - name: database-data
          mountPath: /var/lib/postgresql/data
          subPath:
        - name: shm-volume
          mountPath: /dev/shm
      volumes:
      - name: shm-volume
        emptyDir:
          medium: Memory
          sizeLimit: 512Mi
  volumeClaimTemplates:
  - metadata:
      name: "database-data"
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: "1Gi"
---
# Source: harbor/templates/redis/statefulset.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: harbor-redis
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: redis
spec:
  replicas: 1
  serviceName: harbor-redis
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: redis
  template:
    metadata:
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
        component: redis
    spec:
      securityContext:
        runAsUser: 999
        fsGroup: 999
      automountServiceAccountToken: false
      terminationGracePeriodSeconds: 120
      containers:
      - name: redis
        image: goharbor/redis-photon:v2.3.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          tcpSocket:
            port: 6379
          initialDelaySeconds: 300
          periodSeconds: 10
        readinessProbe:
          tcpSocket:
            port: 6379
          initialDelaySeconds: 1
          periodSeconds: 10
        volumeMounts:
        - name: data
          mountPath: /var/lib/redis
          subPath:
  volumeClaimTemplates:
  - metadata:
      name: data
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: "1Gi"
---
# Source: harbor/templates/trivy/trivy-sts.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: harbor-trivy
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
    component: trivy
spec:
  replicas: 1
  serviceName: harbor-trivy
  selector:
    matchLabels:
      release: harbor
      app: "harbor"
      component: trivy
  template:
    metadata:
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
        component: trivy
      annotations:
        checksum/secret: 81105cb33a8cb2937d69d3a39d46a94953951b6154c8518d288852bcf66b4d6d
    spec:
      securityContext:
        runAsUser: 10000
        fsGroup: 10000
      automountServiceAccountToken: false
      containers:
        - name: trivy
          image: goharbor/trivy-adapter-photon:v2.3.0
          imagePullPolicy: IfNotPresent
          securityContext:
            privileged: false
            allowPrivilegeEscalation: false
          env:
            - name: HTTP_PROXY
              value: ""
            - name: HTTPS_PROXY
              value: ""
            - name: NO_PROXY
              value: "harbor-core,harbor-jobservice,harbor-database,harbor-chartmuseum,harbor-notary-server,harbor-notary-signer,harbor-registry,harbor-portal,harbor-trivy,harbor-exporter,127.0.0.1,localhost,.local,.internal"
            - name: "SCANNER_LOG_LEVEL"
              value: "info"
            - name: "SCANNER_TRIVY_CACHE_DIR"
              value: "/home/scanner/.cache/trivy"
            - name: "SCANNER_TRIVY_REPORTS_DIR"
              value: "/home/scanner/.cache/reports"
            - name: "SCANNER_TRIVY_DEBUG_MODE"
              value: "false"
            - name: "SCANNER_TRIVY_VULN_TYPE"
              value: "os,library"
            - name: "SCANNER_TRIVY_GITHUB_TOKEN"
              valueFrom:
                secretKeyRef:
                  name: harbor-trivy
                  key: gitHubToken
            - name: "SCANNER_TRIVY_SEVERITY"
              value: "UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL"
            - name: "SCANNER_TRIVY_IGNORE_UNFIXED"
              value: "false"
            - name: "SCANNER_TRIVY_SKIP_UPDATE"
              value: "false"
            - name: "SCANNER_TRIVY_INSECURE"
              value: "false"
            - name: SCANNER_API_SERVER_ADDR
              value: ":8080"
            - name: "SCANNER_REDIS_URL"
              valueFrom:
                secretKeyRef:
                  name: harbor-trivy
                  key: redisURL
            - name: "SCANNER_STORE_REDIS_URL"
              valueFrom:
                secretKeyRef:
                  name: harbor-trivy
                  key: redisURL
            - name: "SCANNER_JOB_QUEUE_REDIS_URL"
              valueFrom:
                secretKeyRef:
                  name: harbor-trivy
                  key: redisURL
          ports:
            - name: api-server
              containerPort: 8080
          volumeMounts:
          - name: data
            mountPath: /home/scanner/.cache
            subPath:
            readOnly: false
          livenessProbe:
            httpGet:
              scheme: HTTP
              path: /probe/healthy
              port: api-server
            initialDelaySeconds: 5
            periodSeconds: 10
            successThreshold: 1
            failureThreshold: 10
          readinessProbe:
            httpGet:
              scheme: HTTP
              path: /probe/ready
              port: api-server
            initialDelaySeconds: 5
            periodSeconds: 10
            successThreshold: 1
            failureThreshold: 3
          resources:
            limits:
              cpu: 1
              memory: 1Gi
            requests:
              cpu: 200m
              memory: 512Mi
  volumeClaimTemplates:
  - metadata:
      name: data
      labels:
        heritage: Helm
        release: harbor
        chart: harbor
        app: "harbor"
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: "5Gi"
---
# Source: harbor/templates/ingress/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: "harbor-ingress"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt
    ingress.kubernetes.io/proxy-body-size: "0"
    ingress.kubernetes.io/ssl-redirect: "true"
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
  - secretName: harbor-ingress
    hosts:
    - harbor.nodespringboot.org
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: harbor-portal
            port:
              number: 80
      - path: /api/
        pathType: Prefix
        backend:
          service:
            name: harbor-core
            port:
              number: 80
      - path: /service/
        pathType: Prefix
        backend:
          service:
            name: harbor-core
            port:
              number: 80
      - path: /v2
        pathType: Prefix
        backend:
          service:
            name: harbor-core
            port:
              number: 80
      - path: /chartrepo/
        pathType: Prefix
        backend:
          service:
            name: harbor-core
            port:
              number: 80
      - path: /c/
        pathType: Prefix
        backend:
          service:
            name: harbor-core
            port:
              number: 80
    host: harbor.nodespringboot.org
---
# Source: harbor/templates/ingress/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: "harbor-ingress-notary"
  labels:
    heritage: Helm
    release: harbor
    chart: harbor
    app: "harbor"
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt
    ingress.kubernetes.io/proxy-body-size: "0"
    ingress.kubernetes.io/ssl-redirect: "true"
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
  - secretName: harbor-ingress
    hosts:
    - notary.nodespringboot.org
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: harbor-notary-server
            port:
              number: 4443
    host: notary.nodespringboot.org

NOTES:
Please wait for several minutes for Harbor deployment to complete.
Then you should be able to visit the Harbor portal at https://harbor.nodespringboot.org
For more details, please visit https://github.com/goharbor/harbor
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pod -l app=harbor
NAME                                    READY   STATUS              RESTARTS   AGE
harbor-chartmuseum-86cf75dc4-76rbd      0/1     ContainerCreating   0          39s
harbor-core-566b78d8f-d6m4v             0/1     Running             0          39s
harbor-database-0                       0/1     Init:0/2            0          39s
harbor-jobservice-74fc9fb7f-s8cmd       0/1     ContainerCreating   0          39s
harbor-notary-server-749d978d5b-c9r94   0/1     Running             0          39s
harbor-notary-signer-5565f85f68-hvrvf   0/1     Running             0          39s
harbor-portal-f8958f68d-k8k54           1/1     Running             0          39s
harbor-redis-0                          1/1     Running             0          39s
harbor-registry-69cfc8894d-l4htb        0/2     ContainerCreating   0          39s
harbor-trivy-0                          0/1     ContainerCreating   0          39s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pod -l app=harbor
NAME                                    READY   STATUS              RESTARTS   AGE
harbor-chartmuseum-86cf75dc4-76rbd      0/1     ContainerCreating   0          42s
harbor-core-566b78d8f-d6m4v             0/1     Running             0          42s
harbor-database-0                       0/1     Init:0/2            0          42s
harbor-jobservice-74fc9fb7f-s8cmd       0/1     ContainerCreating   0          42s
harbor-notary-server-749d978d5b-c9r94   0/1     Running             0          42s
harbor-notary-signer-5565f85f68-hvrvf   0/1     Running             0          42s
harbor-portal-f8958f68d-k8k54           1/1     Running             0          42s
harbor-redis-0                          1/1     Running             0          42s
harbor-registry-69cfc8894d-l4htb        0/2     ContainerCreating   0          42s
harbor-trivy-0                          0/1     ContainerCreating   0          42s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pod -l app=harbor
NAME                                    READY   STATUS              RESTARTS   AGE
harbor-chartmuseum-86cf75dc4-76rbd      0/1     ContainerCreating   0          43s
harbor-core-566b78d8f-d6m4v             0/1     Running             0          43s
harbor-database-0                       0/1     Init:0/2            0          43s
harbor-jobservice-74fc9fb7f-s8cmd       0/1     ContainerCreating   0          43s
harbor-notary-server-749d978d5b-c9r94   0/1     Running             0          43s
harbor-notary-signer-5565f85f68-hvrvf   0/1     Running             0          43s
harbor-portal-f8958f68d-k8k54           1/1     Running             0          43s
harbor-redis-0                          1/1     Running             0          43s
harbor-registry-69cfc8894d-l4htb        0/2     ContainerCreating   0          43s
harbor-trivy-0                          0/1     ContainerCreating   0          43s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor
NAME                                                    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-harbor-redis-0               Bound    pvc-092c7295-37df-4bf5-8543-33556ba3c80c   1Gi        RWO            default        53s
persistentvolumeclaim/data-harbor-trivy-0               Bound    pvc-10b6b5a3-724b-4e6b-be78-a2400897ff26   5Gi        RWO            default        53s
persistentvolumeclaim/database-data-harbor-database-0   Bound    pvc-e2cd41b9-9c74-4c80-8e83-77fef7bd802a   1Gi        RWO            default        53s
persistentvolumeclaim/harbor-chartmuseum                Bound    pvc-243ee60d-9627-4515-88a1-e86ef8ca0baf   5Gi        RWO            default        53s
persistentvolumeclaim/harbor-jobservice                 Bound    pvc-df1d4b52-852b-41ac-be88-1c63982f1f5b   1Gi        RWO            default        53s
persistentvolumeclaim/harbor-registry                   Bound    pvc-252e5dcf-b7fb-48e7-916f-2a6a4dcb983a   5Gi        RWO            default        53s

NAME                                        READY   STATUS              RESTARTS   AGE
pod/harbor-chartmuseum-86cf75dc4-76rbd      0/1     ContainerCreating   0          53s
pod/harbor-core-566b78d8f-d6m4v             0/1     Running             0          53s
pod/harbor-database-0                       0/1     Running             0          53s
pod/harbor-jobservice-74fc9fb7f-s8cmd       0/1     ContainerCreating   0          53s
pod/harbor-notary-server-749d978d5b-c9r94   0/1     Error               0          53s
pod/harbor-notary-signer-5565f85f68-hvrvf   0/1     Running             1          53s
pod/harbor-portal-f8958f68d-k8k54           1/1     Running             0          53s
pod/harbor-redis-0                          1/1     Running             0          53s
pod/harbor-registry-69cfc8894d-l4htb        0/2     ContainerCreating   0          53s
pod/harbor-trivy-0                          0/1     Running             0          53s

NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/harbor-chartmuseum     ClusterIP   10.0.217.91    <none>        80/TCP              53s
service/harbor-core            ClusterIP   10.0.8.13      <none>        80/TCP              53s
service/harbor-database        ClusterIP   10.0.31.33     <none>        5432/TCP            53s
service/harbor-jobservice      ClusterIP   10.0.165.120   <none>        80/TCP              53s
service/harbor-notary-server   ClusterIP   10.0.165.244   <none>        4443/TCP            53s
service/harbor-notary-signer   ClusterIP   10.0.246.27    <none>        7899/TCP            53s
service/harbor-portal          ClusterIP   10.0.168.201   <none>        80/TCP              53s
service/harbor-redis           ClusterIP   10.0.164.156   <none>        6379/TCP            53s
service/harbor-registry        ClusterIP   10.0.9.17      <none>        5000/TCP,8080/TCP   53s
service/harbor-trivy           ClusterIP   10.0.83.246    <none>        8080/TCP            53s

NAME                             ENDPOINTS           AGE
endpoints/harbor-chartmuseum     <none>              53s
endpoints/harbor-core                                53s
endpoints/harbor-database                            53s
endpoints/harbor-jobservice      <none>              53s
endpoints/harbor-notary-server                       53s
endpoints/harbor-notary-signer                       53s
endpoints/harbor-portal          10.244.4.168:8080   53s
endpoints/harbor-redis           10.244.4.171:6379   53s
endpoints/harbor-registry        <none>              53s
endpoints/harbor-trivy                               53s

NAME                                              CLASS    HOSTS                       ADDRESS          PORTS     AGE
ingress.networking.k8s.io/harbor-ingress          <none>   harbor.nodespringboot.org   20.200.227.196   80, 443   53s
ingress.networking.k8s.io/harbor-ingress-notary   <none>   notary.nodespringboot.org   20.200.227.196   80, 443   53s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor
NAME                                                    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-harbor-redis-0               Bound    pvc-092c7295-37df-4bf5-8543-33556ba3c80c   1Gi        RWO            default        59s
persistentvolumeclaim/data-harbor-trivy-0               Bound    pvc-10b6b5a3-724b-4e6b-be78-a2400897ff26   5Gi        RWO            default        59s
persistentvolumeclaim/database-data-harbor-database-0   Bound    pvc-e2cd41b9-9c74-4c80-8e83-77fef7bd802a   1Gi        RWO            default        59s
persistentvolumeclaim/harbor-chartmuseum                Bound    pvc-243ee60d-9627-4515-88a1-e86ef8ca0baf   5Gi        RWO            default        59s
persistentvolumeclaim/harbor-jobservice                 Bound    pvc-df1d4b52-852b-41ac-be88-1c63982f1f5b   1Gi        RWO            default        59s
persistentvolumeclaim/harbor-registry                   Bound    pvc-252e5dcf-b7fb-48e7-916f-2a6a4dcb983a   5Gi        RWO            default        59s

NAME                                        READY   STATUS              RESTARTS   AGE
pod/harbor-chartmuseum-86cf75dc4-76rbd      0/1     ContainerCreating   0          59s
pod/harbor-core-566b78d8f-d6m4v             0/1     Running             0          59s
pod/harbor-database-0                       1/1     Running             0          59s
pod/harbor-jobservice-74fc9fb7f-s8cmd       0/1     Running             0          59s
pod/harbor-notary-server-749d978d5b-c9r94   0/1     Running             1          59s
pod/harbor-notary-signer-5565f85f68-hvrvf   0/1     Running             1          59s
pod/harbor-portal-f8958f68d-k8k54           1/1     Running             0          59s
pod/harbor-redis-0                          1/1     Running             0          59s
pod/harbor-registry-69cfc8894d-l4htb        0/2     ContainerCreating   0          59s
pod/harbor-trivy-0                          1/1     Running             0          59s

NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/harbor-chartmuseum     ClusterIP   10.0.217.91    <none>        80/TCP              59s
service/harbor-core            ClusterIP   10.0.8.13      <none>        80/TCP              59s
service/harbor-database        ClusterIP   10.0.31.33     <none>        5432/TCP            59s
service/harbor-jobservice      ClusterIP   10.0.165.120   <none>        80/TCP              59s
service/harbor-notary-server   ClusterIP   10.0.165.244   <none>        4443/TCP            59s
service/harbor-notary-signer   ClusterIP   10.0.246.27    <none>        7899/TCP            59s
service/harbor-portal          ClusterIP   10.0.168.201   <none>        80/TCP              59s
service/harbor-redis           ClusterIP   10.0.164.156   <none>        6379/TCP            59s
service/harbor-registry        ClusterIP   10.0.9.17      <none>        5000/TCP,8080/TCP   59s
service/harbor-trivy           ClusterIP   10.0.83.246    <none>        8080/TCP            59s

NAME                             ENDPOINTS           AGE
endpoints/harbor-chartmuseum     <none>              59s
endpoints/harbor-core                                59s
endpoints/harbor-database        10.244.3.164:5432   59s
endpoints/harbor-jobservice                          59s
endpoints/harbor-notary-server                       59s
endpoints/harbor-notary-signer                       59s
endpoints/harbor-portal          10.244.4.168:8080   59s
endpoints/harbor-redis           10.244.4.171:6379   59s
endpoints/harbor-registry        <none>              59s
endpoints/harbor-trivy           10.244.4.173:8080   59s

NAME                                              CLASS    HOSTS                       ADDRESS          PORTS     AGE
ingress.networking.k8s.io/harbor-ingress          <none>   harbor.nodespringboot.org   20.200.227.196   80, 443   59s
ingress.networking.k8s.io/harbor-ingress-notary   <none>   notary.nodespringboot.org   20.200.227.196   80, 443   59s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor
NAME                                                    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-harbor-redis-0               Bound    pvc-092c7295-37df-4bf5-8543-33556ba3c80c   1Gi        RWO            default        64s
persistentvolumeclaim/data-harbor-trivy-0               Bound    pvc-10b6b5a3-724b-4e6b-be78-a2400897ff26   5Gi        RWO            default        64s
persistentvolumeclaim/database-data-harbor-database-0   Bound    pvc-e2cd41b9-9c74-4c80-8e83-77fef7bd802a   1Gi        RWO            default        64s
persistentvolumeclaim/harbor-chartmuseum                Bound    pvc-243ee60d-9627-4515-88a1-e86ef8ca0baf   5Gi        RWO            default        64s
persistentvolumeclaim/harbor-jobservice                 Bound    pvc-df1d4b52-852b-41ac-be88-1c63982f1f5b   1Gi        RWO            default        64s
persistentvolumeclaim/harbor-registry                   Bound    pvc-252e5dcf-b7fb-48e7-916f-2a6a4dcb983a   5Gi        RWO            default        64s

NAME                                        READY   STATUS              RESTARTS   AGE
pod/harbor-chartmuseum-86cf75dc4-76rbd      0/1     ContainerCreating   0          64s
pod/harbor-core-566b78d8f-d6m4v             0/1     Running             0          64s
pod/harbor-database-0                       1/1     Running             0          64s
pod/harbor-jobservice-74fc9fb7f-s8cmd       0/1     Running             0          64s
pod/harbor-notary-server-749d978d5b-c9r94   0/1     Running             1          64s
pod/harbor-notary-signer-5565f85f68-hvrvf   0/1     Running             1          64s
pod/harbor-portal-f8958f68d-k8k54           1/1     Running             0          64s
pod/harbor-redis-0                          1/1     Running             0          64s
pod/harbor-registry-69cfc8894d-l4htb        2/2     Running             0          64s
pod/harbor-trivy-0                          1/1     Running             0          64s

NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/harbor-chartmuseum     ClusterIP   10.0.217.91    <none>        80/TCP              64s
service/harbor-core            ClusterIP   10.0.8.13      <none>        80/TCP              64s
service/harbor-database        ClusterIP   10.0.31.33     <none>        5432/TCP            64s
service/harbor-jobservice      ClusterIP   10.0.165.120   <none>        80/TCP              64s
service/harbor-notary-server   ClusterIP   10.0.165.244   <none>        4443/TCP            64s
service/harbor-notary-signer   ClusterIP   10.0.246.27    <none>        7899/TCP            64s
service/harbor-portal          ClusterIP   10.0.168.201   <none>        80/TCP              64s
service/harbor-redis           ClusterIP   10.0.164.156   <none>        6379/TCP            64s
service/harbor-registry        ClusterIP   10.0.9.17      <none>        5000/TCP,8080/TCP   64s
service/harbor-trivy           ClusterIP   10.0.83.246    <none>        8080/TCP            64s

NAME                             ENDPOINTS                             AGE
endpoints/harbor-chartmuseum     <none>                                64s
endpoints/harbor-core                                                  64s
endpoints/harbor-database        10.244.3.164:5432                     64s
endpoints/harbor-jobservice                                            64s
endpoints/harbor-notary-server                                         64s
endpoints/harbor-notary-signer                                         64s
endpoints/harbor-portal          10.244.4.168:8080                     64s
endpoints/harbor-redis           10.244.4.171:6379                     64s
endpoints/harbor-registry        10.244.4.172:8080,10.244.4.172:5000   64s
endpoints/harbor-trivy           10.244.4.173:8080                     64s

NAME                                              CLASS    HOSTS                       ADDRESS          PORTS     AGE
ingress.networking.k8s.io/harbor-ingress          <none>   harbor.nodespringboot.org   20.200.227.196   80, 443   64s
ingress.networking.k8s.io/harbor-ingress-notary   <none>   notary.nodespringboot.org   20.200.227.196   80, 443   64s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor
NAME                                                    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-harbor-redis-0               Bound    pvc-092c7295-37df-4bf5-8543-33556ba3c80c   1Gi        RWO            default        67s
persistentvolumeclaim/data-harbor-trivy-0               Bound    pvc-10b6b5a3-724b-4e6b-be78-a2400897ff26   5Gi        RWO            default        67s
persistentvolumeclaim/database-data-harbor-database-0   Bound    pvc-e2cd41b9-9c74-4c80-8e83-77fef7bd802a   1Gi        RWO            default        67s
persistentvolumeclaim/harbor-chartmuseum                Bound    pvc-243ee60d-9627-4515-88a1-e86ef8ca0baf   5Gi        RWO            default        67s
persistentvolumeclaim/harbor-jobservice                 Bound    pvc-df1d4b52-852b-41ac-be88-1c63982f1f5b   1Gi        RWO            default        67s
persistentvolumeclaim/harbor-registry                   Bound    pvc-252e5dcf-b7fb-48e7-916f-2a6a4dcb983a   5Gi        RWO            default        67s

NAME                                        READY   STATUS    RESTARTS   AGE
pod/harbor-chartmuseum-86cf75dc4-76rbd      0/1     Running   0          67s
pod/harbor-core-566b78d8f-d6m4v             0/1     Running   0          67s
pod/harbor-database-0                       1/1     Running   0          67s
pod/harbor-jobservice-74fc9fb7f-s8cmd       0/1     Running   0          67s
pod/harbor-notary-server-749d978d5b-c9r94   0/1     Running   1          67s
pod/harbor-notary-signer-5565f85f68-hvrvf   0/1     Running   1          67s
pod/harbor-portal-f8958f68d-k8k54           1/1     Running   0          67s
pod/harbor-redis-0                          1/1     Running   0          67s
pod/harbor-registry-69cfc8894d-l4htb        2/2     Running   0          67s
pod/harbor-trivy-0                          1/1     Running   0          67s

NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/harbor-chartmuseum     ClusterIP   10.0.217.91    <none>        80/TCP              67s
service/harbor-core            ClusterIP   10.0.8.13      <none>        80/TCP              67s
service/harbor-database        ClusterIP   10.0.31.33     <none>        5432/TCP            67s
service/harbor-jobservice      ClusterIP   10.0.165.120   <none>        80/TCP              67s
service/harbor-notary-server   ClusterIP   10.0.165.244   <none>        4443/TCP            67s
service/harbor-notary-signer   ClusterIP   10.0.246.27    <none>        7899/TCP            67s
service/harbor-portal          ClusterIP   10.0.168.201   <none>        80/TCP              67s
service/harbor-redis           ClusterIP   10.0.164.156   <none>        6379/TCP            67s
service/harbor-registry        ClusterIP   10.0.9.17      <none>        5000/TCP,8080/TCP   67s
service/harbor-trivy           ClusterIP   10.0.83.246    <none>        8080/TCP            67s

NAME                             ENDPOINTS                             AGE
endpoints/harbor-chartmuseum                                           67s
endpoints/harbor-core                                                  67s
endpoints/harbor-database        10.244.3.164:5432                     67s
endpoints/harbor-jobservice                                            67s
endpoints/harbor-notary-server                                         67s
endpoints/harbor-notary-signer                                         67s
endpoints/harbor-portal          10.244.4.168:8080                     67s
endpoints/harbor-redis           10.244.4.171:6379                     67s
endpoints/harbor-registry        10.244.4.172:8080,10.244.4.172:5000   67s
endpoints/harbor-trivy           10.244.4.173:8080                     67s

NAME                                              CLASS    HOSTS                       ADDRESS          PORTS     AGE
ingress.networking.k8s.io/harbor-ingress          <none>   harbor.nodespringboot.org   20.200.227.196   80, 443   67s
ingress.networking.k8s.io/harbor-ingress-notary   <none>   notary.nodespringboot.org   20.200.227.196   80, 443   67s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor
NAME                                                    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-harbor-redis-0               Bound    pvc-092c7295-37df-4bf5-8543-33556ba3c80c   1Gi        RWO            default        74s
persistentvolumeclaim/data-harbor-trivy-0               Bound    pvc-10b6b5a3-724b-4e6b-be78-a2400897ff26   5Gi        RWO            default        74s
persistentvolumeclaim/database-data-harbor-database-0   Bound    pvc-e2cd41b9-9c74-4c80-8e83-77fef7bd802a   1Gi        RWO            default        74s
persistentvolumeclaim/harbor-chartmuseum                Bound    pvc-243ee60d-9627-4515-88a1-e86ef8ca0baf   5Gi        RWO            default        74s
persistentvolumeclaim/harbor-jobservice                 Bound    pvc-df1d4b52-852b-41ac-be88-1c63982f1f5b   1Gi        RWO            default        74s
persistentvolumeclaim/harbor-registry                   Bound    pvc-252e5dcf-b7fb-48e7-916f-2a6a4dcb983a   5Gi        RWO            default        74s

NAME                                        READY   STATUS    RESTARTS   AGE
pod/harbor-chartmuseum-86cf75dc4-76rbd      1/1     Running   0          74s
pod/harbor-core-566b78d8f-d6m4v             1/1     Running   0          74s
pod/harbor-database-0                       1/1     Running   0          74s
pod/harbor-jobservice-74fc9fb7f-s8cmd       0/1     Running   0          74s
pod/harbor-notary-server-749d978d5b-c9r94   0/1     Running   1          74s
pod/harbor-notary-signer-5565f85f68-hvrvf   1/1     Running   1          74s
pod/harbor-portal-f8958f68d-k8k54           1/1     Running   0          74s
pod/harbor-redis-0                          1/1     Running   0          74s
pod/harbor-registry-69cfc8894d-l4htb        2/2     Running   0          74s
pod/harbor-trivy-0                          1/1     Running   0          74s

NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/harbor-chartmuseum     ClusterIP   10.0.217.91    <none>        80/TCP              74s
service/harbor-core            ClusterIP   10.0.8.13      <none>        80/TCP              74s
service/harbor-database        ClusterIP   10.0.31.33     <none>        5432/TCP            74s
service/harbor-jobservice      ClusterIP   10.0.165.120   <none>        80/TCP              74s
service/harbor-notary-server   ClusterIP   10.0.165.244   <none>        4443/TCP            74s
service/harbor-notary-signer   ClusterIP   10.0.246.27    <none>        7899/TCP            74s
service/harbor-portal          ClusterIP   10.0.168.201   <none>        80/TCP              74s
service/harbor-redis           ClusterIP   10.0.164.156   <none>        6379/TCP            74s
service/harbor-registry        ClusterIP   10.0.9.17      <none>        5000/TCP,8080/TCP   74s
service/harbor-trivy           ClusterIP   10.0.83.246    <none>        8080/TCP            74s

NAME                             ENDPOINTS                             AGE
endpoints/harbor-chartmuseum     10.244.4.175:9999                     74s
endpoints/harbor-core            10.244.3.162:8080                     74s
endpoints/harbor-database        10.244.3.164:5432                     74s
endpoints/harbor-jobservice                                            74s
endpoints/harbor-notary-server                                         74s
endpoints/harbor-notary-signer   10.244.4.170:7899                     74s
endpoints/harbor-portal          10.244.4.168:8080                     74s
endpoints/harbor-redis           10.244.4.171:6379                     74s
endpoints/harbor-registry        10.244.4.172:8080,10.244.4.172:5000   74s
endpoints/harbor-trivy           10.244.4.173:8080                     74s

NAME                                              CLASS    HOSTS                       ADDRESS          PORTS     AGE
ingress.networking.k8s.io/harbor-ingress          <none>   harbor.nodespringboot.org   20.200.227.196   80, 443   74s
ingress.networking.k8s.io/harbor-ingress-notary   <none>   notary.nodespringboot.org   20.200.227.196   80, 443   74s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> kubectl -n cicd get pvc,pod,svc,ep,ing -l app=harbor
NAME                                                    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-harbor-redis-0               Bound    pvc-092c7295-37df-4bf5-8543-33556ba3c80c   1Gi        RWO            default        84s
persistentvolumeclaim/data-harbor-trivy-0               Bound    pvc-10b6b5a3-724b-4e6b-be78-a2400897ff26   5Gi        RWO            default        84s
persistentvolumeclaim/database-data-harbor-database-0   Bound    pvc-e2cd41b9-9c74-4c80-8e83-77fef7bd802a   1Gi        RWO            default        84s
persistentvolumeclaim/harbor-chartmuseum                Bound    pvc-243ee60d-9627-4515-88a1-e86ef8ca0baf   5Gi        RWO            default        84s
persistentvolumeclaim/harbor-jobservice                 Bound    pvc-df1d4b52-852b-41ac-be88-1c63982f1f5b   1Gi        RWO            default        84s
persistentvolumeclaim/harbor-registry                   Bound    pvc-252e5dcf-b7fb-48e7-916f-2a6a4dcb983a   5Gi        RWO            default        84s

NAME                                        READY   STATUS    RESTARTS   AGE
pod/harbor-chartmuseum-86cf75dc4-76rbd      1/1     Running   0          84s
pod/harbor-core-566b78d8f-d6m4v             1/1     Running   0          84s
pod/harbor-database-0                       1/1     Running   0          84s
pod/harbor-jobservice-74fc9fb7f-s8cmd       1/1     Running   0          84s
pod/harbor-notary-server-749d978d5b-c9r94   1/1     Running   1          84s
pod/harbor-notary-signer-5565f85f68-hvrvf   1/1     Running   1          84s
pod/harbor-portal-f8958f68d-k8k54           1/1     Running   0          84s
pod/harbor-redis-0                          1/1     Running   0          84s
pod/harbor-registry-69cfc8894d-l4htb        2/2     Running   0          84s
pod/harbor-trivy-0                          1/1     Running   0          84s

NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/harbor-chartmuseum     ClusterIP   10.0.217.91    <none>        80/TCP              84s
service/harbor-core            ClusterIP   10.0.8.13      <none>        80/TCP              84s
service/harbor-database        ClusterIP   10.0.31.33     <none>        5432/TCP            84s
service/harbor-jobservice      ClusterIP   10.0.165.120   <none>        80/TCP              84s
service/harbor-notary-server   ClusterIP   10.0.165.244   <none>        4443/TCP            84s
service/harbor-notary-signer   ClusterIP   10.0.246.27    <none>        7899/TCP            84s
service/harbor-portal          ClusterIP   10.0.168.201   <none>        80/TCP              84s
service/harbor-redis           ClusterIP   10.0.164.156   <none>        6379/TCP            84s
service/harbor-registry        ClusterIP   10.0.9.17      <none>        5000/TCP,8080/TCP   84s
service/harbor-trivy           ClusterIP   10.0.83.246    <none>        8080/TCP            84s

NAME                             ENDPOINTS                             AGE
endpoints/harbor-chartmuseum     10.244.4.175:9999                     84s
endpoints/harbor-core            10.244.3.162:8080                     84s
endpoints/harbor-database        10.244.3.164:5432                     84s
endpoints/harbor-jobservice      10.244.4.174:8080                     84s
endpoints/harbor-notary-server   10.244.4.169:4443                     84s
endpoints/harbor-notary-signer   10.244.4.170:7899                     84s
endpoints/harbor-portal          10.244.4.168:8080                     84s
endpoints/harbor-redis           10.244.4.171:6379                     84s
endpoints/harbor-registry        10.244.4.172:8080,10.244.4.172:5000   84s
endpoints/harbor-trivy           10.244.4.173:8080                     84s

NAME                                              CLASS    HOSTS                       ADDRESS          PORTS     AGE
ingress.networking.k8s.io/harbor-ingress          <none>   harbor.nodespringboot.org   20.200.227.196   80, 443   84s
ingress.networking.k8s.io/harbor-ingress-notary   <none>   notary.nodespringboot.org   20.200.227.196   80, 443   84s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor\harbor-1.7.0> 
```
```
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> kubectl -n cicd get ing -l app=harbor
NAME                    CLASS    HOSTS                       ADDRESS          PORTS     AGE
harbor-ingress          <none>   harbor.nodespringboot.org   20.200.227.196   80, 443   8m5s
harbor-ingress-notary   <none>   notary.nodespringboot.org   20.200.227.196   80, 443   8m5s
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> kubectl -n cicd get ing harbor-ingress.yaml > harbor-ingress.yaml.org
Error from server (NotFound): ingresses.networking.k8s.io "harbor-ingress.yaml" not found
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> kubectl -n cicd get ing harbor-ingress -o yaml > harbor-ingress.yaml.org
PS C:\workspace\AzureBasic\2.AKS\GitOps\harbor> kubectl -n cicd get ing harbor-ingress-notary -o yaml > harbor-ingress-notary.yaml.org
```