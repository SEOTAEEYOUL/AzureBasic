#!/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"

storageAccountName='skccdevhomepagedev01'
storageAccountSkuName='Standard_LRS'

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

## 해당 구독에 대해 지원되는 지역 검색
az account list-locations \
  --query "[].{Region:name}" \
  --out table

## 생성하기
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
