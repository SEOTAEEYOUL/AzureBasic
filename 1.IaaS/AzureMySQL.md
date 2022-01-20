# [Azure MySQL](https://docs.microsoft.com/ko-kr/azure/mysql/overview)

- [Azure Database for MySQL에 대한 Private Link](https://docs.microsoft.com/ko-kr/azure/mysql/concepts-data-access-security-private-link)


## PowerShell
* [New-AzMySqlServer](https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlserver?view=azps-7.1.0#examples)  
* [Get-AzMySqlServer](https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqlserver?view=azps-7.1.0)
* [Update-AzMySqlServer](https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlserver?view=azps-7.1.0)
* [Remove-AzMySqlServer](https://docs.microsoft.com/en-us/powershell/module/az.mysql/remove-azmysqlserver?view=azps-7.1.0)

## 모듈
```powershell
Install-Module -Name Az.MySql -AllowClobber
```

### 공급자 등록
- Azure Database for MySQL 서비스를 처음 사용하는 경우 Microsoft.DBforMySQL 리소스 공급자를 등록해야 함
```
Register-AzResourceProvider -ProviderNamespace Microsoft.DBforMySQL
```

## SKU
| SKU | 분류 | 스펙 | 가격/월 | 비고 |  
|:---|:---|:---|:---|:---|
| B_Gen5_1 | 기본 | 5세대, 1 vCore | US$37.96 |사용 가능한 가장 작은 SKU, 단일 서버, Private Endpoint 생성 불가 | 
| GP_Gen5_2 | 범용 | 5세대, 2 vCore | US$176.37 | |
| GP_Gen5_32 | 범용 | 5세대, 32 vCore | US$2,821.89 | |
| MO_Gen5_2 | 메모리 최적화 | 5세대, 2 vCore | US$207.03 | |
| MO_Gen5_4 | 메모리 최적화 | 5세대, 4 vCore | US$414.06 | |


## PowerShell Sample
```powershell
Write-Host "구독 선택"
Set-AzContext -SubscriptionId '9ebb0d63-8327-402a-bdd4-e222b01329a1'

Write-Host "구독 확인"
Get-AzContext

Write-Host "MySQL 서버 생성 - 수분소요"
# $Password = Read-Host `
#   -Prompt 'Please enter your password' `
#   -AsSecureString
Write-Host "Convert password to secure string"
$Password = ConvertTo-SecureString 'dlalt!00' -AsPlainText -Force
$tags = @{
  owner='SeoTaeYeol'
  environment='dev'
  serviceTitle='homepage'
  personalInformation='no'
}

Write-Host "- 최소 스토리지 : 5120"
Write-Host "- 서버백업 지역 중복 사용 여부 : Disabled"
New-AzMySqlServer `
  -Name mysql-homepage `
  -ResourceGroupName rg-skcc-homepage-dev `
  -Sku GP_Gen5_2 `
  -BackupRetentionDay 14 `
  -GeoRedundantBackup Disabled `
  -Location koreacentral `
  -AdministratorUsername mysqladmin `
  -AdministratorLoginPassword $Password `
  -StorageAutogrow Enabled `
  -StorageInMb 5120 `
  -Tag $tags `
  -Version 5.7

# Write-Host "백업 설정"
# Update-AzMySqlServer `
#   -Name mysql-homepage-dev `
#   -ResourceGroupName rg-skcc-homepage-dev `
#   -BackupRetentionDay 14

Write-Host "방화벽 규칙 적용"
New-AzMySqlFirewallRule `
  -Name AllowMyIP `
  -ResourceGroupName rg-skcc-homepage-dev `
  -ServerName mysql-homepage-dev `
  -StartIPAddress 192.168.0.1 `
  -EndIPAddress 192.168.0.1

Write-Host "Azure Database for MySQL 서버에서 SSL을 사용하지 않도록 설정"
Update-AzMySqlServer `
  -Name mysql-homepage `
  -ResourceGroupName rg-skcc-homepage-dev `
  -SslEnforcement Disabled

Write-Host "연결정보 가져오기"
# mysql-homepage.mysql.database.azure.com
Get-AzMySqlServer `
  -Name mysql-homepage `
  -ResourceGroupName rg-skcc-homepage-dev |
  Select-Object `
    -Property FullyQualifiedDomainName, AdministratorLogin
$mysql = Get-AzMySqlServer `
  -Name mysql-homepage `
  -ResourceGroupName rg-skcc-homepage-dev
$mysql.id

Write-Host ""
Get-AzMySqlServer `
  -ResourceGroupName PowershellMySqlTest `
  -ServerName mysql-homepage | `
    Update-AzMySqlServer `
      -BackupRetentionDay 23 `
      -StorageMb 10240
```
```
Remove-AzMySqlServer `
  -ResourceGroupName rg-skcc-homepage-dev `
  -Name mysql-homepage
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
### private endpoint 만들기
```
az network private-endpoint create \  
    --name pe-mysql-homepage \  
    --resource-group rg-skcc-homepage-dev \  
    --vnet-name vnet-skcc-dev  \  
    --subnet snet-skcc-dev-frontend \  
    --private-connection-resource-id $(az resource show -g rg-skcc-homepage-dev -n mysql --resource-type "Microsoft.DBforMySQL/servers" --query "id" -o tsv) \    
    --group-id mysqlServer \  
    --connection-name myConnection  
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

## 생성로그
```powershell
PS D:\workspace\AzureBasic> $Password = ConvertTo-SecureString 'dlalt!00' -AsPlainText -Force

PS D:\workspace\AzureBasic> $tags = @{
>>   owner='SeoTaeYeol'
>>   environment='dev'
>>   serviceTitle='homepage'
>>   personalInformation='no'
>> }

PS D:\workspace\AzureBasic> New-AzMySqlServer `
>>   -Name mysql-homepage `
>>   -ResourceGroupName rg-skcc-homepage-dev `
>>   -Sku GP_Gen5_2 `
>>   -BackupRetentionDay 14 `
>>   -GeoRedundantBackup Disabled `
>>   -Location koreacentral `
>>   -AdministratorUsername mysqladmin `
>>   -AdministratorLoginPassword $Password `
>>   -StorageAutogrow Enabled `
>>   -StorageInMb 5120 `
>>   -Tag $tags `
>>   -Version 5.7


Name           Location     AdministratorLogin Version SkuName   SkuTier        SslEnforcement
----           --------     ------------------ ------- -------   -------        --------------
mysql-homepage koreacentral mysqladmin         5.7     GP_Gen5_2 GeneralPurpose Enabled

PS D:\workspace\AzureBasic>
```

![AzureMySql.png](./img/AzureMySql.png)