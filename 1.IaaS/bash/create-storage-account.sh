#!/usr/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"

storageAccountName='skcc1devhomepage1'
storageAccountSkuName='Standard_LRS'

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

echo "## 해당 구독에 대해 지원되는 지역 검색"
az account list-locations \
  --query "[].{Region:name}" \
  --out table

echo "## 생성하기"
az storage account create \
  --name $storageAccountName \
  --resource-group $groupName \
  --location $locationName \
  --sku $storageAccountSkuName \
  --kind StorageV2 \
  --tag $tags

## 삭제하기
# az storage account delete \
#   --name $storageAccountName \
#   --resource-group $groupName

echo "## 스토리지 어카운트 보기"
az storage account list \
  --resource-group $groupName \
  -o table
