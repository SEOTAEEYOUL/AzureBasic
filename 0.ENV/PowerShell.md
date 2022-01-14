# [PowerShell](https://docs.microsoft.com/ko-kr/powershell/scripting/overview?view=powershell-7.2) 

- ​PowerShell은 여러분이 여러분의 Microsoft 기반 장비와 애플리케이션들을 일관된 관리 프로세스로 관리하는데 사용될 수 있는 툴이다. 
- 이 툴은 관리자와 개발자 모두에게 매력적이어서 명령줄과 간단하지만 고급진 스크립트를 실제 프로그램으로 확장시킬 수 있다.

> [Back to Basics: The PowerShell Foreach Loop](https://adamtheautomator.com/powershell-foreach/)  
> [Managing CSV Files in PowerShell with Import-Csv](https://adamtheautomator.com/import-csv/)  
> [Understanding Import-Csv and the ForEach Loop](https://adamtheautomator.com/import-csv-foreach/)

## PowerShell 명령어 구조
- command -parameter1 -parameter2  argument1 argument2

  ![WindowsPowerShellInAction-1.3.jpg](./img/WindowsPowerShellInAction-1.3.jpg)  

## PowerShell 언어 구문분석
-
  ![WindowsPowerShellInAction-1.4.jpg](./img/WindowsPowerShellInAction-1.4.jpg)  


## 예약어
| 예약어 | 의미 |
|:---|:---|  
| $_ | 파이프라인으로 넘어온 배열 또는 컬렉션의 각각요소들을 의미 |  
| $$ | 실행 명령명 |
| $? | 이전 명령줄의 마지막 토큰 |  
| $^ | 마지막 명령의 부울 상태 | 

## 비교 연산자
| 연산자 | 의미 | 부등호 |
|:---:|:---|:---| 
| -eq | Equals(같다) | = |
| -ne | Does not equal(같지않다) | != |
| -gt | Greather than(크다) | > |  
| -lt | Less than(작다) | < |  
| -ge | Greater than or equal to(크거나 같다) | >= |
| -le | Less than or equal to (작거나 같다) | <= |  


## Sample
### 도움말
- update 하기
  ```
  Update-Help -UICulture ko-KR,en-US
  ```
- 저장하기
  ```
  Save-Help -DestinationPath "C:\PowerShell_Lab\SavePSHelp" -UICulture en-US,ko-KR
  Update-Help -Module Net* -UICulture en-US,ko-KR -SourcePath "C:\PowerShell_Lab\SavePSHelp"
  ```

- 도움말 예시
```pwershell
Get-Help

Get-Help Get-Service
Get-Help Get-Service -Online

Get-Help Get-Service -Examples
Get-Help Get-Service -Detailed

Get-Help Get-NetAdater -full
```

### Version 보기
```powershell
$PSVersionTable.PSVersion

Get-Host | Select-Object Version
 ```

### 파일 Path 및 내용 가져오기
```powershell
Get-ChildItem -Path ./somefile.txt
Get-Content -Path ./somefile.txt
```

### 재지정 연산자(>)
```powershell
(2+2)*3/7 > foo.txt
Get-Content foo.txt
```

### 변수
```powershell
$files = Get-ChildItem
$files
$files[1]
```

### 데이터 처리
- 객체 정렬하기
  ```powershell
  Get-ChildItem | sort -Descending
  ```

- 객체로부터 속성값을 선택하기
  ```powershell
  Get-Process | Select-Object -Property Name,ID,PM,VM -Last 7
  Get-Volume | Select-Object -Property DriveLetter,Size,SizeRemaining
  Get-Process | Sort-Object -Property workingset
  Get-Process | Measure-Object -Property PM -Sum -Average
  "Hello PowerShell" | Measure-Object -Character


  Get-ChildItem | Measure-Object -Property length -Minimum -Maximum -Sum -Average

  Test-Connection -Count 5 -Comp www.microsoft.com | Measure-Object -Property Address,Latency,BufferSize,Status
  Test-Connection -Count 5 -Comp www.microsoft.com | Measure-Object -Property Latency -Average -Minimum -Maximum

  $services = Get-Service
  $processes = Get-Process
  $services + $processes | Measure-Object
  $services + $processes | Measure-Object -Property DisplayName

  Get-Service | Where-Object -Property Status -eq Running
  Get-Service | Where-Object -Property Name.Length -gt 7

  Get-Service M* | Where-Object {$_.Status -eq "Running"}
  Get-Service M* | Where-Object {$_.Status -eq "Running" -or $_.Status -eq "Stopped"}
  Get-Service M* | Where-Object {$_.Status -eq "Running" -or $_.Status -eq "Stopped"} | Sort-Object -Property Status,Name -Descending

  $a = Get-ChildItem | sort -Property length -Descending | Select-Object -First 1 -Property Directory
  $a 
  ```

### 흐름 제어 문장
- if 문
- switch 문
- while 문
- foreatch 문
```powershell
$i=0
while($i++ -lt 10) { if ($i % 2) { "$i is odd" } else {"$i is even"}}

foreach ($i in 1..10) { if ($i % 2) {"$i is odd"}}

$Services=Get-Service
ForEach ($Service in $Services) {
  Write-Host "현재 서비스는 $($Service.name) 입니다."
}

# 컬렉션(배열) 만들기
$fruits = @("사과", "오렌지", "수박", "배", "포도", "딸기", "바나나")
# 컬렉션 처리
for ($i=0; $i -lt $fruits.Length; $i++) {
  $fruits[$i]
}

$i=0
while ($i -lt $fruits.Length) {
  $fruits[$i]
  $i++
}

$drive = Get-CimInstance -ClassName Win32_LogicalDisk `
  -Filter "DeviceID='C:'"

switch ($drive.DriveType) {
  3 { Write "로컬 고정 디스크" }
  5 { Write "광학 디스크 장치" } 
  Default { Write "기타 장치" }
}

switch (Get-Service) {
  {$_.status -eq "Running"}{"실행 중인 서비스 : "+$_.name}
  {$_.status -eq "Stopped"}{"중단된    서비스 : "+$_.name}
}
```
### 스크립트와 함수
- 명령들을 .ps1 확장자를 가지는 텍스트 파일로 넣어서 스크립트로 패키징할 수 있게 해줌
- 코드 안에 서브루틴을 가지기를 원할 수도 있으며, 이런 요구를 함수를 통해 해결
- 모듈 : psm1
```powershell
function hello {
  param($name = "bub")
  "Hello $name, how are you"
}
hello

hello Bruce
```
```powershell
Get-Content Env:PSMoudlePath

Get-Module -ListAvailable
```

### 원격 관리
- 클라우드 기반 IT 세계에서는 각 서버에 물리적으로 접근하지 않고 컴퓨터 그룹을 관리할 수 있는 능력은 매우 중요
- 이를 충족하기 위한 것이 PowerShell 의 원격 실행 능력
- Invoke-Command
```powershell
$computers = 'W16DSC01','W16DSC02'
Invoke-Command -ScriptBlock{Get-HotFix -Id KB3213986} `
  -ComputerName $computers | Format-Table HotFixId, InstalledOn, PSComputerName -AutoSize 
```

### 별칭(alias)
```powershell
Get-Alias
Get-Alias -Nmae ls
Get-Alias -definition Get-ChildItem

New-Alias -Name wo -Value Write-Output
wo "lllll"

Set-Alias -Name wop -Value Write-Output
wop "11111"

Export-Alias -Path "C:\PowerShell_Lab\MyAlias.csv"

Import-Alias -Path "C:\PowerShell_Lab\MyAlias.csv" -Force
```
#### 파워셸에 들어간 cmdlet과 잘 알려진 명령 줄 인터프리터의 비슷한 명령어 비교  
| 윈도우 파워셸(Cmdlet)	| 윈도우 파워셸(다른 이름) | cmd.exe / COMMAND.COM(MS-DOS, 윈도우, OS/2, 등)	| Bash(유닉스, BSD, 리눅스, 맥 오에스 텐 등) | 설명 |
|:---|:---|:---|:---|:---|
|Get-Location | gl, pwd	| cd | pwd	현재 디렉터리/작업 디렉터리를 보여 준다. |  
| Set-Location | sl, cd, chdir | cd, chdir | cd	| 현재 디렉터리를 바꾼다 |
| Clear-Host | cls, clear | cls | clear | 화면을 지운다 |
| Copy-Item | cpi, copy, cp | copy | cp | 하나 이상의 파일 / 완전한 디렉터리 트리를 복사한다 |
| Get-Help | help, man | help | man | 명령에 대한 도움말을 보여 준다 |  
| Remove-Item | ri, del, erase, rmdir, rd, rm | del, erase, rmdir, rd | rm, rmdir | 파일 / 디렉터리를 지운다 |
| Rename-Item | rni, ren | ren, rename | mv | 파일 / 디렉터리의 이름을 바꾼다 |  
| Move-Item | mi, move, mv | move | mv | 파일 / 디렉터리를 새로운 위치로 옮긴다 |  
| Get-ChildItem | gci, dir, ls | dir | ls | 현재 디렉터리의 모든 파일 / 디렉터리를 나열한다 |  
| Write-Output | echo, write | echo | echo | 문자열, 변수 등을 표준 출력(stdout)으로 출력한다 | 
| Pop-Location | popd | popd | popd | 현재 디렉터리를 맨 마지막에 스택으로 푸시(push)한 디렉터리로 바꾼다 |  
| Push-Location | pushd | pushd | pushd | 현재 디렉터리를 스택으로 푸시(push)한다 |  
| Set-Variable | sv, set | set | set | 변수 값을 설정하거나 새로 만든다 |  
| Get-Content | gc, type, cat | type | cat | 파일의 내용을 보여 준다 |  
| Select-String	| | find, findstr | grep | 패턴에 맞추어 줄들을 출력한다 |  
| Get-Process | gps, ps | tlist, tasklist | ps | 현재 실행 중인 모든 프로세스를 나열한다 | 
| Stop-Process | spps, kill | kill, taskkill | kill | 실행 중인 프로세스를 끝낸다 |  
| Tee-Object | tee | 없음 | tee | 입력을 파일이나 변수로 파이프(pipe) 처리한 뒤 파이프라인에 따라 입력을 넘긴다 |  


#### Windows 사용자용
- dir
- type
- copy
- del
- echo
- ren
- rmdir
- set
- sort
- start

#### Unix 사용자용
- ls
- cat
- cp
- md
- move
- rm



## Resource Group 만들기

## VNet 만들기

## NSG 만들기

## subnet 만들기



## disk 만들기

## nic 만들기

## public-ip 만들기

## VM 만들기

| 명령어(cmdlet) | 설명 | 예시 | 
|:---|:---|:---|
| Import-CSV | CSV 파일 읽기 | Import-CSV -Path ./vm_parameter_template.csv |
| Set-AzVMOperatingSystem | VM OS 지정 | -Windows, -Linux |  
| Set-AzVMSourceImage | VM 이미지 지정 | Standard_D1_v2 |
| ForEach-Object | 파이프라인에서 항목을 반복 | | 
| Select-AzSubscription | 구독 선택 | | 
| ConvertTo-SecureString | | | 
| New-Object | 새 사용자 지정 PowerShell 개체를 만듬 | |  
| Get-AzVirtualNetwork | | |  
| Get-AzVirtualNetworkSubnetConfig | | |  
| Get-AzNetworkSecurityGroup | | |  
| Get-AzNetworkInterface | | |  
| New-AzNetworkInterface | | |  
| Get-AzNetwrokInterface | | | 
| New-AzVMConfig | | |  
| Set-AzVMOperatingSystem | | |  
| Set-AzVMSourceImage | | |  
| New-AzVMConfig | | |  
| Set-AzVMOperatingSystem | | |  
| Set-AzVMSourceImage | | |  
| Set-AzVMNetworkInterface | | |  
| Add-AzVMNetworkInterface | | |  
| Set-AzVMOSDisk | | |  
| Add-AzVMDataDisk | | |  
| Add-AzVMBootDiagnostic | | |  
| New-AzVM | | |  
| Get-AzRecoveryServiceVault | | |  
| Set-AzRecoveryServicesVaultContext | | | 
| Get-AzRecoveryServiceBackupProtetionPolicy | | |  
| Enable-AzRecoveryServiceBackupProtection | | | 



## 