$ErrorActionPreference = "Stop"

$userObject = Import-CSV -Path ./vm_parameter_template.csv
$userObject | ForEach-Object {
    
    $subscription = $_.subscription

    Select-AzSubscription $subscription
#####################################변수처리#####################################

#####리소스 그룹#####
    $resourceGroup = $_.rgName 
    $vnetresourceGroup = $_.vnetresourceGroup
    $saresourceGroup = $_.saresourceGroup

    $location = $_.location #지역
    $sku = $_.sku #SKU
    $Zone = $_.Zone #Availability Zone
    $ostype = $_.ostype
    $vmname = $_.vmname #VM이름
    $nicName = $vmname + "-nic01" #네트워크인터페이스 이름

##### 마켓플레이스 이미지 정보 #####
    $imagetype = $_.imagetype
    $PublisherName = $_.PublisherName
    $OfferName = $_.OfferName
    $skus = $_.skus
    $Version = $_.Version

##### VM 접속아이디 및 비번 #####
    $SecurePassword = ConvertTo-SecureString "dlatl!00" -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential ("sysadmin", $SecurePassword); 


##### 네트워크 구성 #####
    $vnetName = $_.vnetName 
    $subnetName = $_.subnetName 
    $privateIp = $_.privateIp 
    #$nicNsgname = $_.nicNsgname 
    
##### 부트진단 이름 #####
    $diagName = $_.diagName 


    $vmOSDisk = $vmname + "-ssd01" #OSDisk 이름
    $vmDataDisk = $vmname + "-ssd02" #DataDisk 이름
    $vmDataDisk2 = $vmname + "-ssd03" #DataDisk 이름
    $osDiskSizeInGB = $_.osDiskSizeInGB
    $osDataDiskSizeInGB = $_.osDataDiskSizeInGB
    $DBDataDiskSizeInGB = $_.DBDataDiskSizeInGB
    $StorageAccountType = $_.StorageAccountType


    $vnet = Get-AzVirtualNetwork -resourceGroup $vnetresourceGroup -Name $vnetName
    $subnetNameConfig = Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet
    #$nicNsg = Get-AzNetworkSecurityGroup -ResourceGroupName $vnetRg -Name $nicNsgname -ErrorAction SilentlyContinue

    ##backupvault
    $backupvault = $_.backupvault


#####################################VM Configuration#####################################

#####네트워크 인터페이스 설정사항#####
    $extnic = Get-AzNetworkInterface `
    -resourceGroup $resourceGroup `
    -Name $nicName -ErrorAction SilentlyContinue
    if ($extnic.Length -eq 0) { 
        New-AzNetworkInterface `
            -resourceGroup $resourceGroup `
            -Name $nicName `
            -Location $location `
            -SubnetId $subnetNameConfig.Id `
            -PrivateIpAddress $privateIp `

        $extnic = Get-AzNetworkInterface `
            -resourceGroup $resourceGroup `
            -Name $nicName
    }

#####가상머신 설정사항#####
    if($ostype -eq "windows"){
        Write-Host "It is windows VM"
        $vmConfig = New-AzVMConfig `
        -VMName $vmName `
        -VMSize $sku `
        -Zone $Zone | Set-AzVMOperatingSystem -Windows `
        -ComputerName $vmName `
        -Credential $Credential `

        if($imagetype -eq "customimage"){
            Write-Host "VM is deployed based on golden image"
            $vmConfig = Set-AzVMSourceImage -VM $vmConfig -Id /subscriptions/cfefd3da-b6d9-443c-9f08-d238a6f76c18/resourceGroups/rg-sksq-lz-shared-prd/providers/Microsoft.Compute/galleries/sksq_lz_prd_image_gallery/images/sksq_common_Winimage/versions/3.0.0
        }
        elseif($imagetype -eq "marketimage"){
            Write-Host "not an golden image"
            $vmConfig = Set-AzVMSourceImage `
                -VM $vmConfig `
                -PublisherName $PublisherName `
                -Offer $OfferName `
                -Skus $skus `
                -Version $Version 
        }
    }
    elseif($ostype -eq "linux"){
        Write-Host "It is Linux VM"
        $vmConfig = New-AzVMConfig `
        -VMName $vmName `
        -VMSize $sku `
        -Zone $Zone | Set-AzVMOperatingSystem -Linux `
        -ComputerName $vmName `
        -Credential $Credential `

        if($imagetype -eq "customimage"){
            Write-Host "VM is deployed based on golden image"
            $vmConfig = Set-AzVMSourceImage -VM $vmConfig -Id /subscriptions/cfefd3da-b6d9-443c-9f08-d238a6f76c18/resourceGroups/rg-sksq-lz-shared-prd/providers/Microsoft.Compute/galleries/sksq_lz_prd_image_gallery/images/sksq_common_RHELimage/versions/1.0.0
        }
        elseif($imagetype -eq "marketimage"){
            Write-Host "not an golden image"
            $vmConfig = Set-AzVMSourceImage `
                -VM $vmConfig `
                -PublisherName $PublisherName `
                -Offer $OfferName `
                -Skus $skus `
                -Version $Version 
        }
    }
        

    $vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $extnic.Id -Primary

 
 

#####가상머신 OS 디스크 설정사항#####
    if($ostype -eq "windows"){
        $vmConfig = Set-AzVMOSDisk `
        -VM $vmConfig `
        -Name $vmOSDisk `
        -DiskSizeInGB $osDiskSizeInGB `
        -CreateOption FromImage `
        -StorageAccountType $StorageAccountType `
        -Caching ReadWrite `
        -Windows
    }
    elseif($ostype -eq "linux"){
        $vmConfig = Set-AzVMOSDisk `
        -VM $vmConfig `
        -Name $vmOSDisk `
        -DiskSizeInGB $osDiskSizeInGB `
        -CreateOption FromImage `
        -StorageAccountType $StorageAccountType `
        -Caching ReadWrite `
        -Linux
    }
    
#####가상머신 Data 디스크 설정사항#####
    if($osDataDiskSizeInGB -eq "null"){
        Write-Host "OS Data disk is empty"
    }
    else{
        $vmConfig = Add-AzVMDataDisk `
        -VM $vmConfig `
        -Name $vmDataDisk `
        -DiskSizeinGB $osDataDiskSizeInGB `
        -CreateOption Empty `
        -StorageAccountType $StorageAccountType `
        -Caching ReadWrite `
        -Lun 1

    }

    if($DBDataDiskSizeInGB -eq "null"){
        Write-Host "DB Data disk is empty"
    }
    else{
        $vmConfig = Add-AzVMDataDisk `
        -VM $vmConfig `
        -Name $vmDataDisk2 `
        -DiskSizeinGB $DBDataDiskSizeInGB `
        -CreateOption Empty `
        -StorageAccountType $StorageAccountType `
        -Caching ReadWrite `
        -Lun 2
    }
    


##### boot diagnotics #####
    $vmConfig = Set-AzVMBootDiagnostic -VM $vmConfig -Enable -resourceGroup $saresourceGroup -StorageAccountName $diagName

##### 가상머신 생성 #####
    New-AzVM -resourceGroup $resourceGroup -Location $location -VM $vmConfig

    if($backupvault -eq "null"){
        Write-Host "backup will not be created"

    }
    else{
        Write-Host "backup will be created"
        $vault = Get-AzRecoveryServicesVault -ResourceGroupName $resourceGroup -Name $backupvault
        Set-AzRecoveryServicesVaultContext -Vault $vault

        $policy = Get-AzRecoveryServicesBackupProtectionPolicy -Name "DefaultPolicy"
    
        Enable-AzRecoveryServicesBackupProtection `
        -ResourceGroupName $resourceGroup `
        -Name $vmname `
        -Policy $policy
    }

}
