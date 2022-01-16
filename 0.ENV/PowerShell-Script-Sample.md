# PowerShell Script 실행 예제

## Import-CSV
- CSV 가져오기
```powershell
$products = Import-Csv .\test.csv -Encoding UTF8
$products | Format-Table
```

## ForEach-Object
- 
```powershell
```

## Select-AzSubscription
- 구독 선택/변경
```powershell
Select-AzSubscription "Azure subscription 1"


Name                                     Account                           SubscriptionName                 Environment                      TenantId
----                                     -------                           ----------------                 -----------                      --------
Azure subscription 1 (9ebb0d63-8327-402… ca07456@sktda.onmicrosoft.com     Azure subscription 1             AzureCloud                       160bacea-7761-4c83-bfa0-354f9b0… 
```

## ConvertTo-SecureString
- 암호화된 문자열로 변경
```powershell
$secure = read-host -assecurestring
$secure
$encrypted = convertfrom-securestring -securestring $secure
$encrypted
$secure2 = convertto-securestring -string $encrypted
$secure2
```

## New-Object
- .NET 및 COM 개체 만들기
```powershell
$SecurePassword = ConvertTo-SecureString "dlatl!00" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential("sysadmin",$SecurePassword);
```

## VM 만들기
```
PS C:\workspace\AzureBasic\0.ENV> ssh-keygen -t rsa -b 4096

Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\taeey/.ssh/id_rsa): ./.ssh/id_rsa
./.ssh/id_rsa already exists.
Overwrite (y/n)? y
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in ./.ssh/id_rsa
Your public key has been saved in ./.ssh/id_rsa.pub
The key fingerprint is:
SHA256:gEfKu1joY11R+waG51xWMs2roEHi/qgirTDdcn5j4OU taeey@DESKTOP-QR555PR
The key's randomart image is:
+---[RSA 4096]----+
|      . . oo.    |
|   ..+.o . +o    |
|   .+o= = o  .   |
|   ..o.B.=  .    |
|  ..o .oS.o.     |
| o =ooo  ..      |
|o.B.=*           |
|+o.=o E          |
|oo...o .         |
+----[SHA256]-----+
PS C:\workspace\AzureBasic\0.ENV> $vnet = $virtualNetwork = Get-AzVirtualNetwork |?{$_.Name -eq 'vnet-skcc-dev'}

PS C:\workspace\AzureBasic> $pip = New-AzPublicIpAddress `
>>   -Name "pip-skcc-comdpt1" `
>>   -ResourceGroupName "rg-skcc-homepage-dev" `
>>   -Location "koreacentral" `
>>   -AllocationMethod Static `
>>   -IdleTimeoutInMinutes 4

WARNING: Upcoming breaking changes in the cmdlet 'New-AzPublicIpAddress' :
Default behaviour of Zone will be changed
Cmdlet invocation changes :
    Old Way : Sku = Standard means the Standard Public IP is zone-redundant.
    New Way : Sku = Standard and Zone = {} means the Standard Public IP has no zones. If you want to create a zone-redundant Public IP address, please specify all the zones in the region. For example, Zone = ['1', '2', '3'].
Note : Go to https://aka.ms/azps-changewarnings for steps to suppress this breaking change warning, and other information on breaking changes in Azure PowerShell.

PS C:\workspace\AzureBasic\0.ENV> $nic = New-AzNetworkInterface `
>>   -ResourceGroupName "rg-skcc-homepage-dev" `
>>   -Name "nic-skcc-comdpt1" `
>>   -Location "koreacentral" `
>>   -SubnetId $frontEnd.Id `
>>   -PublicIpAddressId $pip.Id `
>>   -NetworkSecurityGroupId $nsg.Id

Confirm
Are you sure you want to overwrite resource 'nic-skcc-comdpt1'
[Y] Yes [N] No [S] Suspend [?] Help (default is "Yes"): Y
PS C:\workspace\AzureBasic\0.ENV> $frontEnd.Id

/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-homepage-dev/providers/Microsoft.Network/virtualNetworks/vnet-skcc-dev/subnets/snet-skcc-dev-frontend
PS C:\workspace\AzureBasic\0.ENV> $pip.id

/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-homepage-dev/providers/Microsoft.Network/publicIPAddresses/nic-skcc-comdpt1
PS C:\workspace\AzureBasic\0.ENV> $nsg.id

/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-homepage-dev/providers/Microsoft.Network/networkSecurityGroups/nsg-skcc-homepage
PS C:\workspace\AzureBasic\0.ENV> $securePassword = ConvertTo-SecureString ' ' -AsPlainText -Force

PS C:\workspace\AzureBasic\0.ENV> $cred = New-Object System.Management.Automation.PSCredential ("azureuser", $securePassword)

PS C:\workspace\AzureBasic\0.ENV> $vmConfig = New-AzVMConfig `
>>   -VMName "vm-skcc-comdpt1" `
>>   -VMSize "Standard_B2s"

PS C:\workspace\AzureBasic\0.ENV> $vmConfig = Set-AzVMOperatingSystem `
>>   -VM $vmConfig `
>>   -Linux `
>>   -ComputerName "vm-skcc-comdpt1" `
>>   -Credential $cred `
>>   -DisablePasswordAuthentication

PS C:\workspace\AzureBasic\0.ENV> $vmConfig = Set-AzVMSourceImage `
>>   -VM $vmConfig `
>>   -PublisherName "Canonical" `
>>   -Offer "UbuntuServer" `
>>   -Skus "18.04-LTS" `
>>   -Version "latest"

PS C:\workspace\AzureBasic\0.ENV> $vmConfig = Add-AzVMNetworkInterface `
>>   -VM $vmConfig `
>>   -Id $nic.Id         

PS C:\workspace\AzureBasic\0.ENV> $sshPublicKey = cat ~/.ssh/id_rsa.pub

PS C:\workspace\AzureBasic\0.ENV> Add-AzVMSshPublicKey `
>>   -VM $vmConfig `
>>   -KeyData $sshPublicKey `
>>   -Path "/home/azureuser/.ssh/authorized_keys"



Name            : vm-skcc-comdpt1
HardwareProfile : {VmSize}
NetworkProfile  : {NetworkInterfaces}
OSProfile       : {ComputerName, AdminUsername, AdminPassword, LinuxConfiguration}
StorageProfile  : {ImageReference}

PS C:\workspace\AzureBasic> $vmName="vm-skcc-comdpt1"

PS C:\workspace\AzureBasic> $resourceGroup = Get-AzResourceGroup -Name 'rg-skcc-homepage-dev'

PS C:\workspace\AzureBasic> $location = $resourceGroup.Location

PS C:\workspace\AzureBasic> $osDiskType = (Get-AzDisk -ResourceGroupName $resourceGroup.ResourceGroupName)[0].Sku.Name

PS C:\workspace\AzureBasic> $osDiskType = "StandardSSD_LRS"

PS C:\workspace\AzureBasic> $osDiskSizeInGB = 64


PS C:\workspace\AzureBasic> $vmConfig = Set-AzVMOSDisk `
>>   -VM $vmConfig `
>>   -Name "$($vmName)-OsDisk01" `
>>   -DiskSizeinGB $osDiskSizeInGB `
>>   -StorageAccountType $osDiskType `
>>   -CreateOption FromImage `
>>   -Caching ReadWrite `
>>   -Linux


PS C:\workspace\AzureBasic\0.ENV> New-AzVM -VM $vmConfig `
>>   -ResourceGroupName "rg-skcc-homepage-dev" `
>>   -Location "koreacentral"

WARNING: Since the VM is created using premium storage or managed disk, existing standard storage account, skccdevhomepagedev, is used for boot diagnostics.

RequestId IsSuccessStatusCode StatusCode ReasonPhrase
--------- ------------------- ---------- ------------
                         True         OK OK

PS C:\workspace\AzureBasic\0.ENV>
```

### Boot Diagostics 경고 없애기 
```
PS C:\workspace\AzureBasic> $vmConfig = Set-AzVMBootDiagnostic `
>>   -VM $vmConfig `
>>   -Enable `
>>   -resourceGroup "rg-skcc-homepage-dev" `
>>   -StorageAccountName "skccdevhomepagedev"

PS C:\workspace\AzureBasic> New-AzVM -VM $vmConfig `
>>   -ResourceGroupName "rg-skcc-homepage-dev" `
>>   -Location "koreacentral"


RequestId IsSuccessStatusCode StatusCode ReasonPhrase
--------- ------------------- ---------- ------------
                         True         OK OK

PS C:\workspace\AzureBasic>
```