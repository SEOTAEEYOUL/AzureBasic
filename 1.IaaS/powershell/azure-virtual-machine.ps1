. ./azure-virtual-machine-env.ps1

Write-Host "Virtual Network[$vnetName] 정보 가져오기"
$virtualNetwork = Get-AzVirtualNetwork |?{$_.Name -eq $vnetName }
# $virtualNetwork

Write-Host "Public IP[$pipName] 만들기"
$pip = New-AzPublicIpAddress `
  -Name $pipName `
  -ResourceGroupName $groupName `
  -Location $locationName `
  -AllocationMethod Static `
  -IdleTimeoutInMinutes 4 `
  -Sku 'Standard' `
  -Tag $tags
<# 
$pip = Get-AzPublicIpAddress -Name $pipName
#>

Write-Host "NSG[$nsgName] 정보 가져오기"
$nsg = Get-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $groupName

Write-Host "subnet[$subnetFrontEndName] 정보 가져오기"
$subnet = $virtualNetwork.Subnets|?{$_.Name -eq $subnetFrontendName }
<# 
$Subnet = Get-AzVirtualNetwork -Name "VirtualNetwork1" -ResourceGroupName "ResourceGroup1" 
$IPconfig = New-AzNetworkInterfaceIpConfig -Name "IPConfig1" -PrivateIpAddressVersion IPv4 -PrivateIpAddress "10.0.1.10" -SubnetId $Subnet.Subnets[0].Id
New-AzNetworkInterface -Name "NetworkInterface1" -ResourceGroupName "ResourceGroup1" -Location "centralus" -IpConfiguration $IPconfig
#>
Write-Host "NIC[$nicName] 생성"
$nic = New-AzNetworkInterface `
  -ResourceGroupName $groupName `
  -Name $nicName `
  -Location $locationName `
  -SubnetId $subnet.Id `
  -PublicIpAddressId $pip.Id `
  -NetworkSecurityGroupId $nsg.Id `
  -Tag $tags
<#
$nic = Get-AzNetworkInterface -Name $nicName
#>

Write-Host "사용자 암호(credential object) 정의"
$securePassword = ConvertTo-SecureString 'dlatl!00' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("azureuser", $securePassword)

Write-Host "VM $vmName 크기 설정 : $vmSize"
$vmConfig = New-AzVMConfig `
  -VMName $vmName `
  -VMSize $vmSize `
  -Zone $zone `
  -Tag $tags

Write-Host "Linux 소스 이미지 구성: 운영체계, 버전"
#### Linux (Ubuntu)
# APACHE : vm-skcc-comdpt1
# TOMCAT : vm-skcc-comdap1
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

Write-Host "VM 에 인터페이스 추가"
$vmConfig = Add-AzVMNetworkInterface `
  -VM $vmConfig `
  -Id $nic.Id

Write-Host "공개 키 설정"
$sshPublicKey = cat ~/.ssh/id_rsa.pub
Add-AzVMSshPublicKey `
  -VM $vmConfig `
  -KeyData $sshPublicKey `
  -Path "/home/azureuser/.ssh/authorized_keys"

Write-Host "OS Disk 설정"
$resourceGroup = Get-AzResourceGroup -Name $groupName
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

Write-Host "Data 디스크 설정"
$vmConfig = Add-AzVMDataDisk `
  -VM $vmConfig `
  -Name $vmDataDisk `
  -DiskSizeinGB $osDataDiskSizeInGB `
  -CreateOption Empty `
  -StorageAccountType $StorageAccountType `
  -Caching ReadWrite `
  -Lun 1

Write-Host "boot diagnotics"
$vmConfig = Set-AzVMBootDiagnostic `
  -VM $vmConfig `
  -Enable `
  -resourceGroup $groupName `
  -StorageAccountName $storageAccountName

Write-Host "VM 만들기"
$vm = @{
  ResourceGroupName = $groupName
  Location = $locationName
  VM = $vmConfig
  Tag = $tags
}
New-AzVM @vm # -AsJob
<# 
New-AzVM -VM $vmConfig `
  -ResourceGroupName $groupName `
  -Location $locationName `
  -Tag $tags
#>

# Pause for 1 seconds per loop
Do {
  # Do stuff
  # Sleep 5 seconds
  Write-Host "  VM[$vmName] 생성중 ..."
  Start-Sleep -s 1
  $name =  Get-AzVM -Name $vmName | Select name | grep vm
}
while ($name -ne $vmName)
Write-Host "VM($vmName) 생성 완료."
# while ($condition -eq $true)


Write-Host "### Backup 적용"
Write-Host "- 기본 정책을 설정"
$policy = Get-AzRecoveryServicesBackupProtectionPolicy `
  -Name "DefaultPolicy"

Write-Host "- VM ($groupName $vmName $policy) 백업을 사용하도록 설정"
# $vmName='vm-skcc-comdpt1';
Enable-AzRecoveryServicesBackupProtection `
  -ResourceGroupName $groupName `
  -Name $vmName `
  -Policy $policy