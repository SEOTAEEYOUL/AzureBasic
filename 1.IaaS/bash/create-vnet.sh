#!/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"

vnetName="vnet-skcc1-dev"
vnetAddressPrefix='10.0.0.0/16'

subnetFrontendName='snet-skcc1-dev-frontend'
subnetFrontendAddressPrefix='10.0.0.0/28'
subnetBackendName='snet-skcc1-dev-backend'
subnetBackendAddressPrefix='10.0.1.0/28'

tags='owner=SeoTaeYeol environment=dev serviceTitle=homepage personalInformation=no'

az network vnet create \
  --resource-group $groupName \
  --location $locationName \
  --name $vnetName \
  --address-prefix $vnetAddressPrefix \
  --subnet-name $subnetFrontendName \
  --subnet-prefix $subnetFrontendAddressPrefix \
  --tags $tags

az network vnet subnet create \
  -n $subnetBackendName  \
  --vnet-name $vnetName \
  -g $groupName \
  --address-prefixes $subnetBackendAddressPrefix

groupName="rg-skcc1-network-dev"
vnetName="vnet-network-dev"
vnetAddressPrefix='10.21.0.0/16'

subnetFrontendName='snet-skcc1-network-frontend'
subnetFrontendAddressPrefix='10.21.0.0/28'
subnetBackendName='snet-skcc1-network-backend'
subnetBackendAddressPrefix='10.21.1.0/28'

az network vnet create \
  --resource-group $groupName \
  --location $locationName \
  --name $vnetName \
  --address-prefix $vnetAddressPrefix \
  --subnet-name $subnetFrontendName \
  --subnet-prefix $subnetFrontendAddressPrefix \
  --tags $tags

az network vnet subnet create \
  -n $subnetBackendName  \
  --vnet-name $vnetName \
  -g $groupName \
  --address-prefixes $subnetBackendAddressPrefix
