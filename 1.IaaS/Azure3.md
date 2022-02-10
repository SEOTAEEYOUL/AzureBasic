# 3-tier 기본 환경 구성
Vnet, subnet, NSG, apache, tomcat, mysql 구성
- VM, disk, Storage Account, Internal L4, VMSS, AppGateway 구성

* [빠른 시작: PowerShell을 사용하여 Azure Database for MySQL 서버 만들기](https://docs.microsoft.com/ko-kr/azure/mysql/quickstart-create-mysql-server-database-using-azure-powershell)  


## Login
- Portal, Powershell, Azure CLI 는 각각의 로그인 영역을 가짐
- 여러개의 Login 을 가질 경우 Portal(화면) 과 Cmd(Powershell, Azure CLI) 가 다르게 보일 수 있음


### Powershell
```powershell
Connect-AzAccount
Get-AzSubscription
```

### Azure CLI
```bash
az login
```
## [Resource Group 만들기](./AzureResourceGroup.md)
- rg-skcc1-homepage-dev

## [Virtual Network 만들기](./AzureVirtualNetwork.md)
- vnet-skcc1-dev
### NSG
#### nsg-skcc1-homepage
- nsg rule
  - nsgr-ssh
  - nsgr-www
  - nsgr-mysql
### subnet
- frontend subnet  
  - 이름 : snet-skcc1-dev-frontend
  - 서브넷 주소 범위 : 10.0.0.0/28
- backend subnet  
  - 이름 : snet-skcc1-dev-backend  
  - 서브넷 주소 범위 : 10.0.1.0/28  

### 서비스 VM 생성
#### VM 생성 전 사전 작업(옵션)
#### [Storage Account 만들기(부트진단용)](./AzureStorageAccount.md)
- Storage Account : skcc1devhomepagedev01

#### [VM Backup 용 Recovery Services 자격 증명 모음](./AzureBackup.md)
- Recovery Services 자격 증명 모음 : skcc1-rsv-VMbackup-dev

#### [Public IP 만들기](./AzurePublicIPAddress.md)  
#### [NIC 만들기](./AzureNIC.md)  

### [Virtaul Machine 만들기](./AzureVirtualMachine.md)
- vm-skcc1-comdpt1
- vm-skcc1-comdap1
#### [VM접속](./VM접속.md)  
- 서버 생성시 만든 pem 파일로 window, linux 에서 접속 하는 방법 소개

#### [Apache 구성](./Apache.md)
- 예시로 사용하기 위한 Apache 설치 및 구성

#### [Tomcat 구성](./Tomcat.md)
- 예시로 사용하기 위한 Tomcat 설치 및 구성
### [Azure MySQL](./AzureMySQL.md)
- mysql-homepage
- 예시로 사용하기 위한 MySQL 배포 및 구성

- [예시 샘플 넣기](./SpringbootMySQLSample.md)