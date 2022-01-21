#!/bin/bash
# image_server=harbor.apps.hcp.darumtech.net
image_server=harbor.skmta.net
id=admin
pw=Skmta2020!
namespace="mta-dev"
app="nodejs-bot"
version="1.0.5"
component=${app}
pod=""
chk_exec=""
chk_log=""
chk_restart=""
chk_build=""
chk_deploy=""
tail_rows=100
main( ) {
  today
  if [ $# -eq 0 ]
  then
    usage
    exit 1;
  fi
  while getopts "n:c:t:abderlh" opt
  do
    case $opt in
      n)
        echo "$opt is ${OPTARG}"
        namespace=${OPTARG}
        ;;
      c)
        echo "$opt is ${OPTARG}"
        component=${OPTARG}
        ;;
      e)
        echo "$opt is ${OPTARG}"
        chk_exec="on"
        ;;
      l)
        echo "$opt is ${OPTARG}"
        chk_log="on"
        ;;
      t)
        echo "$opt is ${OPTARG}"
        tail_rows=${OPTARG}
        ;;
      r)
        echo "$opt is ${OPTARG}"
        chk_restart="on"
        ;;
      a)
        echo "$opt is ${OPTARG}"
        chk_apply="on"
        ;;
      b)
        echo "$opt is ${OPTARG}"
        chk_build="on"
        ;;
      d)
        echo "$opt is ${OPTARG}"
        chk_deploy="on"
        ;;
      h | *)
        echo "h|* is ${OPTARG}"
        usage
        exit 1;
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        usage
        exit 1;
        ;;
      :)
        echo "Option -$OPTARG requires an argument." >&2
        exit 1;
        ;;
    esac
  done
  echo "namespace       : [$namespace]"
  echo "component       : [$component]"
  echo "build           : [$chk_build]"
  echo "deploy          : [$chk_deploy]"
  echo "exec            : [$chk_exec]"
  echo "restart         : [$chk_restart]"
  echo "log             : [$chk_log]"
  echo "apply configmap : [$apply]"
  echo "tail_rows       : [$tail_rows]"
  if [ "$chk_build" == "on" ]
  then
    build
  fi
  if [ "$chk_deploy" == "on" ]
  then
    deploy
  fi
  find
  if [ $? -ne 0 ]
  then
    exit 1;
  fi
  echo "pod             : [$pod]"
  if [ "$chk_exec" == "on" ]
  then
    exec_sh
  fi
  if [ "$chk_apply" == "on" ]
  then
    apply
  fi
  if [ "$chk_log" == "on" ]
  then
    log
  fi
  if [ "$chk_restart" == "on" ]
  then
    restart
  fi
  exit 0
}
today( ) {
  date +%Y/%m/%d-%H:%M:%d
}
usage( ) {
  echo "Usage : $0 [-n namespace] [-c component ] [-l] [-r] [-a] [-t tail row count] [-[-p]"
  echo "        -n : namespace"
  echo "        -a : apply configmap"
  echo "        -l : $component log"
  echo "        -l : $component log -t0"
  echo "        -l : $component log -t200"
  echo "        -r : $compnent restart"
  echo "        $0 -l"
  echo "        $0 -a"
  echo "        $0 -r"
  return ;
}

build( ) {
  docker login ${image_server} -u ${id} -p ${pw}
  docker rmi ${app}:${version} ${image_server}/${namespace}/${app}:${version}
  docker build --rm=true --network=host --tag ${app}:${version} .
  if [ $? -ne 0 ]
  then
    echo "Error Docker Build !!!"
    return 1 ;
  fi
  docker tag ${app}:${version} ${image_server}/${namespace}/${app}:${version}
  echo "docker push ${image_server}/${namespace}/${app}:${version}"
  docker push ${image_server}/${namespace}/${app}:${version}
}

deploy( ) {
  kubectl delete -f ${app}-deploy.yaml
  docker images | grep ${app}:${version}
  kubectl create -f ${app}-deploy.yaml
  echo "."
  sleep 1
  kubectl -n $namespace get pod,svc -o wide -lapp=${app}
  echo "."
  sleep 1;
  kubectl -n $namespace logs $(kubectl -n $namespace get pod -lapp=${app} | grep -v 'NAME' | awk '{print $1 }') --tail=100
  # echo "."
  sleep 2;
  # curl --connect-timeout 2 --max-time 2 http://61.250.19.41:30001/
}

find( ) {
   ret=0
   pod=`kubectl -n $namespace get pod -lcomponent=$component | grep -v NAME | awk '{ print $1 }'`
   if [ "$pod" == "" ]
   then
     ret=1;
   fi
   return $ret;
}
exec_sh( ) {
  echo "kubectl -n $namespace exec $pod -it bash"
  kubectl -n $namespace exec $pod -it bash
  return 0
}
log( ) {
   echo "log"
   if [ $tail_rows -eq 0 ]
   then
     echo "kubectl -n $namespace logs $pod -c $component --tail=100"
     kubectl -n $namespace logs $pod -c $component --tail=100
   else
     echo "kubectl -n $namespace logs -f $pod -c $component --tail=$tail_rows"
     kubectl -n $namespace logs -f $pod -c $component --tail=$tail_rows
   fi
}
apply( ) {
   return 0;
   kubectl -n $namespace delete pod -lcomponent=$component
   return 0
}
restart( ) {
   kubectl -n $namespace delete pod -lcomponent=$component
   return 0
}
main $@
