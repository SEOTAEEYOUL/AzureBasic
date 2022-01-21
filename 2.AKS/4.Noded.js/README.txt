1. Install nodejs 8
# curl -sL https://rpm.nodesource.com/setup_8.x | bash -
# yum install nodejs -y
# node -v
v8.16.1
# npm -v
6.4.1


2. nodejs package 설치
# cat package.json
{
  "name": "chatbot",
  "version": "0.1.0",
  "description": "",
  "main": "server.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "body-parser": "^1.19.0",
    "botkit": "^0.6.21",
    "dateformat": "^3.0.3",
    "dotenv": "^8.1.0",
    "express": "^4.17.1",
    "kubernetes-client": "^8.3.4",
    "prom-client": "^11.5.3",
    "prometheus-gc-stats": "^0.6.2",
    "slack-client": "^2.0.6",
    "slack-node": "^0.1.8"
  }
}
# npm install body-parser --save
# npm install botkit@0.7 --save
# npm install dateformat -save
# npm install dotenv -save
# npm install express -save
# npm install kubernetes-client -save
# npm install prom-client -save
# npm install prometheus-gc-stats -save
# npm install slack-client -save
# npm install slack-node -save

# cat package.json
{
  "name": "chatbot",
  "version": "0.1.0",
  "description": "",
  "main": "server.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "body-parser": "^1.19.0",
    "botkit": "^0.7.4",
    "dateformat": "^3.0.3",
    "dotenv": "^8.1.0",
    "express": "^4.17.1",
    "kubernetes-client": "^8.3.4",
    "prom-client": "^11.5.3",
    "prometheus-gc-stats": "^0.6.2",
    "slack-client": "^2.0.6",
    "slack-node": "^0.1.8"
  }
}

# Repsitory 생성
# sh ctl.sh -r
2019/09/16-09:00:16
r is
namespace       : [walkerhill]
component       : []
build           : []
exec            : []
repository      : [on]
log             : []
apply configmap : []
tail_rows       : [100]
aws ecr create-repository --repository-name nodejs-bot --region ap-northeast-2
{
    "repository": {
        "repositoryUri": "723226886640.dkr.ecr.ap-northeast-2.amazonaws.com/nodejs-bot",
        "registryId": "723226886640",
        "imageTagMutability": "MUTABLE",
        "repositoryArn": "arn:aws:ecr:ap-northeast-2:723226886640:repository/nodejs-bot",
        "repositoryName": "nodejs-bot",
        "createdAt": 1568624433.0
    }
}
No resources found.
kubectl -n walkerhill get pod -lcomponent= | grep -v NAME | awk { print  }
pod not found


# Docker Build
# sh ctl -b

# Jenkins

$ kubectl -n mta-cicd get sa jenkins-robot
NAME            SECRETS   AGE
jenkins-robot   1         6d23h

$ kubectl -n mta-cicd get sa jenkins-robot -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2020-07-14T09:23:22Z"
  name: jenkins-robot
  namespace: mta-cicd
  resourceVersion: "4410283"
  selfLink: /api/v1/namespaces/mta-cicd/serviceaccounts/jenkins-robot
  uid: 35dbab7c-af83-489a-b421-b16b31d1b071
secrets:
- name: jenkins-robot-token-2dlvb


$ kubectl -n mta-cicd get clusterrolebinding jenkins-robot-binding -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  creationTimestamp: "2020-07-15T09:38:56Z"
  name: jenkins-robot-binding
  resourceVersion: "4612815"
  selfLink: /apis/rbac.authorization.k8s.io/v1/clusterrolebindings/jenkins-robot-binding
  uid: f1bd487e-3c48-44ba-bd77-e191d542bec9
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: jenkins-robot
  namespace: mta-cicd

$ kubectl -n mta-cicd describe secret jenkins-robot-token-2dlvb
Name:         jenkins-robot-token-2dlvb
Namespace:    mta-cicd
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: jenkins-robot
              kubernetes.io/service-account.uid: 35dbab7c-af83-489a-b421-b16b31d1b071

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1025 bytes
namespace:  8 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6Inl6TllabldmcjRaV0k5eFZLYVFaUHBYQjFxVDVzd0JLX0xsWWtaNGt1SVUifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtdGEtY2ljZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJqZW5raW5zLXJvYm90LXRva2VuLTJkbHZiIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImplbmtpbnMtcm9ib3QiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIzNWRiYWI3Yy1hZjgzLTQ4OWEtYjQyMS1iMTZiMzFkMWIwNzEiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6bXRhLWNpY2Q6amVua2lucy1yb2JvdCJ9.p3dLa__1BpASRKCFe3iykyHrUzEnRLyI4gSTyUHm0fP-oKVqlHl-sZuMwzqin2G3v29efTqjGBE0byOhTsMm02CSue1b4rdcPUU7NqFq14L1apXOj1jRgv3gk6KzWpE8mJzdh3nx70mtJ7QzYtD--N8ctQb7WOyeZf2j2xBub3U7ViPcENVtbMeY0-k9jSuYGQmI7rav2VbwDSW0u5zlJiVDN5ysAvDnp_4rEtubwjEBrFlBbI6F-gjHtIz9LPHKWbGwkw2nG2PzqWmdfKkRbob5IwJjWRSXeaGvVxcJwRrkenH8ej5eKU1Mq04QC4L-6g8HY9dznwLJ6RCHM97EXg

In Gitea: under repo -> Settings -> Webhooks, add new webhook, set the URL to http://jenkins_url.your.org/gitea-webhook/post, and clear the secret (leave it blank).
curl -vvv -H "Content-Type: application/json" -H "X-Gitea-Event: push" -X POST http://jenkins.skmta.net/gitea-webhook/post -d "{}"
