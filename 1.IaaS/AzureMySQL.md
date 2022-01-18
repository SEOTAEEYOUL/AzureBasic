# [Azure MySQL](https://docs.microsoft.com/ko-kr/azure/mysql/overview)


## PowerShell
* [New-AzMySqlServer](https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlserver?view=azps-7.1.0#examples)  
* [Get-AzMySqlServer](https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqlserver?view=azps-7.1.0)
* [Update-AzMySqlServer](https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlserver?view=azps-7.1.0)

## 모듈
```powershell
Install-Module -Name Az.MySql -AllowPrerelease
```

## SKU
| SKU | 분류 | 스펙 | 가격/월 | 비고 |  
|:---|:---|:---|:---|:---|
| B_Gen5_1 | 기본 | 5세대, 1 vCore | US$37.96 |사용 가능한 가장 작은 SKU, 단일 서버 | 
| GP_Gen5_2 | 범용 | 5세대, 2 vCore | US$176.37 | |
| GP_Gen5_32 | 범용 | 5세대, 32 vCore | US$2,821.89 | |
| MO_Gen5_2 | 메모리 최적화 | 5세대, 2 vCore | US$207.03 | |
| MO_Gen5_4 | 메모리 최적화 | 5세대, 4 vCore | US$414.06 | |


## PowerShell Sample
```powershell
Write-Host "구독 선택"
Set-AzContext -SubscriptionId '9ebb0d63-8327-402a-bdd4-e222b01329a1'

Write-Host "MySQL 서버 생성"
$Password = Read-Host `
  -Prompt 'Please enter your password' `
  -AsSecureString
$tags = @{
  owner='SeoTaeYeol'
  environment='dev'
  serviceTitle='homepage'
  personalInformation='no'
}
New-AzMySqlServer `
  -Name db-mysql-homepage `
  -ResourceGroupName rg-skcc-homepage `
  -Sku B_Gen5_1 `
  -GeoRedundantBackup Enabled `
  -Location koreacentral `
  -AdministratorUsername myadmin `
  -Tag owner=$tags `
  -AdministratorLoginPassword $Password

Write-Host "방화벽 규칙 적용"
New-AzMySqlFirewallRule `
  -Name AllowMyIP `
  -ResourceGroupName myresourcegroup `
  -ServerName mydemoserver `
  -StartIPAddress 192.168.0.1 `
  -EndIPAddress 192.168.0.1

Write-Host "Azure Database for MySQL 서버에서 SSL을 사용하지 않도록 설정"
Update-AzMySqlServer `
  -Name mydemoserver `
  -ResourceGroupName myresourcegroup `
  -SslEnforcement Disabled

Write-Host "연결정보 가져오기"
Get-AzMySqlServer `
  -Name mydemoserver `
  -ResourceGroupName myresourcegroup |
  Select-Object `
    -Property FullyQualifiedDomainName, AdministratorLogin

Write-Host ""
Get-AzMySqlServer `
  -ResourceGroupName PowershellMySqlTest `
  -ServerName mysql-test | Update-AzMySqlServer `
    -BackupRetentionDay 23 `
    -StorageMb 10240
```

## CLI
### 확장 설치
```
az extension add --name db-up
```

### 생성
```powershell
az account set --subscription <subscription id>
az group create `
  --name myresourcegroup `
  --location westus
az mysql server create `
  --resource-group myresourcegroup `
  --name mydemoserver `
  --location westus `
  --admin-user myadmin `
  --admin-password <server_admin_password> `
  --sku-name GP_Gen5_2

## 방화벽
az mysql server firewall-rule create `
  --resource-group myresourcegroup `
  --server mydemoserver `
  --name AllowMyIP `
  --start-ip-address 192.168.0.1 `
  --end-ip-address 192.168.0.1

## 연결정보 가져오기
az mysql server show `
  --resource-group myresourcegroup `
  --name mydemoserver
```

## 운영 명령
### 리소스 정리
```
az mysql down --delete-group
```
```
az mysql down
```

### MySQL 접속
```
 mysql -h mydemoserver.mysql.database.azure.com -u myadmin@mydemoserver -p
```