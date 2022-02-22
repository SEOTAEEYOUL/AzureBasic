. ./aks-env.ps1


Write-Host "준비 작업"
az feature register --namespace "Microsoft.ContainerService" --name "EnableAzureRBACPreview"
az provider register --namespace Microsoft.OperationsManagement
az provider register --namespace Microsoft.OperationalInsights
az provider show -n Microsoft.OperationsManagement -o table
az provider show -n Microsoft.OperationalInsights -o table

Write-Host "aks-preview CLI 확장 설치"
az extension add --name aks-preview
az extension update --name aks-preview

Write-Host "CustomNodeConfigPreview 미리 보기 기능 등록"
az feature register --namespace "Microsoft.ContainerService" --name "CustomNodeConfigPreview"
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/CustomNodeConfigPreview')].{Name:name,State:properties.state}"
az provider register --namespace Microsoft.ContainerService

Write-Host "AKS CLI 설치"
az aks install-cli