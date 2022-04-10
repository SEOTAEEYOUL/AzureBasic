# Azure Storage Account

> [빠른 시작: PowerShell을 사용하여 Blob 업로드, 다운로드 및 나열](https://docs.microsoft.com/ko-kr/azure/storage/blobs/storage-quickstart-blobs-powershell)  
> [빠른 시작: Azure Storage Explorer를 사용하여 Blob 만들기](https://docs.microsoft.com/ko-kr/azure/storage/blobs/quickstart-storage-explorer)  
> [Azure Storage Explorer](https://azure.microsoft.com/ko-kr/features/storage-explorer/#overview)  
> [AzCopy 시작](https://docs.microsoft.com/ko-kr/azure/storage/common/storage-use-azcopy-v10)
> [AzCopy Windows 64비트](https://aka.ms/downloadazcopy-v10-windows)  
> [AzCopy를 사용하여 Azure Blob Storage에 파일 업로드](https://docs.microsoft.com/ko-kr/azure/storage/common/storage-use-azcopy-blobs-upload)  
> [AzCopy를 사용하여 Azure Blob Storage에서 Blob 다운로드](https://docs.microsoft.com/ko-kr/azure/storage/common/storage-use-azcopy-blobs-download)  

## Storage 계정 유형
| 스토리지 계정의 유형 | 지원되는 스토리지 서비스 | 중복 옵션 | 사용 |   
|:---|:---|:---|:---|  
| 표준 범용 v2 | Blob(Data Lake Storage 포함) </br> 큐 및 Table Storage </br> Azure Files | LRS/GRS/RA-GRS </br> ZRS/GZRS/RA-GZRS2 | Blob, 파일 공유, 큐 및 테이블 </br> Azure Files NFS 파일 공유에 대한 지원을 원하는 경우 프리미엄 파일 공유 계정 유형을 사용 | 
| 프리미엄 블록 Blob | Blob 스토리지(Data Lake Storage 포함) | LRS </br> ZRS2 | 블록 Blob 및 추가 Blob </br> 트랜잭션 속도가 높은 시나리오 또는 더 작은 개체를 사용하거나 지속적으로 짧은 스토리지 대기 시간이 필요한 경우 |  
| 프리미엄 파일 공유 | Azure 파일 | LRS </br> ZRS2 | 파일 공유 전용 프리미엄 스토리지 계정 유형 </br> 엔터프라이즈 또는 고성능 규모의 애플리케이션에 추천 </br> SMB 및 NFS 파일 공유를 모두 지원하는 스토리지 계정을 원하는 경우 |  
| 프리미엄 페이지 Blob | 페이지 Blob만 해당 | LRS | 페이지 Blob에 대한 프리미엄 스토리지 계정 유형 |  

### Azure Blob 종류
| 구분 | 특징 | 사용예 |  
|:---|:---|:---|  
| 블록 Blob | 블록으로 구성되며 텍스트 또는 이진 파일을 저장 | 큰 파일을 효율적으로 업로드하는 데 적합 |    
| 추가 Blob | 블록으로 구성 </br> 추가 작업에 최적화 | 로깅 시나리오에 적합 |  
| 페이지 Blob | 전체 크기는 512바이트 페이지(최대 8TB)로 구성 </br> 빈번한 임의의 읽기/쓰기 작업에 맞게 고안 </br> Azure IaaS 디스크의 기반 | 가상 머신과 데이터베이스의 OS 및 데이터 디스크와 같은 인덱스 기반 및 스파스 데이터 구조를 저장하는 데 적합 |    

## Storage 계정 endpoint
| 스토리지 서비스 | endpoint |  
|:---|:---|  
| Blob Storage | https://<storage-account>.blob.core.windows.net |  
| Data Lake Storage Gen2 | https://<storage-account>.dfs.core.windows.net |  
| Azure 파일 | https://<storage-account>.file.core.windows.net |  
| Queue Storage | https://<storage-account>.queue.core.windows.net |  
| Table Storage | https://<storage-account>.table.core.windows.net |  


## Storage Account 설정
- Name : "skccdevhomepagedev"
- SKU : "Standard_LRS" (가장 저렴한 중복성 옵션) # Standard_RAGRS
- 생성시 시간이 1 ~ 2 분 걸림
- 이름이 구독내에서 유일해야 함(범위 추가 확인 필요)
- Azure Storage 방화벽 정책 확인 필요
> [Azure Storage 방화벽 및 가상 네트워크 구성](https://docs.microsoft.com/ko-kr/azure/storage/common/storage-network-security?tabs=azure-powershell)

## Portal
"스토리지 계정" > "+ 만들기"
![StorageAccount+만들기.png](./img/StorageAccount+만들기.png)  
![StorageAccount-만들기.png](./img/StorageAccount-만들기.png)  


## [PowerShell](https://shell.azure.com)
<a href="https://shell.azure.com">
  <img class="cloudshell" src=./img/hdi-launch-cloud-shell.png>
</a>


### 기능등록
```
Install-Module Az.Storage -Repository PsGallery -RequiredVersion 3.0.1-preview -AllowClobber -AllowPrerelease -Force

Register-AzProviderFeature -ProviderNamespace Microsoft.Network -FeatureName AllowGlobalTagsForStorage
Get-AzProviderFeature -ProviderNamespace Microsoft.Network -FeatureName AllowGlobalTagsForStorage
```
### Stroage Account 만들기
```powershell
$groupName='rg-skcc7-homepage-dev'
$locationName='koreacentral'

$storageAccountName = 'skcc1devhomepagedev01'
$storageAccountSkuName ='Standard_LRS'

$tags = @{
  owner='SeoTaeYeol'
  environment='dev'
  serviceTitle='homepage'
  personalInformation='no'
}
```

```powershell
## login 하기
Connect-AzAccount

New-AzStorageAccount `
   -ResourceGroupName $groupName `
   -Name $storageAccountName `
   -Location $locationName `
   -SkuName $storageAccountSkuName `
   -AllowBlobPublicAccess $true `
   -Kind StorageV2 `
   -Tag $tags
```
```
PS D:\workspace\AzureBasic> New-AzStorageAccount `
>>    -ResourceGroupName $groupName `
>>    -Name $storageAccountName `
>>    -Location $locationName `
>>    -SkuName $storageAccountSkuName `
>>    -AllowBlobPublicAccess $false `
>>    -Kind StorageV2 `
>>    -Tag $tags

StorageAccountName    ResourceGroupName     PrimaryLocation SkuName      Kind      AccessTier CreationTime            ProvisioningState EnableHttpsTrafficOnly LargeFileShares
------------------    -----------------     --------------- -------      ----      ---------- ------------            ----------------- ---------------------- ---------------
skcc1devhomepagedev01 rg-skcc7-homepage-dev koreacentral    Standard_LRS StorageV2 Hot        2022-04-10 오후 1:35:56 Succeeded         True

PS D:\workspace\AzureBasic>
```

```powershell
$storageAccountHT = @{
    Name = $storageAccountName
    ResourceGroupName = $groupName
    Location = $locationName
    SkuName = $storageAccountSkuName
    Kind = 'StorageV2'
    # AllowBlobPublicAccess = $true
    Tag = $tags
}
$storageAccount = New-AzStorageAccount @storageAccountHT
$context = $storageAccount.Context
```

![skccdevhomepagedev.png](./img/skccdevhomepagedev.png)
### 컨테이너 만들기(예시)
```powershell
# Create variables
$containerName  = "individual-container"
$prefixName     = "loop"

# Approach 1: Create a container
New-AzStorageContainer -Name $containerName -Context $context

# Approach 2: Create containers with a PowerShell loop
for ($i = 1; $i -le 3; $i++) { 
    New-AzStorageContainer -Name (-join($prefixName, $i)) -Context $ctx -Permission Blob
} 

# Approach 3: Create containers using the PowerShell Split method
"$($prefixName)4 $($prefixName)5 $($prefixName)6".split() | New-AzStorageContainer -Context $context
```

- 파일의 공용 액세스를 허용하도록 권한을 blob으로 설정 생성
```
$containerName = 'quickstartblobs'
New-AzStorageContainer `
  -Name $containerName `
  -Context $context -Permission Blob
```

### 컨테이너 및 Blob에 대한 익명 퍼블릭 읽기 권한 구성
```powershell
# Read the AllowBlobPublicAccess property for the newly created storage account.
(Get-AzStorageAccount `
  -ResourceGroupName $groupName `
  -Name $storageAccountName).AllowBlobPublicAccess

# Set AllowBlobPublicAccess set to false
Set-AzStorageAccount `
  -ResourceGroupName $groupName `
  -Name $storageAccountName `
  -AllowBlobPublicAccess $true

# Read the AllowBlobPublicAccess property.
(Get-AzStorageAccount `
  -ResourceGroupName $groupName `
  -Name $storageAccountName).AllowBlobPublicAccess
```

### 컨테이너에 대한 퍼블릭 액세스 수준 설정
```powershell

```

### Blob Hot,Cool,Archive
| 구분 | 설명 | |
|:---|:---|:---|
| Hot | 자주 액세스하거나 수정하는 데이터를 저장 | 스토리지 비용이 가장 높지만 액세스 비용은 가장 낮음 |
| Cool | 자주 액세스하거나 수정하지 않는 데이터를 저장  | 최소 30일 동안 저장 |
| Archive | 거의 액세스하지 않고 요구되는 대기 시간(시간 기준)이 유연한 데이터를 저장하는 데 최적화된 오프라인 계층 | 최소 180일 동안 저장 |

### 컨테이너에 Blob 업로드
```
# upload a file to the default account (inferred) access tier
$Blob1HT = @{
  File             = 'D:\icon\mariadb_logo_1.png'
  Container        = $containerName
  Blob             = "icon\mariadb_logo_1.png"
  Context          = $context
  StandardBlobTier = 'Hot'
}
Set-AzStorageBlobContent @Blob1HT
  
# upload another file to the Cool access tier
$Blob2HT = @{
File             = 'D:\icon\Mysql_logo.png'
Container        = $containerName
Blob             = 'icon\Mysql_logo.png'
Context          = $context
StandardBlobTier = 'Cool'
}
Set-AzStorageBlobContent @Blob2HT
  
# upload a file to a folder to the Archive access tier
$Blob3HT = @{
  File             = 'D:\Downloads\OculusSetup.exe'
  Container        = $containerName
  Blob             = "Downloads\OculusSetup.exe"
  Context          = $context
  # StandardBlobTier = 'Archive'
  StandardBlobTier = 'Hot'
}
Set-AzStorageBlobContent @Blob3HT

# upload a file to a folder to the Archive access tier
$Blob4HT = @{
  File             = 'D:\Downloads\StorageExplorer.exe'
  Container        = $containerName
  Blob             = "Downloads\StorageExplorer.exe"
  Context          = $context
  StandardBlobTier = 'Archive'
  # StandardBlobTier = 'Hot'
}
Set-AzStorageBlobContent @Blob4HT

# upload a file to a folder to the Archive access tier
$Blob5HT = @{
  File             = 'D:\Downloads\azcopy_windows_amd64_10.14.1.zip'
  Container        = $containerName
  Blob             = "Downloads\azcopy_windows_amd64_10.14.1.zip"
  Context          = $context
  # StandardBlobTier = 'Archive'
  StandardBlobTier = 'Cool'
}
Set-AzStorageBlobContent @Blob5HT
```

#### Container 의 Blob 나열하기
```
Get-AzStorageBlob `
  -Container $containerName `
  -Context $context | Select-Object -Property Name
```
```
PS D:\workspace\AzureBasic> Get-AzStorageBlob `
>>   -Container $containerName `
>>   -Context $context | Select-Object -Property Name

Name
----
Downloads/OculusSetup.exe
Downloads/StorageExplorer.exe
Downloads/azcopy_windows_amd64_10.14.1.zip
icon/Mysql_logo.png
icon/mariadb_logo_1.png

PS D:\workspace\AzureBasic>
```

### Blob 다운로드
#### accesskey 설정(? - 내가 생성한 경우는 안해줘도 됨)
```
$accessKey='/9mLe3DkzOx7ugtKEREJ4X8KVH41kqCdLGh7ZYoj6F4SK/nRpgKuJeQMglACbWVmfHPYdBwhz5ze1dSZ/KMI/g=='

$context = New-AzureStorageContext `
  -StorageAccountName $storageAccountName `
  -StorageAccountKey $accesskey
```

#### download
```
$blobName = 'Downloads\azcopy_windows_amd64_10.14.1.zip'
# Get-AzureStorageBlob `
#   -Blob yourblobname `
#   -Container $containerName `
#   -Context $context

# Download first blob
$blobName = 'icon\mariadb_logo_1.png'
$DLBlob1HT = @{
  Blob        = $blobName
  Container   = $containerName
  Destination = 'D:\Temp\Download\'
  Context     = $context
}
Get-AzStorageBlobContent @DLBlob1HT

# Download another blob
$blobName = 'Downloads\OculusSetup.exe'
$DLBlob2HT = @{
  Blob        = $blobName
  Container   = $containerName
  Destination = 'D:\Temp\Download\'
  Context     = $context  
}
Get-AzStorageBlobContent @DLBlob2HT

# Download the other blob
## archive 는 down이 안됨(오류 발생)
$blobName = 'Downloads\StorageExplorer.exe'
$DLBlob3HT = @{
  Blob        = $blobName
  Container   = $containerName
  Destination = 'D:\Temp\Download\'
  Context     = $context  
}
Get-AzStorageBlobContent @DLBlob3HT
```

#### AzCopy 를 사용한 데이터 전송
```
azcopy login

# 올리기
$env:AZCOPY_CRED_TYPE = "Anonymous";
./azcopy.exe copy "https://skcc1devhomepagedev01.blob.core.windows.net/quickstartblobs/flac/01%20-%20%EA%B1%B0%EA%BE%B8%EB%A1%9C%20%EA%B0%95%EC%9D%84%20%EA%B1%B0%EC%8A%AC%EB%9F%AC%20%EC%98%A4%EB%A5%B4%EB%8A%94%20%EC%A0%80%20%ED%9E%98%EC%B0%AC%20%EC%97%B0%EC%96%B4%EB%93%A4%EC%B2%98%EB%9F%BC.flac?sv=2020-10-02&se=2022-05-10T15%3A39%3A32Z&sr=c&sp=rl&sig=Bhao5ibqZZK%2B%2Fc0U0kwRTKt1%2FHPx%2B%2F9eLnhFjrvMfzM%3D" "D:\Temp\Download\01 - 거꾸로 강을 거슬러 오르는 저 힘찬 연어들처럼.flac" --overwrite=prompt --check-md5 FailIfDifferent --from-to=BlobLocal --recursive --log-level=INFO;
$env:AZCOPY_CRED_TYPE = "";




# 내리기
$env:AZCOPY_CRED_TYPE = "Anonymous";
./azcopy.exe copy "D:\Users\taeey\음악\K-Pop\01 - 거꾸로 강을 거슬러 오르는 저 힘찬 연어들처럼.flac" "https://skcc1devhomepagedev01.blob.core.windows.net/quickstartblobs/flac/01%20-%20%EA%B1%B0%EA%BE%B8%EB%A1%9C%20%EA%B0%95%EC%9D%84%20%EA%B1%B0%EC%8A%AC%EB%9F%AC%20%EC%98%A4%EB%A5%B4%EB%8A%94%20%EC%A0%80%20%ED%9E%98%EC%B0%AC%20%EC%97%B0%EC%96%B4%EB%93%A4%EC%B2%98%EB%9F%BC.flac?sv=2020-10-02&se=2022-05-10T15%3A38%3A29Z&sr=c&sp=rwl&sig=c6MxaXwdGxkyamL4REaNWJGjrdC18%2FRqkmDDJWy97gc%3D" --overwrite=prompt --from-to=LocalBlob --blob-type Detect --follow-symlinks --put-md5 --follow-symlinks --disable-auto-decoding=false --recursive --log-level=INFO;
$env:AZCOPY_CRED_TYPE = "";

```

### Storage Explorer
![StorageExplorer.png](./img/StorageExplorer.png)

- boot diagnostics 컨테이너  
![skccdevhomepagedev-diagnostics.png](./img/skccdevhomepagedev-diagnostics.png)

### 제거
```
Remove-AzStorageAccount `
  -Name $storageAccountName `
  -ResourceGroupName $groupName
```

## Azure CLI
```
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
az storage account delete \
  --name $storageAccountName \
  --resource-group $groupName
```
