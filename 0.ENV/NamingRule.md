# 명명 규칙(Naming Rule)
* [Azure 리소스에 대한 명명 규칙 및 제한 사항](https://docs.microsoft.com/ko-kr/azure/azure-resource-manager/management/resource-name-rules)


1. 명명은 모두 기본 소문자로 합니다. (단 윈도우 VM의 경우 대문자 사용)
2. <항목> 으로 표시된 내용은 선택 항목입니다.
3. 독립 자원은 Prefix를 사용하고, 종속자원 (e.g. DISK, NIC, IP 등)은 Postfix로 사용합니다.
2. 스페이스나 특수문자는 허용되지 않습니다-하이픈 제외
3. 아래 리스트에 패턴이 명시되지 않은 서비스의 사용시 2.1~2.5까지 기재된 리스트를 기초로 아래와 같은 패턴 규칙을 사용하여 명명합니다.
하이픈이 있을 때는 아래와 같은 패턴을 기본 규칙으로 합니다.
<부서 또는 영역>-<환경>-<리전>-<서비스 또는 애플리케이션 이름>-<###>-<Azure 서비스 명>
하이픈이 없을 때는 아래와 같은 패턴을 기본 규칙으로 합니다.
<부서 또는 영역><환경><리전><서비스 또는 애플리케이션 이름><###><Azure 서비스 명> 
  * <부서 또는 영역>은 글로벌한 리소스 생성시에는 생략이 가능합니다.
  * <###>는 HA가 가능하거나 하나의 리소스에 여러 개의 리소스가 만들어질 때 사용합니다.
  * 최소한 세 가지 Segment를 사용하여 명명을 해야 합니다.
4. 명명에 되도록이면 하이픈을 씁니다. 단, 대소문자와 숫자만 적용이 가능한 서비스에서는 제외를 합니다.
5. 각 Segment는 Segment 별로 정의된 리스트의 명명 혹은 약어를 써야 합니다.


## 서비스환경
| 환경분류 | Short Code | Long Code |  
|:---|:---|:---|
| Development |	d	| dev |
| Test | t | test |
| Staging | s	| stg |
| Production | p | prd |

## Azure Service
| Resource/Service | Short Code | Long Code |  
|:---|:---|:---|
| Subscription | sub | sub |
| Resource Group | rg | rg |
| Virtual Machine | vm | vm |
| Virtual Machine Scale Sets | vmss | vmss |
| Availability Set | avs | avset |
| Virtual Network | vn | vnet |
| Subnet | subnet | subnet
| Public IP Address  | pip | publicip |
| Network Security Group | nsg | netsecgrp |
| Network Security Group Rule | nsgr | netsecgrprule
| Storage Account | strg | storage |
| TrafficManager | tm | trafficmgmr | 
| Load Balancer | lb | loadbalancer | 
| Application Gateway | agw | appgateway |
| App Service| svc | appsvc |
| Azure Cache for Redis | redis | redis | 
| Key Vault | kv | kv |
| App Service Plan | asp | appplan
| Azure SQL Database | sqldb | sqldb |
| Azure SQL Server | sql | sql |
| Disk | disk | disk |
| DNS Zone | dns | dnszone |
| Log Analytics | loa | loganalytics |
| Logic App | loga | logapp |
| Network Interface | nic | netinterface |
| Cosmos DB | cosmos | cosmosdb |
| App Service Environment | ase	| appenv |
| Function App | func | func |
| Container Registry | acr | acr |
| Container Instances | aci | aci |
| Kubernetes Service | aks | aks |
| Network Watcher | nww | nww | 
| ExpressRoute | er | er |
| Application Insights | ai | ai
| Data Factory | df | df |
| Azure DB for PostgreSQL | psql | sql |
| Azure DB for MySQL | mysql | mysql |

## 지역
| 약자 | 리전 위치 | Short Code |  
|:---|:---|:---|
| koce | koreacentral | kc | 
| koso | koreasouth | ks |

## 예시
| Azure 서비스 혹은 개체 | 패턴 | 예시 |
|:---|:---|:---|
| Subscription | SK Square-<환경> | SK Square-LandingZone |  
| Resource Group | rg-sksq-<서비스 구분>-<환경> | rg-sksq-lz-network-prd | 
| Virtual Machine	[리눅스/윈도우 공통] | SKSQ-<업무명><환경><서버 용도><숫자> </br> 상세) 고객사명(SKSQ)-업무명(ERP)개발(D)/운영(P)서버용도(DB)번호(#) | SKSQ-WSUSPAP1 |
| Storage account name (general) | <sksq><환경><서비스 고유 명칭><숫자> | sksqprddbafiles1 |
| Storage account name (diagnostics) |<sksq><환경>stdiag | sksqlzprdstdiag |  
| Managed Disk name | <VM 명>-ssd<##> </br> <VM 명>-<디스크용도><##> | SKSQ-WSUSPAP1-ssd01 </br> SKSQ-ERPPDB1-log01 | 
| Virtual Network (VNet) | vnet-sksq-<환경> | vnet-sksq-lz-prd |
| Subnet | snet-sksq-<환경>-<Subnet 용도(대역정보)>-<추가 구분 정보> | snet-sksq-prd-10.234.0.32-63-lz-shared-svc |
| Route Table	| udr-<환경>-<Route Table 구분> | udr-lz-prd-shared |
| Network Virtual Gateway | vngw-<VNet 용도 구분>-<환경>-<추가 구분 정보> | vngw-sharednw-prd-expressroute | 
| Network Interface	<VM명>-nic<##> | SKSQ-WSUSPAP1-nic01 |
| Network Security Group | snet-sksq-<환경>-<서비스 구분>-nsg | snet-sksq-lz-prd-shared-svc-nsg | 
| Network Security Group Rule | <"allow"/"deny">-<인바운드/아웃바운드>-<내부/외부>-<포트 또는 트래픽 타입> | allow-inbound-internal-http | 
| Public IP Address | <리소스명>-pip | SKSQ-ERPDDB1-pi </br> sksq-lz-prd-azfw-pip |  
| Load Balancer | plb/ilb-<SKU Type>-<서비스 구분>-<LB 용도 구분> | ilb-std-shared-prd1 | 
| Connection | conn-<VNET 용도 구분>-<환경>-<연결 사이트 구분> | conn-shared-service-prd-ergw |  
| VNet Peering Connection | vnetpeering-<Source VNET 환경>-<Destination VNET 환경>-<숫자> | vnetpeering-lz-dev-1 </br> vnetpeering-prd-lz-1 |  
| Load Balanced Rules Config | plb/ilb-<SKU Type>-<서비스 용도 구분>-<LB Rule 구분>-<LB 용도 구분>-rule<#> | ilb-std-erp-internal-ERPPAP-ASCS-prd1-rule1 |  
| Azure Application Gateway | sksq-<환경>-agw | sksq-lz-prd-appgw | 
| Recovery Services | sksq-rsv-<서비스 또는 애플리케이션 명>backup-<환경> | sksq-rsv-VMbackup-lz | 
| Shared Image Gallery | sksq_<환경>_image_gallery | sksq_dev_image_gallery |
