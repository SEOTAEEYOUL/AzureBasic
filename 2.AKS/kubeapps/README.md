# kubeapp

## 설치 명령
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
kubectl create namespace kubeapps
helm install kubeapps --namespace kubeapps bitnami/kubeapps
```

## 설치 로그
```
PS C:\workspace\AzureBasic\2.AKS\kubeapps> helm install kubeapps -n kubeapps bitnami/kubeapps
NAME: kubeapps
LAST DEPLOYED: Fri Feb 25 20:44:59 2022
NAMESPACE: kubeapps
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: kubeapps
CHART VERSION: 7.7.4
APP VERSION: 2.4.2** Please be patient while the chart is being deployed **

Tip:

  Watch the deployment status using the command: kubectl get pods -w --namespace kubeapps

Kubeapps can be accessed via port 80 on the following DNS name from within your cluster:

   kubeapps.kubeapps.svc.cluster.local

To access Kubeapps from outside your K8s cluster, follow the steps below:

1. Get the Kubeapps URL by running these commands:
   echo "Kubeapps URL: http://127.0.0.1:8080"
   kubectl port-forward --namespace kubeapps service/kubeapps 8080:80

2. Open a browser and access Kubeapps using the obtained URL.

##########################################################################################################
### WARNING: You did not provide a value for the postgresqlPassword so one has been generated randomly ###
##########################################################################################################
PS C:\workspace\AzureBasic\2.AKS\kubeapps>
```

## Token 얻기
```
kubectl get -n default secret $(kubectl get -n default serviceaccount example -o jsonpath='{.secrets[].name}') -o go-template='{{.data.token | base64decode}}' && echo
```

```
PS C:\workspace\AzureBasic\2.AKS\kubeapps> kubectl get -n default secret $(kubectl get -n default serviceaccount example -o jsonpath='{.secrets[].name}') -o go-template='{{.data.token | base64decode}}' && echo
Error from server (NotFound): serviceaccounts "example" not found
Error executing template: template: output:1:16: executing "output" at <base64decode>: invalid value; expected string. Printing more information for debugging the template:
        template was:
                {{.data.token | base64decode}}
        raw data was:
                {"apiVersion":"v1","items":[{"apiVersion":"v1","data":{"ca.crt":"LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUU2VENDQXRHZ0F3SUJBZ0lSQUtnWlNiYmF4V05VbndPMUVacE1xQm93RFFZSktvWklodmNOQVFFTEJRQXcKRFRFTE1Ba0dBMVVFQXhNQ1kyRXdJQmNOTWpJd01qSTBNRFl5TURJd1doZ1BNakExTWpBeU1qUXdOak13TWpCYQpNQTB4Q3pBSkJnTlZCQU1UQW1OaE1JSUNJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBZzhBTUlJQ0NnS0NBZ0VBCncrb0t1MUZEVk11cjlZdFhkTUpFQU42WG1RWUQ4WGFpT2M4UFN6RlNkdFVZRHB2WENCSWdPczM2d2JmNk8ySGIKbDNsT3ltNnB1M0F5SEFmdnFLQ0dYK3Q0a0xxbmhDT1hha1VkVXBvZ1B2YVU1eFlhZzdkV0kwc3MxQnovZ2tuVAplWlNpWGd1S204RmxXVkllQUhqV3lpY01uc0h4Ky9nVXpoR0VTWnhhRWN0VDNEL214WFZYZXFvNnp5NnJWUTlOCnB1MmZlSksxM2xucnBpVE5aTWJ3NWxueWhmMk9YSWdOZERPYkdEelBHcHFTN3NEK09mVGxOY09yT3lCbWpTVlMKNW11alR2MWZQZnpBWWxsUTAvY05yMk43UE5XZWFRUlp3emp2ZEt5UHQxMzFTUUJvOE94MnhWK1pGVDBKU2tOTwpLQW5ZdXlnSG9PUVducGdwNVZCbFMyU05vd3p6azdmYXczanpxaDBmQXVwQ3psOHpzVWh2ZVZVYTQxQlNxVW1ICjBpbUxIUEtkU0lzcTIwUDhVWkRUTnIzUVhDTGMrNDhERXk2bi9MUTVacGk2a0wxNzhaTkZ6L0F5QnRuSlZ2MnEKbG83WkxtcVpXQWJIMDRGd0JGOVU2aFBmRzhlVTFoRnhpdThsTUlFamtqUUl6b0E3b2diZVhvWXB5anBGQzg2SQpPcXlnQ0tvQUpHL1RVcjlCUXJydXpVVkwxSUxVc2pYVGF2QmxyeE9LL3Z0SVVJamlibEVxbWUyd1lNZ0dZL2lDCklFTFF4N2ttNlArd2NqblVRb1A0Q3FtdEkzTUpMcUhUaFAyOFNNSU1FYXFqNERCOUdYRHFjUnFKNUhXOHNzckgKOVRoQUtOVTI0enYwaUwyNTJPUnQxYlBsckdlRkdtem15eFdpVDdSb29Ta0NBd0VBQWFOQ01FQXdEZ1lEVlIwUApBUUgvQkFRREFnS2tNQThHQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGTnRrTDV1QnBadFdSNUU1CjFURndkcEhId3JwTU1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQ0FRQ1oyZm43Z2E4ZWprSFVUbTYzZURBV2E5VkcKVFFvdVdCK0hLNGpiS2ZLcUxDTW1HVGY2U3BsU1dKNEVHTUlDU1h2UUgxWkdmRjdJWVRNa0ZLSnZLbXRYRkNzNAp6d2xDVHdvMGxoTTJLYUlCUy95WGpzMGF5RTRidW1MaWZ6TzFPR0o5WVJjTnZOUk1QRVBJT2ZUV1UvTU1iZkV2CndURzhTVXc5TnRJTXBzaWdjU2FXdktWUThVOUV3ajBFSllpMTVGVW10QTl6eXY4bXdKdUQ2MGlqT1hMQjk0TE8KbUwzWElwVmZxQmZwTXB1RDNOY2pHT2tNZERid2VDRVpGY2J4c29CaE9Ea0pqRjhMSkp4L2hJbmJtTGFiTG1IUQp2UW5TbUFIemczRnFnU2RwR2xnQXdqMURoWnNDeEdHMUxvSHl1UTBPaEd6dUpZSHkwOURvdGlLVVNnYXRVZWYvCjByc01pVWxjMGxVY3V2Qzg5MDVGcStTcE9MRkl5VkRsdXB3NlM2WWV5SDJiRzhuTTRrcHMva3dUdkFzK24yakMKU2ZWcmdFZjdCN2NhQW1mT09zanMrSTVrR0p6ejNXOFUxN1ZkMHhtWG5hTStpSGNGOGd4ZDdYQStEek9OMFJmRQozdkNSNGoyQ2dXTEg5T29hcWtvR0tWRi9xUXhKQzNmVmFSKzdWSnkzV3djS2ZwTlIxVnJhUW54WGJETkZqc1hzCmQwQXo2d2dlY3Yxbmt6alJxYzdTcVlDY2F1OEd5b3FNWDdiSXljU1R6Qm56NGMxM1VYWkFGcUo3aGYrWmpod3oKSFFwTi9PYWtnRmsrM3BwSUxTbXpOY0cwZUxWSDRwWXRycDJZcEZ1SDVNbTdTL2JHTnRwU1ZGQTZpcW0wNTM4TAoya2JNSy93SGc0TWJ2VnJvcXc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==","namespace":"ZGVmYXVsdA==","token":"ZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkluRjRaRXQ0UnpJMGFURk5YMmRFTlZac2RVVXpSMmRsUVhGUWRsUmtXWEY2WkdWMU9VNTJUM0pIY1VVaWZRLmV5SnBjM01pT2lKcmRXSmxjbTVsZEdWekwzTmxjblpwWTJWaFkyTnZkVzUwSWl3aWEzVmlaWEp1WlhSbGN5NXBieTl6WlhKMmFXTmxZV05qYjNWdWRDOXVZVzFsYzNCaFkyVWlPaUprWldaaGRXeDBJaXdpYTNWaVpYSnVaWFJsY3k1cGJ5OXpaWEoyYVdObFlXTmpiM1Z1ZEM5elpXTnlaWFF1Ym1GdFpTSTZJbVJsWm1GMWJIUXRkRzlyWlc0dGJEaDJkM0FpTENKcmRXSmxjbTVsZEdWekxtbHZMM05sY25acFkyVmhZMk52ZFc1MEwzTmxjblpwWTJVdFlXTmpiM1Z1ZEM1dVlXMWxJam9pWkdWbVlYVnNkQ0lzSW10MVltVnlibVYwWlhNdWFXOHZjMlZ5ZG1salpXRmpZMjkxYm5RdmMyVnlkbWxqWlMxaFkyTnZkVzUwTG5WcFpDSTZJbU15Tm1KaFl6bGxMVFJrT1dJdE5EWmxPUzFoTnpRM0xUQmlNRE0yWmprMk4ySmtaQ0lzSW5OMVlpSTZJbk41YzNSbGJUcHpaWEoyYVdObFlXTmpiM1Z1ZERwa1pXWmhkV3gwT21SbFptRjFiSFFpZlEuZkJnOHFhZkdBRnNzbDlqVTBjMlJ1T0xtR3pKUG9QUjVaZFU2VUdlTk5rX0lPeW4zNHdWY2NvSEpkekJGZUY3MHR4VDNNQTZLMG1MZWt2NTZWdmt1X3JaMXNRc3JYbDlHWmI0cjRxVnNScExreGUtQ3VTMlNHYlNLNVkzNFRKbXFvOURLOWpidHRidlFRYXJOSjJrdXlfejYyQjl6VlRObm1NWm1OaWFQWURTU2lXWWJ6RGFzWE9pQ1BnT056Vi1aOUJnQ0RmM2hVeXN3eE55UjBNV1l5SGJPOWFWQk0wU0VrcjdpZHFOOXd0eHZNZWxtU2s1MXNaa0FNalloZFREZTNoc2E4eW1Wemc2WDUyMHMxRDg2OFN4d0NhY2UzV3Q1U1RUcjhmNkFORmtnTUlUZ254RzFzTTlRWDJfZy1jN0lJMTFveGNxS0ZlWFQ2U05wbXdzbG5la2FFUTA0N0VTam14NWdDcjhGdE5VbS0zSXI0ZWhRUXYtTWJqNzZuRTZpbVdHVFRPOFctLWNSNzItc0otVllCMUQ4SGtjQjV6TENuSjM2WGtsRkNaVk9Ca1haTEVvOThSNDQ5ZkZnWFNjbERzNnVnTUhqQk96cWtPWnE0TGt0N3FwUEpHNVdEeHk0dUcwRmxMd216MnZMdHRjc2N0dzVOMVVfSnF0SG9oZ2o4VHpTNExvRXl1S1ExeHBiNHNieGdKQ0VKRlNRa0RyQll4SlRodGZHNDVCaGNYWEcyMUNfcE05RFFDNEYyUWo2clpCczctTFVqWFZwTDdGU0Z4bHFfdGozdVVlMmlkYnNGWS1RSmhySmlCcnNsanNsMGVYZl9mZWVqdy1hTno0Y1YxbzlIdWlyLWFTWXJ1VlBPbmJuanNOYm9zclVkS3Q5bGRWV3Y4cEhRdW8="},"kind":"Secret","metadata":{"annotations":{"kubernetes.io/service-account.name":"default","kubernetes.io/service-account.uid":"c26bac9e-4d9b-46e9-a747-0b036f967bdd"},"creationTimestamp":"2022-02-24T06:32:00Z","managedFields":[{"apiVersion":"v1","fieldsType":"FieldsV1","fieldsV1":{"f:data":{".":{},"f:ca.crt":{},"f:namespace":{},"f:token":{}},"f:metadata":{"f:annotations":{".":{},"f:kubernetes.io/service-account.name":{},"f:kubernetes.io/service-account.uid":{}}},"f:type":{}},"manager":"kube-controller-manager","operation":"Update","time":"2022-02-24T06:32:00Z"}],"name":"default-token-l8vwp","namespace":"default","resourceVersion":"382","uid":"fb816330-24f0-499e-8576-8e5a71eb8391"},"type":"kubernetes.io/service-account-token"}],"kind":"List","metadata":{"resourceVersion":"","selfLink":""}}
        object given to template engine was:
                map[apiVersion:v1 items:[map[apiVersion:v1 data:map[ca.crt:LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUU2VENDQXRHZ0F3SUJBZ0lSQUtnWlNiYmF4V05VbndPMUVacE1xQm93RFFZSktvWklodmNOQVFFTEJRQXcKRFRFTE1Ba0dBMVVFQXhNQ1kyRXdJQmNOTWpJd01qSTBNRFl5TURJd1doZ1BNakExTWpBeU1qUXdOak13TWpCYQpNQTB4Q3pBSkJnTlZCQU1UQW1OaE1JSUNJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBZzhBTUlJQ0NnS0NBZ0VBCncrb0t1MUZEVk11cjlZdFhkTUpFQU42WG1RWUQ4WGFpT2M4UFN6RlNkdFVZRHB2WENCSWdPczM2d2JmNk8ySGIKbDNsT3ltNnB1M0F5SEFmdnFLQ0dYK3Q0a0xxbmhDT1hha1VkVXBvZ1B2YVU1eFlhZzdkV0kwc3MxQnovZ2tuVAplWlNpWGd1S204RmxXVkllQUhqV3lpY01uc0h4Ky9nVXpoR0VTWnhhRWN0VDNEL214WFZYZXFvNnp5NnJWUTlOCnB1MmZlSksxM2xucnBpVE5aTWJ3NWxueWhmMk9YSWdOZERPYkdEelBHcHFTN3NEK09mVGxOY09yT3lCbWpTVlMKNW11alR2MWZQZnpBWWxsUTAvY05yMk43UE5XZWFRUlp3emp2ZEt5UHQxMzFTUUJvOE94MnhWK1pGVDBKU2tOTwpLQW5ZdXlnSG9PUVducGdwNVZCbFMyU05vd3p6azdmYXczanpxaDBmQXVwQ3psOHpzVWh2ZVZVYTQxQlNxVW1ICjBpbUxIUEtkU0lzcTIwUDhVWkRUTnIzUVhDTGMrNDhERXk2bi9MUTVacGk2a0wxNzhaTkZ6L0F5QnRuSlZ2MnEKbG83WkxtcVpXQWJIMDRGd0JGOVU2aFBmRzhlVTFoRnhpdThsTUlFamtqUUl6b0E3b2diZVhvWXB5anBGQzg2SQpPcXlnQ0tvQUpHL1RVcjlCUXJydXpVVkwxSUxVc2pYVGF2QmxyeE9LL3Z0SVVJamlibEVxbWUyd1lNZ0dZL2lDCklFTFF4N2ttNlArd2NqblVRb1A0Q3FtdEkzTUpMcUhUaFAyOFNNSU1FYXFqNERCOUdYRHFjUnFKNUhXOHNzckgKOVRoQUtOVTI0enYwaUwyNTJPUnQxYlBsckdlRkdtem15eFdpVDdSb29Ta0NBd0VBQWFOQ01FQXdEZ1lEVlIwUApBUUgvQkFRREFnS2tNQThHQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGTnRrTDV1QnBadFdSNUU1CjFURndkcEhId3JwTU1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQ0FRQ1oyZm43Z2E4ZWprSFVUbTYzZURBV2E5VkcKVFFvdVdCK0hLNGpiS2ZLcUxDTW1HVGY2U3BsU1dKNEVHTUlDU1h2UUgxWkdmRjdJWVRNa0ZLSnZLbXRYRkNzNAp6d2xDVHdvMGxoTTJLYUlCUy95WGpzMGF5RTRidW1MaWZ6TzFPR0o5WVJjTnZOUk1QRVBJT2ZUV1UvTU1iZkV2CndURzhTVXc5TnRJTXBzaWdjU2FXdktWUThVOUV3ajBFSllpMTVGVW10QTl6eXY4bXdKdUQ2MGlqT1hMQjk0TE8KbUwzWElwVmZxQmZwTXB1RDNOY2pHT2tNZERid2VDRVpGY2J4c29CaE9Ea0pqRjhMSkp4L2hJbmJtTGFiTG1IUQp2UW5TbUFIemczRnFnU2RwR2xnQXdqMURoWnNDeEdHMUxvSHl1UTBPaEd6dUpZSHkwOURvdGlLVVNnYXRVZWYvCjByc01pVWxjMGxVY3V2Qzg5MDVGcStTcE9MRkl5VkRsdXB3NlM2WWV5SDJiRzhuTTRrcHMva3dUdkFzK24yakMKU2ZWcmdFZjdCN2NhQW1mT09zanMrSTVrR0p6ejNXOFUxN1ZkMHhtWG5hTStpSGNGOGd4ZDdYQStEek9OMFJmRQozdkNSNGoyQ2dXTEg5T29hcWtvR0tWRi9xUXhKQzNmVmFSKzdWSnkzV3djS2ZwTlIxVnJhUW54WGJETkZqc1hzCmQwQXo2d2dlY3Yxbmt6alJxYzdTcVlDY2F1OEd5b3FNWDdiSXljU1R6Qm56NGMxM1VYWkFGcUo3aGYrWmpod3oKSFFwTi9PYWtnRmsrM3BwSUxTbXpOY0cwZUxWSDRwWXRycDJZcEZ1SDVNbTdTL2JHTnRwU1ZGQTZpcW0wNTM4TAoya2JNSy93SGc0TWJ2VnJvcXc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg== namespace:ZGVmYXVsdA== token:ZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkluRjRaRXQ0UnpJMGFURk5YMmRFTlZac2RVVXpSMmRsUVhGUWRsUmtXWEY2WkdWMU9VNTJUM0pIY1VVaWZRLmV5SnBjM01pT2lKcmRXSmxjbTVsZEdWekwzTmxjblpwWTJWaFkyTnZkVzUwSWl3aWEzVmlaWEp1WlhSbGN5NXBieTl6WlhKMmFXTmxZV05qYjNWdWRDOXVZVzFsYzNCaFkyVWlPaUprWldaaGRXeDBJaXdpYTNWaVpYSnVaWFJsY3k1cGJ5OXpaWEoyYVdObFlXTmpiM1Z1ZEM5elpXTnlaWFF1Ym1GdFpTSTZJbVJsWm1GMWJIUXRkRzlyWlc0dGJEaDJkM0FpTENKcmRXSmxjbTVsZEdWekxtbHZMM05sY25acFkyVmhZMk52ZFc1MEwzTmxjblpwWTJVdFlXTmpiM1Z1ZEM1dVlXMWxJam9pWkdWbVlYVnNkQ0lzSW10MVltVnlibVYwWlhNdWFXOHZjMlZ5ZG1salpXRmpZMjkxYm5RdmMyVnlkbWxqWlMxaFkyTnZkVzUwTG5WcFpDSTZJbU15Tm1KaFl6bGxMVFJrT1dJdE5EWmxPUzFoTnpRM0xUQmlNRE0yWmprMk4ySmtaQ0lzSW5OMVlpSTZJbk41YzNSbGJUcHpaWEoyYVdObFlXTmpiM1Z1ZERwa1pXWmhkV3gwT21SbFptRjFiSFFpZlEuZkJnOHFhZkdBRnNzbDlqVTBjMlJ1T0xtR3pKUG9QUjVaZFU2VUdlTk5rX0lPeW4zNHdWY2NvSEpkekJGZUY3MHR4VDNNQTZLMG1MZWt2NTZWdmt1X3JaMXNRc3JYbDlHWmI0cjRxVnNScExreGUtQ3VTMlNHYlNLNVkzNFRKbXFvOURLOWpidHRidlFRYXJOSjJrdXlfejYyQjl6VlRObm1NWm1OaWFQWURTU2lXWWJ6RGFzWE9pQ1BnT056Vi1aOUJnQ0RmM2hVeXN3eE55UjBNV1l5SGJPOWFWQk0wU0VrcjdpZHFOOXd0eHZNZWxtU2s1MXNaa0FNalloZFREZTNoc2E4eW1Wemc2WDUyMHMxRDg2OFN4d0NhY2UzV3Q1U1RUcjhmNkFORmtnTUlUZ254RzFzTTlRWDJfZy1jN0lJMTFveGNxS0ZlWFQ2U05wbXdzbG5la2FFUTA0N0VTam14NWdDcjhGdE5VbS0zSXI0ZWhRUXYtTWJqNzZuRTZpbVdHVFRPOFctLWNSNzItc0otVllCMUQ4SGtjQjV6TENuSjM2WGtsRkNaVk9Ca1haTEVvOThSNDQ5ZkZnWFNjbERzNnVnTUhqQk96cWtPWnE0TGt0N3FwUEpHNVdEeHk0dUcwRmxMd216MnZMdHRjc2N0dzVOMVVfSnF0SG9oZ2o4VHpTNExvRXl1S1ExeHBiNHNieGdKQ0VKRlNRa0RyQll4SlRodGZHNDVCaGNYWEcyMUNfcE05RFFDNEYyUWo2clpCczctTFVqWFZwTDdGU0Z4bHFfdGozdVVlMmlkYnNGWS1RSmhySmlCcnNsanNsMGVYZl9mZWVqdy1hTno0Y1YxbzlIdWlyLWFTWXJ1VlBPbmJuanNOYm9zclVkS3Q5bGRWV3Y4cEhRdW8=] kind:Secret metadata:map[annotations:map[kubernetes.io/service-account.name:default kubernetes.io/service-account.uid:c26bac9e-4d9b-46e9-a747-0b036f967bdd] creationTimestamp:2022-02-24T06:32:00Z managedFields:[map[apiVersion:v1 fieldsType:FieldsV1 fieldsV1:map[f:data:map[.:map[] f:ca.crt:map[] f:namespace:map[] f:token:map[]] f:metadata:map[f:annotations:map[.:map[] f:kubernetes.io/service-account.name:map[] f:kubernetes.io/service-account.uid:map[]]] f:type:map[]] manager:kube-controller-manager operation:Update time:2022-02-24T06:32:00Z]] name:default-token-l8vwp namespace:default resourceVersion:382 uid:fb816330-24f0-499e-8576-8e5a71eb8391] type:kubernetes.io/service-account-token]] kind:List metadata:map[resourceVersion: selfLink:]]

error: error executing template "{{.data.token | base64decode}}": template: output:1:16: executing "output" at <base64decode>: invalid value; expected string
PS C:\workspace\AzureBasic\2.AKS\kubeapps> 
```
```
PS C:\workspace\AzureBasic\2.AKS\kubeapps> kubectl create -n kubeapps serviceaccount skccadmin                                                                                                      serviceaccount/skccadmin created
PS C:\workspace\AzureBasic\2.AKS\kubeapps> kubectl get -n kubeapps secret $(kubectl get -n kubeapps serviceaccount skccadmin -o jsonpath='{.secrets[].name}') -o go-template='{{.data.token | base64decode}}' && echo
eyJhbGciOiJSUzI1NiIsImtpZCI6InF4ZEt4RzI0aTFNX2dENVZsdUUzR2dlQXFQdlRkWXF6ZGV1OU52T3JHcUUifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlYXBwcyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJza2NjYWRtaW4tdG9rZW4tOW5tdHEiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoic2tjY2FkbWluIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiYThkNDYzNjktNTUyZC00ZGU0LTg0ZTctZTdlZGQ4YjIwZjlkIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmVhcHBzOnNrY2NhZG1pbiJ9.CKjQ6XSgFPbytOfms3JwsYgalSaI3udiXU4Py9-1eCUxInUe5oeM_R6XK6xYPBT3C_WaAVRCWwboLC7WBzfI6GsBbWJXyM99sify4VqOfpAY0-vSGXn0TWnWP1JHIL6Q9vgfN5tOCXsotOKxQZ-DYQXM1-lfCnm4GrfxhOxjvfGz90WZIHJPxD3ZzVOFSlncS9WELs7pua4VRNFsLSQ7fQ6IQStobTh02YNJoXiT1poJ0sr-EVN1fekZ3RWG5gKeAe7FdIGxniun9qA673YEld3lgUjR-hf9THyFqFoVeyaOHiMQCHJX1ceOi6lVXRsHhWMjpgwshedH_fMLpEIFVMy8noUkMjL8Ts1Z19vwpz3gYYrF9lDBgtWktzT7_3iB5J8ehE-rO97EmLCWFYZqvpOONZfWFpv9bjXyEQn3aG9doZNeJU12hbrNXjH8F3MSXIshbiWSB_xGU8oWaCviCzUifkW5P-sV1SdhteQvMbjjmAHqOwyKmmjT2B94y2IXBmk-k0JfZdUpFaC3hs9gCJqx8UFXbvqGP9FgLyMq_dE14HooHcYrhIyu2DbGnOb2ebvR5girpfvoZXhTgmAld7pfa2xKTIsCRxwxG8c2TITJjGxNVwFkZIBeuunEK0F89c6YXXcAG7gcJRxJDrnp1fWBcwfelENNBma-BvSmNH4
cmdlet Write-Output at command pipeline position 1
Supply values for the following parameters:
InputObject: skccadmin
skccadmin
PS C:\workspace\AzureBasic\2.AKS\kubeapps>
```