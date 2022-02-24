$groupName='rg-skcc2-aks'
$locationName='koreacentral'
$serviceName='Homeeee'
$acrName="acr$serviceName"

$repositoryName="springmysql"
$tag='0.2.1'
$clusterName='aks-cluster-Homeeee'

# export loginServer="acrhomepage.azurecr.io"
$loginServer="${acrName}.azurecr.io"

# az aks get-credentials --resource-group $groupName --name $clusterName --overwrite-existing

if ($accessToken -eq $null) {
  $accessToken=az acr login --name $acrName --expose-token | jq .accessToken | %{$_ -replace('"', '')}
}