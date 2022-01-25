# Tag
Azure 리소스, 리소스 그룹 및 구독에 태그를 적용하여 논리적으로 분류에 활용 할 수 있음
* [Azure에서 PowerShell을 사용하여 가상 머신에 태그를 지정하는 방법](https://docs.microsoft.com/ko-kr/azure/virtual-machines/tag-powershell)
* [Azure CLI를 사용하여 VM에 태그를 지정하는 방법](https://docs.microsoft.com/ko-kr/azure/virtual-machines/tag-cli)

## Tag 의 가이드라인
1. 태크 이름(키)의 최대 길이 : 512 자, 태그 값의 최대 길이 : 256자
2. 태그 이름에 포함할 수 없는 문자 : <, >, %, &, \, ?, /
3. 태그능 해당 리소스 그룹의 리소스에 상속되지 않은 리소스 그룹에 적용 가능
4. 태그 이름은 대소문자 구분이 없으며 태그값은 대소문자를 구분해야 함
5. 태깅은 반듯이 필요한 것만 사용하여 최소화 할 것
6. "필수" 항목 태그는 미 입력 시 리소스 생성 불가하도록 정책적용

## 필수 Tag
| 대상 | 태그 이름 | 태그 값 | 내용|
|:---|:---|:---|:---|
|Resource Group | servicetitle | 서비스 별 고유명사 | 서비스 명 |
|Resource Group | environment | 'prd', 'stg', 'dev', 'poc' | 운영 구분 |
|Resource Group | personalinformation | 'yes', 'no' | 개인정보 포함 여부 |

## 권장 태그
### Business
| 태그 이름 | Key | 설명 | 예제 값 |  
|:---|:---|:---|:---|  
| 비즈니스 단위 | BusinessUnit | 워크로드 또는 서비스의 Owner 가 속한 최상위 사업부 | |
| 부서 | Department | 워크로드 또는 서비스의 Owner 가 속한 하위팀 | |
| 생성자 | Creator | 애플리케이션, 워크로드 또는 서비스의 생성자 | 사번 |
| 소유자 | Owner | 애플리케이션, 워크로드 또는 서비스의 소유자 | Kim, MinJun |
| 운영자 | Operator | 애플리케이션, 워크로드 또는 서비스의 운영자 | Kim, MinJun |
| 설명 | Description | 리소스에 대한 설명 | |  

### Technical
| 태그 이름 | Key | 설명 | 예제 값 |  
|:---|:---|:---|:---|  
| 역활 | ApplicationRole | 리소스의 역활 | web, was, db, app, if, batch |
| 모니터링 | Datadog | Datadog 사용 여부 | monitored |
| 지역 | Region | 배포되는 지역 | koce, koso |
| 버전 | ApplicationVersion | 배포된 애플리케이션 및 리소스의 버전을 식별 | v1.0 |

### Security  
| 태그 이름 | Key | 설명 | 예제 값 |  
|:---|:---|:---|:---|  
| 기밀성 | Confidentiality | 취급 데이터의 기밀성 | Internal Use Only |

## PowerShell Sample
```powershell
#  기조 태그 조회
$tags = `
  (Get-AzResource `
    -ResourceGroupName myResourceGroup `
    -Name myVM).Tags
# 태그 보기
$tags

# +=를 사용하여 $tags 목록에 새 키/값 쌍을 추가
$tags += @{
  environment='dev'
  serviceTitle='homepage'
  personalInformation='no'
}

# 변수에 정의 된 모든 태그를 설정
Set-AzResource `
  -ResourceGroupName myResourceGroup `
  -Name myVM `
  -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags

# 리소스의 태그 표시
(Get-AzResource `
  -ResourceGroupName myResourceGroup `
  -Name myVM).Tags
```

## ResourceType 보기
### 모든 리소스 공급자와 구독에 대한 등록 상태
```powershell
Get-AzResourceProvider `
  -ListAvailable | `
    Select-Object `
      ProviderNamespace, RegistrationState
```

### 등록된 모든 리소스 공급자
```powershell
Get-AzResourceProvider `
  -ListAvailable | `
    Where-Object `
      RegistrationState -eq "Registered" | `
        Select-Object ProviderNamespace, RegistrationState | `
          Sort-Object ProviderNamespace
```
```powershell
PS D:\workspace\AzureBasic> Get-AzResourceProvider `
>>   -ListAvailable | `
>>     Where-Object `
>>       RegistrationState -eq "Registered" | `
>>         Select-Object ProviderNamespace, RegistrationState | `
>>           Sort-Object ProviderNamespace


ProviderNamespace                  RegistrationState
-----------------                  -----------------
Microsoft.ADHybridHealthService    Registered
Microsoft.Advisor                  Registered
Microsoft.AlertsManagement         Registered
Microsoft.Authorization            Registered
Microsoft.Cdn                      Registered
Microsoft.ChangeAnalysis           Registered
Microsoft.Compute                  Registered
Microsoft.ContainerInstance        Registered
Microsoft.ContainerRegistry        Registered
Microsoft.ContainerService         Registered
Microsoft.DBforMySQL               Registered
Microsoft.DBforPostgreSQL          Registered
Microsoft.DevTestLab               Registered
Microsoft.Diagnostics              Registered
Microsoft.DocumentDB               Registered
Microsoft.DomainRegistration       Registered
Microsoft.GuestConfiguration       Registered
microsoft.insights                 Registered
Microsoft.KeyVault                 Registered
Microsoft.Maintenance              Registered
Microsoft.ManagedIdentity          Registered
Microsoft.Management               Registered
Microsoft.MarketplaceNotifications Registered
Microsoft.MarketplaceOrdering      Registered
Microsoft.Network                  Registered
Microsoft.OperationalInsights      Registered
Microsoft.OperationsManagement     Registered
Microsoft.PolicyInsights           Registered
Microsoft.RecoveryServices         Registered
Microsoft.ResourceGraph            Registered
Microsoft.ResourceHealth           Registered
Microsoft.Resources                Registered
Microsoft.SaaS                     Registered
Microsoft.Security                 Registered
Microsoft.SerialConsole            Registered
Microsoft.Sql                      Registered
Microsoft.Storage                  Registered
Microsoft.Web                      Registered

PS D:\workspace\AzureBasic> 
```

#### grep 사용한 경우
```powershell
PS D:\workspace\AzureBasic> Get-AzResourceProvider -ListAvailable | Select-Object ProviderNamespace, RegistrationState | grep -v NotReg


ProviderNamespace                       RegistrationState
-----------------                       -----------------
Microsoft.ContainerInstance             Registered
Microsoft.DocumentDB                    Registered
Microsoft.AlertsManagement              Registered
Microsoft.Network                       Registered
Microsoft.Compute                       Registered
Microsoft.Storage                       Registered
Microsoft.ResourceHealth                Registered
Microsoft.Advisor                       Registered
Microsoft.Security                      Registered
Microsoft.SaaS                          Registered
Microsoft.ContainerRegistry             Registered
Microsoft.OperationalInsights           Registered
Microsoft.ContainerService              Registered
Microsoft.OperationsManagement          Registered
Microsoft.ManagedIdentity               Registered
Microsoft.Management                    Registered
Microsoft.ChangeAnalysis                Registered
Microsoft.DevTestLab                    Registered
Microsoft.KeyVault                      Registered
Microsoft.Web                           Registered
microsoft.insights                      Registered
Microsoft.Sql                           Registered
Microsoft.Maintenance                   Registered
Microsoft.DBforPostgreSQL               Registered
Microsoft.Diagnostics                   Registered
Microsoft.MarketplaceNotifications      Registered
Microsoft.DBforMySQL                    Registered
Microsoft.Cdn                           Registered
Microsoft.RecoveryServices              Registered
Microsoft.DomainRegistration            Registered
Microsoft.PolicyInsights                Registered
Microsoft.GuestConfiguration            Registered
Microsoft.ADHy"2020bridHealthService         Registered
Microsoft.Authorization                 Registered
Microsoft.MarketplaceOrdering           Registered
Microsoft.ResourceGraph                 Registered
Microsoft.Resources                     Registered
Microsoft.SerialConsole                 Registered

PS D:\workspace\AzureBasic> 
```