. ./aks-env.ps1

az aks list -o table
az aks start -g $groupName -n $clusterName
az aks list -o table