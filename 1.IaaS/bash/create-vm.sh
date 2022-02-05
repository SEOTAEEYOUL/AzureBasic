#!/usr/bin/bash

echo "### 환경 설정"
groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"
zone=1

vnetName="vnet-skcc1-dev"
vnetAddressPrefix='10.0.0.0/16'

subnetFrontendName='snet-skcc1-dev-frontend'
subnetFronendAddressPrefix='10.0.0.0/28'
subnetBackendName='snet-skcc1-dev-backend'
subnetAddressPrefix='10.0.1.0/28'

storageAccountName='skcc1devhomepage1'
storageAccountSkuName='Standard_LRS'

nsgName='nsg-skcc1-homepage' 

pipName='pip-skcc1-comdap1'
nicName='nic-skcc1-comdap1'
privateIP='10.0.1.4'

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

avsName="avset-skcc1-homepage"
vmssName="vmss-skcc1-homepage-tomcat"

apacheOpenPorts='22,10080'
tomcatOpenPorts='22,18080,8009'

rsvName="skcc1-rsv-VMbackup-dev"

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

echo "## NIC[$nicName:$privateIP] 생성"
az network nic create \
  --resource-group $groupName \
  --name $nicName \
  --vnet-name $vnetName \
  --subnet $subnetBackendName \
  --network-security-group $nsgName \
  --private-ip-address $privateIP \
  --tags $tags

az network nic list -o table -g $groupName -o table

echo "## 가용성 집합[$avsName] 만들기"
## 장애 도메인 : 서버 + 네트워크 + 스토리지 리소스의 격리된 컬렉션
##              2개의 장애 도메인으로 분산
## 업데이트 도메인 : Azure 소프트웨어 업데이트를 수행할 때 VM 리소스가 격리, 동시에 모든 소프트웨어가 업데이트되지 않도록 함
##                 2개의 업데이트 도메인으로 분산
az vm availability-set create \
  --resource-group $groupName \
  --name $avsName \
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
echo "VM \"$groupName:$vmName\" 생성"
az vm create \
  --resource-group $groupName \
  --name $vmName \
  --availability-set $avsName \
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

for var in {1..10} 
do
  echo "."; sleep 1;
done

while :
do
  echo "Check VM[\"$vmName\"] power status.."
  status=`az vm get-instance-view --name $vmName --resource-group $groupName --query instanceView.statuses[1].displayStatus | tr -d ' ' | tr -d '"'`

  echo "[\"$status\" = \"VMrunning\"]"

  if [ "$status" = "VMrunning" ]
  then
    echo "$status is VM running ..."
    break
  else
    echo "$status is not VM running ..."
  fi
  sleep 1
done

echo "### VM[\"$vmName\":\"$groupName\"] 에 대해서 부팅 진단 사용"
az vm boot-diagnostics enable \
  --name $vmName \
  --resource-group $groupName \
  --storage $storageAccountName

echo "## Data Disk[\"$vmDataDisk\"] 붙이기"
az vm disk attach \
  --resource-group $groupName \
  --vm-name $vmName \
  --name $vmDataDisk \
  --size-gb $dataDiskSizeInGB \
  --sku $dataDiskSku \
  --new

echo "### VM[\"$vmName\":\"$rsvName\"] :: 백업 사용 설정"
az backup protection enable-for-vm \
  --resource-group $groupName \
  --vault-name $rsvName \
  --vm $vmName \
  --policy-name DefaultPolicy

az backup protection enable-for-vm \
  --resource-group $groupName \
  --vault-name $rsvName \
  --vm $(az vm show -g $groupName -n $vmName --query id | tr -d '"') \
  --policy-name DefaultPolicy

echo "### VM[\"$vmName\":\"$rsvName\"] :: 바로 백업 "
az backup protection backup-now \
  --resource-group $groupName \
  --vault-name $rsvName \
  --container-name $vmName \
  --item-name $vmName \
  --backup-management-type AzureIaaSVM \
  --retain-until 15-02-2022

echo "### VM[\"$vmName\":\"$groupName\"] :: Power State 확인하기"
az vm get-instance-view \
  --name $vmName \
  --resource-group $groupName \
  --query instanceView.statuses[1] \
  --output table


