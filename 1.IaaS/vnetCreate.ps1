# 변수 선언
$groupName = "rg-skcc-homepage-dev"
$locationName = "koreacentral"

$vnetName = "vnet-skcc-dev"
$vnetAddressPrefix = '10.0.0.0/16'

$subnetFrontendName = 'snet-skcc-dev-frontend'
$subnetFronendAddressPrefix = '10.0.0.0/28'
$subnetBackendName = 'snet-skcc-dev-backend'
$subnetAddressPrefix = '10.0.1.0/28'

$storageAccountName = 'skccdevhomepagedev'
$storageAccountSkuName ='Standard_LRS'

$nsgName = 'nsg-skcc-homepage' 

$pipName = 'pip-skcc-comdpt1'
$nicName = 'nic-skcc-comdpt1'

$vmName = "vm-skcc-comdpt1"
$vmSize = "Standard_B2s"

$vmOSDisk = $vmName + "-OSDisk01"
$osDiskType = "StandardSSD_LRS"
$osDiskSizeInGB = 64

$vmDataDisk = $vmName + "-DataDisk01"
$osDataDiskSizeInGB = 64
$StorageAccountType = 'StandardSSD_LRS'


### Resource Group 만들기
New-AzResourceGroup `
   -ResourceGroupName $groupName `
   -Location $locationName 
```
```powershell
$rg = @{
    Name = $groupName
    Location = $locationName 
}
New-AzResourceGroup @rg

### 리소스 그룹 잠금
New-AzResourceLock `
  -LockName LockGroup `
  -LockLevel CanNotDelete `
  -ResourceGroupName $groupName

###  확인
Get-AzResourceLock \
  -ResourceGroupName $groupName

## VNet 만들기
Write-Host $vnet-skcc-dev
$vnet = @{
    Name = $vnetName
    ResourceGroupName = $groupName
    Location = $locationName
    AddressPrefix = $vnetAddressPrefix    
}
$virtualNetwork = New-AzVirtualNetwork @vnet


## subnet 만들기
Write-HOST "frontend subnet : $subnetFrontendName, $subnetFronendAddressPrefix"
Write-HOST "backend subnet : $subnetBackendName, $subnetBackendName, "
$subnet_frontend = @{
    Name = $subnetFrontendName
    VirtualNetwork = $virtualNetwork
    AddressPrefix = $subnetFronendAddressPrefix
}
$subnetConfig_frontend = Add-AzVirtualNetworkSubnetConfig @subnet_frontend
$subnet_backend = @{
    Name = $subnetBackendName
    VirtualNetwork = $virtualNetwork
    AddressPrefix = $subnetAddressPrefix
}
$subnetConfig_backend = Add-AzVirtualNetworkSubnetConfig @subnet_backend

## 가상 네트워크에 subnet 연결
$virtualNetwork | Set-AzVirtualNetwork


## Storage Account
Write-Host "SKU : Standard_LRS (가장 저렴한 중복성 옵션)"
Write-Host "생성시 시간이 1 ~ 2 분 걸림"
### Stroage Account 만들기
$storage_account = @{
    Name = $storageAccountName
    ResourceGroupName = $groupName
    Location = $locationName
    SkuName = $storageAccountSkuName
    Kind = 'StorageV2'
}
New-AzStorageAccount @storage_account


# Approach 1: Create a container
New-AzStorageContainer -Name $containerName -Context $ctx


Write-Host "NSG Rule 만들기"
Write-Host "Create an inbound network security group rule for port 22"
$nsgRuleSSH = New-AzNetworkSecurityRuleConfig `
  -Name "nsg-rule-ssh"  `
  -Protocol "Tcp" `
  -Direction "Inbound" `
  -Priority 1000 `
  -SourceAddressPrefix * `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 22 `
  -Access "Allow"

### Create an inbound network security group rule for port 80
$nsgRuleWeb = New-AzNetworkSecurityRuleConfig `
  -Name "nsg-rule-www"  `
  -Protocol "Tcp" `
  -Direction "Inbound" `
  -Priority 1001 `
  -SourceAddressPrefix * `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 10080 `
  -Access "Allow"

Write-Host "Create a network security group"
$nsg = New-AzNetworkSecurityGroup `
  -ResourceGroupName $groupName `
  -Location $locationName `
  -Name $nsgName `
  -SecurityRules $nsgRuleSSH,$nsgRuleWeb

Write-Host "public-ip 만들기"
$vnet = $virtualNetwork = Get-AzVirtualNetwork |?{$_.Name -eq 'vnet-skcc-dev'}
$pip = New-AzPublicIpAddress `
  -Name $pipName `
  -ResourceGroupName $groupName `
  -Location $locationName `
  -AllocationMethod Static `
  -IdleTimeoutInMinutes 4

Write-Host "NIC 만들기"
# Write-Host "VNet 정보 가져오기"
$virtualNetwork = Get-AzVirtualNetwork |?{$_.Name -eq $vnetName }

#### 
$frontEnd = $virtualNetwork.Subnets|?{$_.Name -eq $subnetFrontendName }
$nic = New-AzNetworkInterface `
  -ResourceGroupName $groupName `
  -Name $nicName `
  -Location $locationName `
  -SubnetId $frontEnd.Id `
  -PublicIpAddressId $pip.Id `
  -NetworkSecurityGroupId $nsg.Id

Write-Host "credential object 정의"
$securePassword = ConvertTo-SecureString 'dlatl!00' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("azureuser", $securePassword)

Write-Host "VM 크기 설정"
$vmConfig = New-AzVMConfig `
  -VMName $vmName `
  -VMSize $vmSize

### VM 크기 예시
Write-Host "Standard_B2s : [B-시리즈 버스터블 가상 머신](https://docs.microsoft.com/ko-kr/azure/virtual-machines/sizes-b-series-burstable)
  - CPU : 2 vCPU
  - 메모리 : 4 GiB
  - 임시 스토리지(SSD) : 8 GiB"

Write-Host "Standard_D1_v2 : [Dv2 시리즈](https://docs.microsoft.com/ko-kr/azure/virtual-machines/dv2-dsv2-series)
  - CPU : 1 vCPU
  - 메모리 : 3.5 GiB
  - 임시 스토리지(SSD) : 50 GiB"

Write-Host "Standard_DS3_v2 : DSv2 시리즈
  - CPU : 4 vCPU
  - 메모리 : 14 GiB
  - 임시 스토리지(SSD) : 28 GiB"



Write-Host "소스 이미지 구성"
Write-Host "Linux (Ubuntu)""
Write-Host "APACHE : vm-skcc-comdpt1"
Write-Host "TOMCAT : vm-skcc-comdap1"
$vmConfig = Set-AzVMOperatingSystem `
  -VM $vmConfig `
  -Linux `
  -ComputerName $vmName `
  -Credential $cred `
  -DisablePasswordAuthentication
$vmConfig = Set-AzVMSourceImage `
  -VM $vmConfig `
  -PublisherName "Canonical" `
  -Offer "UbuntuServer" `
  -Skus "18.04-LTS" `
  -Version "latest"

### 인터페이스 추가
$vmConfig = Add-AzVMNetworkInterface `
  -VM $vmConfig `
  -Id $nic.Id

### SSH key 구성
#### SSH 키 쌍 만들기
Write-Host "[ssh-keygen](https://www.ssh.com/academy/ssh/keygen) 사용"
Write-Host "옵션 -t rsa : 모든 SSH 클라이언트는 이 알고리즘을 지원"
Write-Host "ssh-keygen -t rsa -b 4096"

$sshPublicKey = cat ~/.ssh/id_rsa.pub
Add-AzVMSshPublicKey `
  -VM $vmConfig `
  -KeyData $sshPublicKey `
  -Path "/home/azureuser/.ssh/authorized_keys"

### OS Disk 설정
$resourceGroup = Get-AzResourceGroup -Name 'rg-skcc-homepage-dev'
$location = $resourceGroup.Location
$osDiskType = (Get-AzDisk -ResourceGroupName $resourceGroup.ResourceGroupName)[0].Sku.Name

$vmConfig = Set-AzVMOSDisk `
  -VM $vmConfig `
  -Name $vmOSDisk `
  -DiskSizeinGB $osDiskSizeInGB `
  -StorageAccountType $osDiskType `
  -CreateOption FromImage `
  -Caching ReadWrite `
  -Linux

### Data 디스크 설정
$vmConfig = Add-AzVMDataDisk `
  -VM $vmConfig `
  -Name $vmDataDisk `
  -DiskSizeinGB $osDataDiskSizeInGB `
  -CreateOption Empty `
  -StorageAccountType $StorageAccountType `
  -Caching ReadWrite `
  -Lun 1

Write-Host "boot diagnostics"  
$vmConfig = Set-AzVMBootDiagnostic `
  -VM $vmConfig `
  -Enable `
  -resourceGroup "rg-skcc-homepage-dev" `
  -StorageAccountName "skccdevhomepagedev"

Write-Host "VM 만들기"
New-AzVM -VM $vmConfig `
  -ResourceGroupName "rg-skcc-homepage-dev" `
  -Location "koreacentral"

Write-Host "Backup 적용"
Write-Host "Backup 기본 정책을 설정"
$policy = Get-AzRecoveryServicesBackupProtectionPolicy `
  -Name "DefaultPolicy"

Write-Host "VM 백업을 사용하도록 설정"
$vm='vm-skcc-comdpt1';
Enable-AzRecoveryServicesBackupProtection `
  -ResourceGroupName "rg-skcc-homepage-dev" `
  -Name "$vm" `
  -Policy $policy

  Write-Host "생성 완료"