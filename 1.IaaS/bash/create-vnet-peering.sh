#!/usr/bin/bash

echo "### 0. 변수 설정"
groupNWName="rg-skcc1-network-dev"
vnetNWName="vnet-network-dev"
groupHomepageName="rg-skcc1-homepage-dev"
vnetHomepageName="vnet-skcc1-dev"
peeringNWHomepageName='vnetpeering-nw-homepage-dev-1'
peeringHomepageNWName='vnetpeering-homepage-nw-dev-1'

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

echo "### 1. 네트워크의 ID를 가져오고 ID를 변수에 저장"
echo "# Get the id for $vnetNWName"
vNet1Id=$(az network vnet show \
  --resource-group $groupNWName \
  --name $vnetNWName \
  --query id \
  --out tsv)

echo "# Get the id for $vnetHomepageName"
vNet2Id=$(az network vnet show \
  --resource-group $groupHomepageName \
  --name $vnetHomepageName \
  --query id \
  --out tsv)

echo "### 2. \"$vnetNWName\" 에서 \"$vnetHomepageName\" 로 피어링을 만듬"
az network vnet peering create \
  --name $peeringNWHomepageName \
  --resource-group $groupNWName \
  --vnet-name $vnetNWName \
  --remote-vnet $vNet2Id \
  --allow-vnet-access
az network vnet peering create \
  --name $peeringHomepageNWName \
  --resource-group $groupHomepageName \
  --vnet-name $vnetHomepageName \
  --remote-vnet $vNet1Id \
  --allow-vnet-access

echo "### 3. peeringState 가 Connected 로 변경되었는지 확인"
az network vnet peering show \
  --name $peeringNWHomepageName \
  --resource-group $groupNWName \
  --vnet-name $vnetNWName \
  --query peeringState

az network vnet peering show \
  --name $peeringHomepageNWName \
  --resource-group $groupHomepageName \
  --vnet-name $vnetHomepageName \
  --query peeringState

echo "### 4. 생성 조회"
az network vnet peering list \
  -o table \
  -g $groupNWName \
  --vnet-name $vnetNWName

az network vnet peering list \
  -o table \
  -g $groupHomepageName \
  --vnet-name $vnetHomepageName
