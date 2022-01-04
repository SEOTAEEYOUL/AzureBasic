

New-AzVm `
-ResourceGroupName "myResourceGroup" `
-Name "myVM" `
-Location "East US" `
-VirtualNetworkName "myVnet" `
-SubnetName "mySubnet" `
-SecurityGroupName "myNetworkSecurityGroup" `
-PublicIpAddressName "myPublicIpAddress" `
-OpenPorts 80,3389