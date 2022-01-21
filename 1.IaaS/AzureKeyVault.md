# Azure Key Valut

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