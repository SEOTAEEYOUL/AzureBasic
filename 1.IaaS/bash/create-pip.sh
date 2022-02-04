#!/usr/bin/bash

groupName="rg-skcc1-homepage-dev"
pipName='pip-skcc1-comdpt1'

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

az network public-ip create \
  --resource-group $groupName \
  --name $pipName \
  --version IPv4 \
  --sku Standard \
  --zone 1 2 3 \
  --tags $tags

az network public-ip list \
  --resource-group $groupName \
  -o table
