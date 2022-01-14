# Azure Cloud 3 Tier (VM 기반)

> [Azure에서 가상 머신에 대한 크기](https://docs.microsoft.com/ko-kr/azure/virtual-machines/sizes)
> [스토리지 계정 만들기](https://docs.microsoft.com/ko-kr/azure/storage/common/storage-account-create?tabs=azure-powershell)  
> [빠른 시작: Azure CDN 프로필 및 엔드포인트 만들기](https://docs.microsoft.com/ko-kr/azure/cdn/cdn-create-new-endpoint)  
> [자습서: Azure App Service 웹앱에 Azure CDN 추가](https://docs.microsoft.com/ko-kr/azure/cdn/cdn-add-to-web-app)  

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

### 프로젝트 때 사용한 VM 생성 스크립트  
| 파일명 | 설명 | 
|:---|:---|  
| vm_deployscript_template.ps1 | VM 생성 파워셀 스크립트 |  
| vm_parameter_template.csv | VM 생성 파워셀 스크립트 인자 파일 |   

### 자원 목록    
| 항목 | 자원명 | 설명 | 사이징 | end point | Resource Group | Location |  
|:---|:---|:---|:---|:---|:---|:---| 
| Resource Group | rg-sksq-network-prd | Network 자원 그룹 | | | | koreacentral | 
| Resource Group | rg-sksq-homepage-prd | Home Page 자원 그룹 | | | | koreacentral | 
| Vnet | vnet-sksq-prd | 홈페이지 VNet | 10.234.4.0/22 | | rg-sksq-network-prd | koreacentral |  
| subnet | snet-sksq-prd-10.234.4.160-191-anf | HostedWorkloads | | 10.234.4.160/27 | rg-sksq-network-prd | koreacentral |  
| subnet | snet-sksq-prd-10.234.4.128-159-dmz | 외부에서 접근 시 사용되는 자원 배포 영역 | | 10.234.4.128/27 | rg-sksq-network-prd | koreacentral |   
| subnet | snet-sksq-prd-10.234.4.0-127-frontend | 내부에서 API 형태로 접근시 사용되는 자원 배포 영역 | | 10.234.4.0/25 | rg-sksq-network-prd | koreacentral |  
| subnet | snet-sksq-prd-10.234.5.0-255-backend | | | 10.234.5.0/24 | rg-sksq-network-prd | koreacentral |  
| Storage Account | sksqprdhomepagefiles1 | | | PE-sksqprdhompagefiles1 | rg-sksq-homepage-prd | koreacentral |
| VM | SKSQ-COMPPT1 | Web 서버 | Standard D8s v3 | 10.234.4.134 | rg-sksq-homepage-prd | koreacentral |  
| VM | SKSQ-COMPAP1 | WAS 서버 | Standard D8s v3 | 
10.234.5.36 |rg-sksq-homepage-prd | koreacentral |
| DB | mysql-homepage-prd | MySQL 5.7 | GP_Gen5_8(범용, vCore 8개, 5GB) | PE-sksqhomepageprdmysql | rg-sksq-homepage-prd | koreacentral |


### subnet
| AddressPrefix | Name | ResourceGroup | Purpose |
|:---|:---|:---|:---|
| 10.234.4.160/27 | snet-sksq-prd-10.234.4.160-191-anf | rg-sksq-network-prd | HostedWorkloads |
| 10.234.4.128/27 | snet-sksq-prd-10.234.4.128-159-dmz | rg-sksq-network-prd | 외부에서 접근 시 사용되는 자원 배포 영역 | 
| 10.234.4.0/25 | snet-sksq-prd-10.234.4.0-127-frontend | rg-sksq-network-prd | 내부에서 API 형태로 접근시 사용되는 자원 배포 영역 |
| 10.234.5.0/24 | snet-sksq-prd-10.234.5.0-255-backend | rg-sksq-network-prd | PrivateEndpoints | |


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


## CDN 
### 생성 절차
1. CDN 생성
   - Profile 생성 : sksq-lz-prd-cdn
   - endpoint 생성 : sksquare-homepage-dev-cdn.azureedge.net
   - HomePage : https://sksquare-homepage-dev-cdn.azureedge.net/
2. Rule 생성

## App Service 도메인

### DNS 등록
1. CNAME : sksquare-homepage-dev-cdn.azureedge.net
   - www.sksquaredev.com 의 서비스 주소
2. A Record : 20.196.232.11
   - applicaion gateway 의 ip 로 CDN 장애시 tomcat 서버로 직접 붙기 위함
3. Application Gateway 에 CustomDomain 설정