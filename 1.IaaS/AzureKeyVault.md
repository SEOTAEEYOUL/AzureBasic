# Azure Key Valut

* [New-AzKeyVault](https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-7.1.0)
* [Remove-AzKeyVault](https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-7.1.0)

> [빠른 시작: PowerShell을 사용하여 키 자격 증명 모음 만들기](https://docs.microsoft.com/ko-kr/azure/key-vault/general/quick-create-powershell)  

```powershell
$locationName="koreacentral"
$resoruceGroupName="rg-skcc-homepage-dev"
$keyvaultName="kv-skcc-sslcert-homepage"
New-AzKeyVault `
  -Name $keyvaultName `
  -ResourceGroupName $resoruceGroupName `
  -Location $locationName
```

```powershell
Remove-AzKeyVault `
  -Name $keyvaultName `
  -ResourceGroupName $resoruceGroupName
```