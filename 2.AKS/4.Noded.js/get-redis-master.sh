#!/bin/bash
HOSTNAME="172.30.0.21,skt-mtwpmst01
172.30.0.22,skt-mtwpmst02
172.30.0.23,skt-mtwpmst03
172.30.0.24,skt-mtwpprx01
172.30.0.25,skt-mtwpprx02
172.30.0.26,skt-mtwpprx03
172.30.0.27,skt-mtwpwk01
172.30.0.28,skt-mtwpwk02
172.30.0.29,skt-mtwpwk03
172.30.0.30,skt-mtwpmgt01
172.30.0.31,skt-mtwpmgt02
172.30.0.32,skt-mtwpva01
172.30.0.65,skt-mtwpwk04
172.30.0.66,skt-mtwpwk05
172.30.0.67,skt-mtwpwk06
172.30.0.68,skt-mtwpwk07
172.30.0.69,skt-mtwpwk08
172.30.0.70,skt-mtwpwk09
172.30.0.71,skt-mtwpmgt03
172.30.0.72,skt-mtwpadm01"
NAMESPACE="mtw-prd-nod,운영:node-redis
mtw-prd-bff,운영:bff-redis
mtw-prd-cor,운영:core-redis
mtw-prd-tos,운영:tos-redis"
namespace=""
namespace_name=""
pod_name=""
ip=""
hostname=""
 
for n in $NAMESPACE
do
  namespace=`echo "$n" | cut -d',' -f1`
  namespace_name=`echo "$n" | cut -d',' -f2`
  # echo "$namespace [$namespace_name]"
  # kubectl get pod -o wide -lredis-role --all-namespaces -o custom-columns="namespace:metadata.namespace,name:metadata.name,IP:spec.nodeName,APP:metadata.labels.redis-role||awk '{print $1','$2','$3}'"
  pod=`kubectl get pod -o wide -lredis-role=master -n $namespace -o custom-columns="NAME:metadata.name,IP:spec.nodeName" --no-headers| awk '{ print $1","$2 }'`
  for p in $pod
  do
    pod_name=`echo "$p" | cut -d',' -f1`
    ip=`echo "$p" | cut -d',' -f2`
    for h in $HOSTNAME
    do
      f1=`echo "$h" | cut -d',' -f1`
      if [ "$f1" == "$ip" ]
      then
        hostname=`echo "$h" | cut -d',' -f2`
        # printf "[%-12s] %-50s %s[%s]\n" $namespace $pod_name $hostname $ip
        printf "[%-10s] %-45s %s[%s]\n" $namespace $pod_name $hostname $ip
        # [mtw-prd-nod] backing-redis-node-ibm-redis-ha-dev-server-1  skt-mtwpwk04[172.30.0.65]
        # [mtw-prd-bff] backing-redis-bff-ibm-redis-ha-dev-server-1   skt-mtwpwk04[172.30.0.65]
        # [mtw-prd-cor] backing-redis-core-ibm-redis-ha-dev-server-2  skt-mtwpwk09[172.30.0.70]
        # [mtw-prd-tos] backing-redis-tos-ibm-redis-ha-dev-server-2   skt-mtwpwk05[172.30.0.66]
        # printf "%-50s %s[%s]\n" $pod_name $hostname $ip
        break;
      fi
    done
  done
done
