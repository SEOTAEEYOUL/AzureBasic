#!/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName='koreacentral'
lockName="lock-homepage"
tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

az group create --name "$groupName" \
  --location "$locationName" \
  --tags $tags

az group lock create \
  --lock-type ReadOnly \
  -n $lockName \
  -g $groupName

az group lock delete \
  --name $lockName \
  -g $groupName

groupName="rg-skcc1-network-dev"
az group create --name "$groupName" \
  --location "$locationName" \
  --tags $tags
