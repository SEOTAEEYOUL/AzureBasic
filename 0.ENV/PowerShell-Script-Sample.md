# PowerShell Script 실행 예제

## Import-CSV
- CSV 가져오기
```powershell
$products = Import-Csv .\test.csv -Encoding UTF8
$products | Format-Table
```

## ForEach-Object
- 
```powershell
```

## Select-AzSubscription
- 구독 선택/변경
```powershell
Select-AzSubscription "Azure subscription 1"


Name                                     Account                           SubscriptionName                 Environment                      TenantId
----                                     -------                           ----------------                 -----------                      --------
Azure subscription 1 (9ebb0d63-8327-402… ca07456@sktda.onmicrosoft.com     Azure subscription 1             AzureCloud                       160bacea-7761-4c83-bfa0-354f9b0… 
```

## ConvertTo-SecureString
- 암호화된 문자열로 변경
```powershell
$secure = read-host -assecurestring
$secure
$encrypted = convertfrom-securestring -securestring $secure
$encrypted
$secure2 = convertto-securestring -string $encrypted
$secure2
```

## New-Object
- .NET 및 COM 개체 만들기
```powershell
$SecurePassword = ConvertTo-SecureString "dlatl!00" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential("sysadmin",$SecurePassword);
```