. ./aks-env.ps1

az aks list -o table
az aks stop -g $groupName -n $clusterName # node group의 크기를 0으로 줄임
az aks list -o table