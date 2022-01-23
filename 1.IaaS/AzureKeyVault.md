# Azure Key Valut

* [New-AzKeyVault](https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-7.1.0)
* [Remove-AzKeyVault](https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-7.1.0)

> [빠른 시작: PowerShell을 사용하여 키 자격 증명 모음 만들기](https://docs.microsoft.com/ko-kr/azure/key-vault/general/quick-create-powershell)  
> [자습서: Key Vault에 저장된 TLS/SSL 인증서로 Azure에서 Windows 가상 머신의 웹 서버 보호](https://docs.microsoft.com/ko-kr/azure/virtual-machines/windows/tutorial-secure-web-server)  

## Key Valut 생성

### 구성
- 사용자 지정 도메인 HTTPS : 설정
- 인증성 관리 유형 : "나만의 인증서 사용"
- 최소 TLS 버전 : TLS 1.2
- 키 자격 증명 모음 : skcc-kv-sslcert-homepage

### 환경설정
```powershell
$locationName="koreacentral"
$resoruceGroupName="rg-skcc-homepage-dev"
$keyvaultName="skcc-kv-sslcert-homepage" 
$keyvaultSku="Standard"
$domainName="www.springnode.net"

$certName="sslcert-springnode-net"
```

### 생성
```powershell
New-AzKeyVault `
  -Name $keyvaultName `
  -ResourceGroupName $resoruceGroupName `
  -Location $locationName
```

### 확인
```powershell
Get-AzKeyVault `
  -Name $keyvaultName `
  -ResourceGroupName $resoruceGroupName
```

### 이증서 생성 및 Key Value 에 저장  
```powershell
$policy = New-AzKeyVaultCertificatePolicy `
    -SubjectName "CN=$domainName" `
    -SecretContentType "application/x-pkcs12" `
    -IssuerName Self `
    -ValidityInMonths 12

Add-AzKeyVaultCertificate `
    -VaultName $keyvaultName `
    -Name "$certName" `
    -CertificatePolicy $policy
```

### 제거
```powershell
Remove-AzKeyVault `
  -Name $keyvaultName `
  -ResourceGroupName $resoruceGroupName
```