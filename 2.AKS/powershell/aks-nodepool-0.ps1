. ./aks-env.ps1

az aks nodepool scale `
  --resource-group $groupName `
  --cluster-name $clusterName `
  --name $nodepoolName `
  --node-count 0