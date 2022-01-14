# Home Page

## 계정 조회
```
PS D:\workspace\AzureBasic> az account list -o table
Name                   CloudName    SubscriptionId                        State    IsDefault
---------------------  -----------  ------------------------------------  -------  -----------
SK Square-Dev          AzureCloud   d9bc4c6a-bb13-4ec6-9ad1-6361d443ee7e  Enabled  False
SK Square-Prd          AzureCloud   afa6d7c8-61ad-4faa-9809-022a344d120f  Enabled  True
SK Square-LandingZone  AzureCloud   cfefd3da-b6d9-443c-9f08-d238a6f76c18  Enabled  False
종량제                 AzureCloud   23156b24-6d2e-428f-8f9b-c69dcc8f7a9d  Enabled  False
SK Square-Test         AzureCloud   ad86c393-a0e5-4b09-9648-3d732b1f85f7  Enabled  False
Azure Pass - 스폰서쉽  AzureCloud   0aa01477-9ad1-4549-bacf-eac6035fa242  Enabled  False
Azure subscription 1   AzureCloud   9ebb0d63-8327-402a-bdd4-e222b01329a1  Enabled  False
```

## 그룹 조회
```
PS D:\workspace\AzureBasic> az group list -o table
Name                               Location       Status
---------------------------------  -------------  ---------
cloud-shell-storage-southeastasia  southeastasia  Succeeded
rg-sksq-network-prd                koreacentral   Succeeded
rg-sksq-intranet-prd               koreacentral   Succeeded
NetworkWatcherRG                   koreacentral   Succeeded
rg-sksq-shared-prd                 koreacentral   Succeeded
rg-sksq-erp-prd                    koreacentral   Succeeded
rg-sksq-homepage-prd               koreacentral   Succeeded
rg-sksq-security-prd               koreacentral   Succeeded
AzureBackupRG_koreacentral_1       koreacentral   Succeeded
PS D:\workspace\AzureBasic>
```

## VNet 조회

## subnet 조회

## nic 조회

## disk 조회

## VM 조회