# 3-tier 기본 환경 외부 접근 구성
3-tier 기본 환경에 CDN 적용, Azure DNS 설정, AppGateway 구성 변경
- Application Gateway 구성
- Azure DNS 구성


## [Resource Group 만들기](./AzureResourceGroup.md)
- rg-skcc1-network-dev

## [Virtual Network 만들기](./AzureVirtualNetwork.md)
- vnet-network-dev
### NSG
#### nsg-network-nsg
- nsg rule
  - nsgr-www
  - nsgr-ag
### subnet
- frontend subnet : snet-skcc1-network-frontend

## [Virtual Network Peering](./AzureVirtualNetworkPeering.md) 
vnet 간의 통신을 위한 작업
### vnet-network-dev <-> vnet-skcc1-dev
- vnetpeering-nw-homepage-dev-1
- vnetpeering-homepage-nw-dev-1

## [Azure Application Gateway](./AzureApplicationGateway.md)
웹 애플리케이션 앞단에서 Traffic 을 관리하는 Web Traffic 부하 분산 장치  
URL 기반으로 Backend Pool 로 부하 분산 가능  
WAF, SSL Termination (SSL Offload) 요건이 있는 경우 사용  
- skcc1-homepage-dev-appgw
- rule 설정  

## [App Service Domain](./AzureAppServiceDomain.md) 을 사용 "domain 생성"
Azure에서 직접 관리하는 사용자 지정 도메인 생성  
Azure DNS 
- nodespringboot.net 생성

## [DNS 영역](./AzureDNS.md) 에 정보 등록  
단독으로 만들 경우 외부 domain 생성된 곳에 Azure DNS 서버를 등록 하여 사용  
App Service Domain 을 만들 경우 생성  
- www "A" 레코드 집합을 생성하여 Application Gateway 의 IP 를 등록함  

