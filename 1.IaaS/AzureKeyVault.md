# Azure Key Valut

* [New-AzKeyVault](https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-7.1.0)
* [Remove-AzKeyVault](https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-7.1.0)

> [빠른 시작: PowerShell을 사용하여 키 자격 증명 모음 만들기](https://docs.microsoft.com/ko-kr/azure/key-vault/general/quick-create-powershell)  
> [자습서: Key Vault에 저장된 TLS/SSL 인증서로 Azure에서 Windows 가상 머신의 웹 서버 보호](https://docs.microsoft.com/ko-kr/azure/virtual-machines/windows/tutorial-secure-web-server)  


## [PowerShell](https://shell.azure.com)
<a href="https://shell.azure.com">
  <img class="cloudshell" src=./img/hdi-launch-cloud-shell.png>
</a>

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

### 인증서 생성 및 Key Value 에 저장  
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

## Azure CLI

### Azure Key Vault 만들기
```bash
locationName="koreacentral"
groupName="rg-skcc-homepage-dev"
keyvaultName="skcc-kv-sslcert-homepage" 
keyvaultSku="Standard"
domainName="www.springnode.net"

$certName="sslcert-springnode-net"

az keyvault create \
  --resource-group $groupName \
  --name $keyvaultName \
  --enabled-for-deployment
```

### 인증성 생성 및 Key Vault 에 저장
```bash
az keyvault certificate create \
    --vault-name $keyvaultName \
    --name $certName \
    --policy "$(az keyvault certificate get-default-policy --output json)"
```

### VM에 사용할 인증서 준비
```bash
secret=$(az keyvault secret list-versions \
          --vault-name $keyvaultName \
          --name $certName \
          --query "[?attributes.enabled].id" --output tsv)
vm_secret=$(az vm secret format --secret "$secret" --output json)
```

### 보안 VM 만들기
#### nginx cloud-init 구성 만들기
- cloud-init-secured.txt
```yaml
#cloud-config
package_upgrade: true
packages:
  - nginx
  - nodejs
  - npm
write_files:
  - owner: www-data:www-data
    path: /etc/nginx/sites-available/default
    content: |
      server {
        listen 80;
        listen 443 ssl;
        ssl_certificate /etc/nginx/ssl/mycert.cert;
        ssl_certificate_key /etc/nginx/ssl/mycert.prv;
        location / {
          proxy_pass http://localhost:3000;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection keep-alive;
          proxy_set_header Host $host;
          proxy_cache_bypass $http_upgrade;
        }
      }
  - owner: azureuser:azureuser
    path: /home/azureuser/myapp/index.js
    content: |
      var express = require('express')
      var app = express()
      var os = require('os');
      app.get('/', function (req, res) {
        res.send('Hello World from host ' + os.hostname() + '!')
      })
      app.listen(3000, function () {
        console.log('Hello world app listening on port 3000!')
      })
runcmd:
  - secretsname=$(find /var/lib/waagent/ -name "*.prv" | cut -c -57)
  - mkdir /etc/nginx/ssl
  - cp $secretsname.crt /etc/nginx/ssl/mycert.cert
  - cp $secretsname.prv /etc/nginx/ssl/mycert.prv
  - service nginx restart
  - cd "/home/azureuser/myapp"
  - npm init
  - npm install express -y
  - nodejs index.js
```
```bash
az vm create \
  --resource-group $groupName \
  --name $vmName \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --custom-data cloud-init-secured.txt \
  --secrets "$vm_secret"
```

### 포트 열기
```bash
az vm open-port \
  --resource-group $groupName \
  --name $vmName \
  --port 443
```