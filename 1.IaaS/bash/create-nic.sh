#!/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"

vnetName="vnet-skcc1-dev"
subnetFrontendName='snet-skcc1-dev-frontend'

nsgName='nsg-skcc1-homepage' 

pipName='pip-skcc1-comdpt1'
nicName='nic-skcc1-comdpt1'

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

az network nic create \
  --resource-group $groupName \
  --name $nicName \
  --vnet-name $vnetName \
  --subnet $subnetFrontendName \
  --network-security-group $nsgName \
  --public-ip-address $pipName \
  --tags $tags

az network nic list \
  --resource-group $groupName
