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

## [Azure Application Gateway](./AzureApplicationGateway.md)
- skcc-homepage-prd-appgw
- rule 설정  

## [App Service Domain](./AzureAppServiceDomain.md)  