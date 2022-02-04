#!/usr/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"
rsvName="skcc1-rsv-VMbackup-dev"

vmName='vm-skcc1-comdpt1'

az backup vault create \
  --resource-group $groupName \
  --name $rsvName \
  --location $locationName


az backup vault backup-properties set \
    --name $rsvName  \
    --resource-group $groupName \
    --backup-storage-redundancy "LocallyRedundant"

az backup protection enable-for-vm \
    --resource-group $groupName \
    --vault-name $rsvName \
    --vm $vmName \
    --policy-name DefaultPolicy

# 바로 백업
az backup protection backup-now \
  --resource-group $groupName \
  --vault-name $rsvName \
  --container-name $vmName \
  --item-name $vmName \
  --backup-management-type AzureIaaSVM \
  --retain-until 15-02-2022

# 백업 작업 모니터링
az backup job list \
  --resource-group $groupName \
  --vault-name $rsvName \
  --output table
