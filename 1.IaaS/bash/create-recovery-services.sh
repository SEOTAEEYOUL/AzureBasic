#!/usr/bin/bash

groupName="rg-skcc1-homepage-dev"
locationName="koreacentral"
rsvName="skcc1-rsv-VMbackup-homepage"

echo "1. Recovery Services 자격 증명 모음 생성"
az backup vault create \
  --resource-group $groupName \
  --name $rsvName \
  --location $locationName

echo "2. 스토리지 중복 설정 수정"
az backup vault backup-properties set \
    --name $rsvName  \
    --resource-group $groupName \
    --backup-storage-redundancy "LocallyRedundant"
