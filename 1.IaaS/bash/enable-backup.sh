#!/usr/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"
rsvName="skcc1-rsv-VMbackup-homepage"

vmNames='vm-skcc1-comdpt1 vm-skcc1-comdap1'

for vmName in $vmNames
do
  echo ". VM[\"$vmName\"] 에 백업 사용 설정"
  az backup protection enable-for-vm \
      --resource-group $groupName \
      --vault-name $rsvName \
      --vm $vmName \
      --policy-name DefaultPolicy

  echo ". VM[\"$vmName\"] 바로 백업"
  az backup protection backup-now \
    --resource-group $groupName \
    --vault-name $rsvName \
    --container-name $vmName \
    --item-name $vmName \
    --backup-management-type AzureIaaSVM \
    --retain-until 15-02-2022
done

echo ". 백업 작업 모니터링"
az backup job list \
  --resource-group $groupName \
  --vault-name $rsvName \
  --output table
