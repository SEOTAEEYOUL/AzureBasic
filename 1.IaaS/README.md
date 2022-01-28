# Azure Cloud 3 Tier (VM 기반)

> [Azure에서 가상 머신에 대한 크기](https://docs.microsoft.com/ko-kr/azure/virtual-machines/sizes)
> [스토리지 계정 만들기](https://docs.microsoft.com/ko-kr/azure/storage/common/storage-account-create?tabs=azure-powershell)  
> [빠른 시작: Azure CDN 프로필 및 엔드포인트 만들기](https://docs.microsoft.com/ko-kr/azure/cdn/cdn-create-new-endpoint)  
> [자습서: Azure App Service 웹앱에 Azure CDN 추가](https://docs.microsoft.com/ko-kr/azure/cdn/cdn-add-to-web-app)  
> (코드 샘플 찾아보기)[https://docs.microsoft.com/ko-kr/samples/browse/?products=azure]

## 기본 원칙
- 구독 당 하나의 VNet 생성

## 리소스 생성 절차
1. Resource Group 생성 
2. Vnet 생성 
3. Subnet 생성 
4. Storage Account 생성(부트진단용) 
5. recovery vault 생성, 규칙 생성

## VM 생성 절차
1. NIC 생성 
2. VM 생성 관련 정보들 
3. VM 배포
   > [관리 디스크의 스토리지 형식 업데이트](https://docs.microsoft.com/ko-kr/azure/virtual-machines/windows/convert-disk-storage) 

## Apache, Tomcat 설치 및 구성
### [Apache 서버 설치 및 구성](./Apache.md)

### [Tomcat 서버 설치 및 구성](./Tomcat.md)

## Application Gateway
- NET (가상 네트워크) 내에서 트래픽 부하를 분산

## Azure CDN
- 글로벌 수준 에서만 경로 기반 부하 분산을 수행
- VM, Container 수준에서 작동하지 않음으로 Application Gateway 를 사용 연결  
> [Azure 전면 도어 표준/프리미엄 (미리 보기)에 대 한 질문과 대답](https://github.com/MicrosoftDocs/azure-docs.ko-kr/blob/master/articles/frontdoor/standard-premium/faq.md)

### 프로젝트 때 사용된 VM 생성 스크립트  
| 파일명 | 설명 | 
|:---|:---|  
| vm_deployscript_template.ps1 | VM 생성 파워셀 스크립트 |  
| vm_parameter_template.csv | VM 생성 파워셀 스크립트 인자 파일 |   

### 자원 목록    
| 항목 | 자원명 | 설명 | 사이징 | end point | Resource Group | Location |  
|:---|:---|:---|:---|:---|:---|:---| 
| Resource Group | rg-skcc-network-dev | Network 자원 그룹 | | | | koreacentral | 
| Resource Group | rg-skcc-homepage-dev | Home Page 자원 그룹 | | | | koreacentral | 
| Vnet | vnet-skcc-dev | 홈페이지 VNet | 10.0.0.0/16 | | rg-skcc-network-dev | koreacentral |  
| Vnet | vnet-skcc-dev | 공통영역 VNet | 10.21.0.0/16 | | rg-skcc-network-dev | koreacentral |  
| subnet | snet-skcc-network-frontend | 외부에서 접근 시 사용되는 자원 배포 영역| 10.21.0.0/24 | | rg-skcc-network-dev | koreacentral |  
| subnet | snet-skcc-network-backend  | 내부에서 API 형태로 접근시 사용되는 자원 배포 영역 | 10.21.1.0/28 | |  
| subnet | snet-skcc-dev-frontend | 외부에서 접근 시 사용되는 자원 배포 영역| 10.0.0.0/24 | | rg-skcc-network-dev | koreacentral |  
| subnet | snet-skcc-dev-backend  | 내부에서 API 형태로 접근시 사용되는 자원 배포 영역 | 10.0.1.0/28 | | rg-skcc-homepage-dev | koreacentral |  
| Storage Account | skccprdhomepagefiles1 | | | PE-skccprdhompagefiles1 | rg-skcc-homepage-dev | koreacentral |
| VM | SKCC-COMDPT1 | Web 서버 | Standard D8s v3 | pip-skcc-comdpt1 | rg-skcc-homepage-dev | koreacentral |  
| VM | SKCC-COMDAP1 | WAS 서버 | Standard D8s v3 |  | rg-skcc-homepage-dev | koreacentral |  
| DB | mysql-homepage-dev | MySQL 5.7 | GP_Gen5_8(범용, vCore 8개, 5GB) | PE-skcchomepageprdmysql | rg-skcc-homepage-dev | koreacentral |


## MariaDB
### 생성 절차
1. 자원 결정 (sku, data disk 크기)
2. 생성 지역 결정(koreacentral)

## Application Gateway
- SSL오프로딩 기능을 통한 VM부하 감소역할
- L7역할 제공
- WAF(Web Application Firewall) 기능 제공

### 생성절차
1. Application 생성
2. Rule 생성

## Application Gateway


## CDN 
### 생성 절차
1. CDN 생성
   - Profile 생성 : skcc-homepae-dev-cdn
   - endpoint 생성 : skcc-homepae-dev-cdn.azureedge.net
   - HomePage : https://skcc-homepage-dev-cdn.azureedge.net/
2. Rule 생성

## App Service 도메인
- Domain : nodespringboot.org

### DNS 등록
1. CNAME : nodespringboot.org
.azureedge.net
   - www.nodespringboot.org 의 서비스 주소
2. A Record : 20.196.232.11
   - applicaion gateway 의 ip 로 CDN 장애시 tomcat 서버로 직접 붙기 위함
3. Application Gateway 에 CustomDomain 설정