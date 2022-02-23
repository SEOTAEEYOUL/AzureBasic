. ./aks-env.ps1

az aks get-credentials --resource-group $groupName --name $clusterName
kubectl get nodes
