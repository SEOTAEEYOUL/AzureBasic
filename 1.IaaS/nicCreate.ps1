

$location="koreacentral"
$resourceGroup="myResourceGroup"

$vnetName="myVnet"
$subnetFrontendName="mySubnetFrontEnd"
$subnetBackendName="mySubnetBackEnd"

$vnetAddrPrefix="192.168.0.0/16"
$subnetFrontendAddrPrefix="192.168.1.0/24"
$subnet-backendAddrPrefix="192.168.2.0/24"

$nsgName="myNetworkSecurityGroup"
$nicName="myNic"

$vmName="myVM"
# $vmSize="Standard_DS3_v2"
$vmSize="Standard_D1_v2"

New-AzResourceGroup -Name "$resourceGroup" -Location "$location"

# Create a subnet configuration
$mySubnetFrontEnd = New-AzVirtualNetworkSubnetConfig -Name "$subnetFrontendName" `
  -AddressPrefix "$subnetFrontendAddrPrefix"
$mySubnetBackEnd = New-AzVirtualNetworkSubnetConfig -Name "$subnetBackendName" `
  -AddressPrefix "$subnetBackendAddrPrefix"

# Create Virtual Network
$myVnet = New-AzVirtualNetwork -ResourceGroupName "$resourceGroup" `
  -Location "$location" `
  -Name "$vnetName" `
  -AddressPrefix "$vnetAddrPrefix" `
  -Subnet $mySubnetFrontEnd,$mySubnetBackEnd

# Create a public IP address and specify a DNS name
$pip = New-AzPublicIpAddress `
  -ResourceGroupName "$resource-group" `
  -Location "$location" `
  -AllocationMethod Static `
  -IdleTimeoutInMinutes 4 `
  -Name "mypublicdns$(Get-Random)"

# Create an inbound network security group rule for port 22
$nsgRuleSSH = New-AzNetworkSecurityRuleConfig `
  -Name "myNetworkSecurityGroupRuleSSH"  `
  -Protocol "Tcp" `
  -Direction "Inbound" `
  -Priority 1000 `
  -SourceAddressPrefix * `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 22 `
  -Access "Allow"

# Create an inbound network security group rule for port 80
$nsgRuleWeb = New-AzNetworkSecurityRuleConfig `
  -Name "myNetworkSecurityGroupRuleWWW"  `
  -Protocol "Tcp" `
  -Direction "Inbound" `
  -Priority 1001 `
  -SourceAddressPrefix * `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 80 `
  -Access "Allow"

# Create a network security group
$nsg = New-AzNetworkSecurityGroup `
  -ResourceGroupName "$resourceGroup" `
  -Location "$location" `
  -Name "$nsgName" `
  -SecurityRules $nsgRuleSSH,$nsgRuleWeb

# Create a virtual network card and associate with public IP address and NSG
$nic = New-AzNetworkInterface `
  -Name "$nicName" `
  -ResourceGroupName "$resourceGroup" `
  -Location "$location" `
  -SubnetId $vnet.Subnets[0].Id `
  -PublicIpAddressId $pip.Id `
  -NetworkSecurityGroupId $nsg.Id

# VM 자격 증명 설정
# Define a credential object
$securePassword = ConvertTo-SecureString ' ' -AsPlainText -Force
# $cred = Get-Credential
$cred = New-Object System.Management.Automation.PSCredential ("azureuser", $securePassword)

#######################
# VM 구성 생성 
$vmConfig = New-AzVMConfig -VMName "$vmName" -VMSize "$vmSize"

# Windows VM 만들기
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig `
  -Windows `
  -ComputerName "$mvName" `
  -Credential $cred `
  -ProvisionVMAgent `
  -EnableAutoUpdate

$vmConfig = Set-AzVMSourceImage -VM $vmConfig `
  -PublisherName "MicrosoftWindowsServer" `
  -Offer "WindowsServer" `
  -Skus "2016-Datacenter" `
  -Version "latest"

## NIC 추가
$VmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $myNic1.Id -Primary
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $myNic2.Id
#######################

#######################
# Linux VM 만들기
# Create a virtual machine configuration
$vmConfig = New-AzVMConfig `
-VMName "myVM" `
-VMSize "Standard_D1_v2" | `
Set-AzVMOperatingSystem `
-Linux `
-ComputerName "myVM" `
-Credential $cred `
-DisablePasswordAuthentication | `
Set-AzVMSourceImage `
-PublisherName "Canonical" `
-Offer "UbuntuServer" `
-Skus "18.04-LTS" `
-Version "latest" | `
Add-AzVMNetworkInterface `
-Id $nic.Id

# Configure the SSH key
$sshPublicKey = cat ~/.ssh/id_rsa.pub
Add-AzVMSshPublicKey `
  -VM $vmconfig `
  -KeyData $sshPublicKey `
  -Path "/home/azureuser/.ssh/authorized_keys"

# 이전 구성 정의를 결합
New-AzVM `
  -ResourceGroupName "$resourceGroup" `
  -Location "$location" `
  -VM $vmConfig

# 공용 IP 주소 보기
Get-AzPublicIpAddress -ResourceGroupName "$resourceGroup" | Select "IpAddress"
#######################

