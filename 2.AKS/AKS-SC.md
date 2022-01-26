# AKS Storage Class
Azure Files는 Kubernetes 1.13 이상을 실행하는 AKS 클러스터의 프리미엄 스토리지를 지원하며, 프리미엄 파일 공유의 최소 크기는 100GB입니다.



[Azure Disk - Dynamic](https://docs.microsoft.com/ko-kr/azure/aks/azure-disks-dynamic-pv)  
[Azure Files - Dynamic](https://docs.microsoft.com/ko-kr/azure/aks/azure-files-dynamic-pv)  
[Azure NetApp Files](https://docs.microsoft.com/ko-kr/azure/aks/azure-netapp-files)  
[Azure Ultra Disks 사용(previews)](https://docs.microsoft.com/ko-kr/azure/aks/use-ultra-disks)  
[기본 스토리지클래스(StorageClass) 변경하기](https://kubernetes.io/ko/docs/tasks/administer-cluster/change-default-storage-class/)


## 스토리지 클래스
- Standard_LRS - 표준 LRS(로컬 중복 스토리지)
- Standard_GRS - 표준 GRS(지역 중복 스토리지)
- Standard_ZRS - 표준 ZRS(영역 중복 스토리지)
- Standard_RAGRS - 표준 RA-GRS(읽기 액세스 지역 중복 스토리지)
- Premium_LRS - 프리미엄 LRS(로컬 중복 스토리지)
- Premium_ZRS -프리미엄 ZRS (영역 중복 저장소)
- Premium_ZRS - 프리미엄 ZRS (영역 중복 저장소)  

### azure - Storage Class 만들기

#### azure-disk-sc.yaml
```
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: azuredisk
  annotations:
    storageclass.kubernetes.io/is-default-class: "false"
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
    kubernetes.io/cluster-service: "true"
provisioner: kubernetes.io/azure-disk
allowVolumeExpansion: true
reclaimPolicy: Delete
volumeBindingMode: Immediate
parameters:
  kind: managed
  storageaccounttype: Standard_LRS
  # storageaccounttype: StandardSSD_LRS
  cachingmode: ReadOnly
  storageAccount : skchatops001
```
#### azure-file-sc.yaml
```yaml
<<<<<<< HEAD
kkkapiVersion: storage.k8s.io/v1
=======
---
>>>>>>> c085da979cc8f1cc90b54b22071c6a8ecde2884e
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: azurefile
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
    kubernetes.io/cluster-service: "true"
provisioner: kubernetes.io/azure-file
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
mountOptions:
<<<<<<< HEAD
- dir_mode=0777
- file_mode=0777
- uid=0
- gid=0
=======
- dir_mode=0750
- file_mode=0750
- uid=999
- gid=999
>>>>>>> c085da979cc8f1cc90b54b22071c6a8ecde2884e
- mfsymlinks
- cache=strict
# - cache=none
- nobrl
- nosharesock
- actimeo=30
parameters:
  skuName: Standard_LRS
  storageAccount : skchatops001
  # storageAccount : EXISTING_STORAGE_ACCOUNT
  # resourceGroup : EXISTING_RESOURCE_GROUP_NAME
```



### 영구적 볼륨 클레임 만들기

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azurefile
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: azurefile
  resources:
    requests:
      storage: 1Gi
```

## CSI Driver 사용
Kubernetes 버전 1.21 부터 Kubernetes 는 기본적으로 CSI 드라이버만 사용 함 
CSI 드라이버를 지원하는 최소 Kubernetes 부 버전은 v1.17 임 

[Container Storage Interface (CSI)](https://github.com/container-storage-interface/spec/blob/master/spec.md)  
[CSI 스토리지 드라이버 사용(preview)](https://docs.microsoft.com/ko-kr/azure/aks/csi-storage-drivers)  
[Azure Disk CSI 드라이버(preview)](https://docs.microsoft.com/ko-kr/azure/aks/azure-disk-csi)  
[Azure Files CSI 드라이버(preview)](https://docs.microsoft.com/ko-kr/azure/aks/azure-files-csi)  - SMB(서버 메시지 블록) 프로토콜 사용 연결  

### CSI 저장소 드라이버 지원 AKS Cluster 생성
#### AKS Cluster 생성
```
# Create an AKS-managed Azure AD cluster
az aks create -g MyResourceGroup -n MyManagedCluster --network-plugin azure -k 1.17.9 --aks-custom-headers EnableAzureDiskFileCSIDriver=true
```

#### Azure 디스크 기반 볼륨 수 확인
```bash
echo $(kubectl get CSINode <NODE NAME> -o jsonpath="{.spec.drivers[1].allocatable.count}")
```


### CSI Storage Driver
#### azure-file-sc.yaml - Azure Disk CSI 드라이버 사용 버전
```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: azuredisk-csi-waitforfirstconsumer
provisioner: disk.csi.azure.com
parameters:
  skuname: StandardSSD_LRS 
allowVolumeExpansion: true
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```

#### azure-file-sc.yaml - Azure Files CSI 드라이버 사용 버전
```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: my-azurefile
provisioner: file.csi.azure.com
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
mountOptions:
  - dir_mode=0640
  - file_mode=0640
  - uid=0
  - gid=0
  - mfsymlinks
  - cache=strict # https://linux.die.net/man/8/mount.cifs
  - nosharesock
parameters:
  skuName: Standard_LRS
```

## 기본 StorageClass 변경
- 현재 default sc 를 false 변경
```
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
```
- 바꾸고 싶은 sc 를 default 변경
```
kubectl patch storageclass gold -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

## 오류 메시지
- 잘못된 mount 옵션을 설정했을 때 pvc 생성 후 Pod 에서 Mount 할 때 발생
```
Events:
  Type     Reason       Age                From               Message
  ----     ------       ----               ----               -------
  Normal   Scheduled    60s                default-scheduler  Successfully assigned cicd/harbor-database-0 to aks-chatops01-35783885-vmss00000o
  Warning  FailedMount  17s (x7 over 50s)  kubelet            MountVolume.SetUp failed for volume "pvc-fd9e032d-97d7-4ee0-af65-1a2e9556f682" : mount failed: exit status 32
Mounting command: mount
Mounting arguments: -t cifs -o actimeo=30,cache=strict,dir_mode=0750,file_mode=0750,gid=999,mflinks,mfsymlinks,nobrl,nosharesock,uid=999,vers=3.0,<masked> //skchatops001.file.core.windows.net/kubernetes-dynamic-pvc-fd9e032d-97d7-4ee0-af65-1a2e9556f682 /var/lib/kubelet/pods/25ed95cb-04de-482d-b0c4-d02fe9ee59f4/volumes/kubernetes.io~azure-file/pvc-fd9e032d-97d7-4ee0-af65-1a2e9556f682
Output: mount error(22): Invalid argument
Refer to the mount.cifs(8) manual page (e.g. man mount.cifs)
```