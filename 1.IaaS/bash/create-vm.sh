#!/bin/bash

### 환경 설정
groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"
zone=1

vnetName="vnet-skcc1-dev"
vnetAddressPrefix='10.0.0.0/16'

subnetFrontendName='snet-skcc1-dev-frontend'
subnetFronendAddressPrefix='10.0.0.0/28'
subnetBackendName='snet-skcc1-dev-backend'
subnetAddressPrefix='10.0.1.0/28'

storageAccountName='skcc1devhomepagedev'
storageAccountSkuName='Standard_LRS'

nsgName='nsg-skcc1-homepage' 

pipName='pip-skcc1-comdap1'
nicName='nic-skcc1-comdap1'

vmApacheName="vm-skcc1-comdpt1"
vmTomcatName="vm-skcc1-comdap1"
vmName=$vmTomcatName
vmSize="Standard_B2s"

vmOSDisk="${vmName}-OSDisk01"
osDiskType="StandardSSD_LRS"
osDiskSizeInGB=64

vmDataDisk="${vmName}-DataDisk01"
dataDiskSizeInGB=64
dataDiskSku='StandardSSD_LRS'
# $storageAccountName = "skcc1devhomepagedev"  

azName="az-skcc1-homepage-tomcat"
vmssName="vmss-skcc1-homepage-tomcat"

apacheOpenPorts='22,10080'
tomcatOpenPorts='22,18080,8009'

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

## NIC 생성
az network nic create \
  --resource-group $groupName \
  --name $nicName \
  --vnet-name $vnetName \
  --subnet $subnetBackendName \
  --network-security-group $nsgName \
  --tags $tags

az network nic list -o table -g $groupName -o table

## 가용성 집합 민들기
## 장애 도메인 : 서버 + 네트워크 + 스토리지 리소스의 격리된 컬렉션
##              2개의 장애 도메인으로 분산
## 업데이트 도메인 : Azure 소프트웨어 업데이트를 수행할 때 VM 리소스가 격리, 동시에 모든 소프트웨어가 업데이트되지 않도록 함
##                 2개의 업데이트 도메인으로 분산
az vm availability-set create \
  --resource-group $groupName \
  --name $azName \
  --platform-fault-domain-count 2 \
  --platform-update-domain-count 2 \
  --tags $tags

az vm availability-set list \
  --resource-group $groupName \
  -o table

## 가용성 집합에 포함된 VM 만들기
## NIC 를 명시할 경우, NSG, public IP, ASGs, VNet or subnet 를 설정하지 않음
# image : "Publisher:Offer:Sku:Version"
# https://docs.microsoft.com/azure/virtual-machines/linux/cli-ps-findimage
# az vm image list --output table
# - PublisherName "Canonical" `
# - Offer "UbuntuServer" `
# - Skus "18.04-LTS" ` # 22.04-lTS, 20.04-LTS, 18.04-LTS
# - Version "latest"
# The password length must be between 12 and 72. Password must have the 3 of the following: 1 lower case character, 1 upper case character, 1 number and 1 special character.
az vm create \
  --resource-group $groupName \
  --name $vmName \
  --availability-set $azName \
  --image "Canonical:UbuntuServer:18.04-LTS:latest" \
  --size $vmSize \
  --authentication-type 'Password' \
  --admin-username azureuser \
  --admin-password 'dlatl!00Imsi' \
  --os-disk-name $vmOSDisk \
  --os-disk-size-gb $osDiskSizeInGB \
  --nics $nicName \
  --public-ip-address "" \
  --public-ip-sku Standard \
  --tags $tags

## Data Disk 붙이기
az vm disk attach \
    --resource-group $groupName \
    --vm-name $vmName \
    --name $vmDataDisk \
    --size-gb $dataDiskSizeInGB \
    --sku $dataDiskSku \
    --new
