#!/bin/bash

## 기존 설정
groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"

vnetName="vnet-skcc1-dev"

nsgName='nsg-skcc1-homepage' 

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

az network nsg create \
  -g $groupName \
  -n $nsgName \
  --tags $tags

az network nsg rule create \
  -g $groupName \
  -n "nsg-rule-ssh"  \
  --priority 1000 \
  --nsg-name $nsgName \
  --protocol "Tcp" \
  --direction "Inbound" \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 22 \
  --access "Allow"
  
az network nsg rule create \
  --name "nsg-rule-www"  \
  --resource-group $groupName \
  --nsg-name $nsgName \
  --protocol "Tcp" \
  --direction "Inbound" \
  --priority 1001 \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 10080 \
  --access "Allow"

az network nsg rule create \
  --name "nsg-rule-tomcat"  \
  --nsg-name $nsgName \
  --resource-group $groupName \
  --protocol "Tcp" \
  --direction "Inbound" \
  --priority 1002 \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 18080 \
  --access "Allow"

## NSG 목록 보기
az network nsg list -o table -g $groupName 

## NSG rule 보기
az network nsg rule list -o table -g $groupName --nsg-name $nsgName
