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
- ![WindowsPowerShellInAction-1.4.jpg](./img/WindowsPowerShellInAction-1.4.jpg)  


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

| 명령어 | 설명 | 예시 | 
|:---|:---|:---|
| Import-CSV | CSV 파일 읽기 | Import-CSV -Path ./vm_parameter_template.csv |
| Set-AzVMOperatingSystem | VM OS 지정 | -Windows, -Linux |  
| Set-AzVMSourceImage | VM 이미지 지정 | Standard_D1_v2 |

## 