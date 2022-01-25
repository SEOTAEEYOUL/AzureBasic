# Bastion VM 환경 구성하기

Azure-CLI 설치
``` 
sudo apt-get update
sudo apt-get install azure-cli
```

Docker Engine 설치
```
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo vi /etc/group
docker version
```

Azure CLI 설치 확인 및 로그인
```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login
az account list -o table
```

Helm Chart 설치
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
sudo ./get_helm.sh
helm version
```

Kubectl 설치
```
az aks install-cli
sudo az aks install-cli
kubectl version

az provider register --namespace Microsoft.Network
az provider register --namespace Microsoft.Compute
az extension add --name aks-preview
az extension update --name aks-preview
az provider register --namespace Microsoft.ContainerService
az feature register --name UseCustomizedUbuntuPreview --namespace Microsoft.ContainerService
```

## DISK 추가
### VM 에 새 디스크 연결
```
az vm disk attach \
  -g rg-chatops \
  --vm-name vm-bastion \
  --name disk-vm-bastion-workspace \
  --new \
  --size-gb 50
diskId=$(az disk show -g rg-chatops -n disk-vm-bastion-workspace --query 'id' -o tsv)
az vm disk attach -g rg-chatops --vm-name vm-bastion --name $diskId
```

### 디스크 찾기
```
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
```
```
sda     1:0:1:0       4G
└─sda1                4G /mnt
sdb     0:0:0:0      30G
├─sdb1             29.9G /
├─sdb14               4M
└─sdb15             106M /boot/efi
sdc     3:0:0:0      50G
```

### 디스크 포맷
```
sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sdc1
sudo partprobe /dev/sdc1
```

### 디스크 탑재
```
mkdir workspace
sudo mount /dev/sdc1 /home/azureuser/workspace
sudo chown -R azureuser:azureuser workspacecd
```

### 영구
```
sudo blkid
```
```
/dev/sda1: LABEL="cloudimg-rootfs" UUID="7f90b43a-ea0f-4eb8-81e4-84fb3d78ec61" TYPE="ext4" PARTUUID="ccfb078f-68ac-4bdf-89d4-8b5e6ca63c5a"
/dev/sda15: LABEL="UEFI" UUID="CC90-492E" TYPE="vfat" PARTUUID="9bc9c29c-0201-4258-a3c9-ea0e158e1e7d"
/dev/sdb1: UUID="b410bbeb-48b6-42e5-b2a6-90ef0aae489b" TYPE="xfs" PARTLABEL="xfspart" PARTUUID="3e4eb108-18de-4bec-9b0c-bca51592d036"
/dev/sdc1: UUID="36feaf9d-e1b4-4798-95c0-2f9cf3ee3499" TYPE="ext4" PARTUUID="474d154f-01"
/dev/sda14: PARTUUID="24d52665-4d04-4033-af92-4e6ec4456595
```

```
sudo vi /etc/fstab
UID=b410bbeb-48b6-42e5-b2a6-90ef0aae489b   /home/azureuser/workspace   xfs   defaults,nofail   1   2
```

### /home/azureuser
- 외장 Storage 찾기
```
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
```
```
sda     3:0:0:0      50G
└─sda1               50G /home/azureuser/workspace
sdb     0:0:0:0      30G
├─sdb1             29.9G /
├─sdb14               4M
└─sdb15             106M /boot/efi
sdc     1:0:1:0       4G
└─sdc1                4G /mnt
```
- mount point 변경
```
sudo mount /dev/sda1 /home/azureuser
```
- 변경된 mount point 확인
```
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
```
```
sda     3:0:0:0      50G
└─sda1               50G /home/azureuser
sdb     0:0:0:0      30G
├─sdb1             29.9G /
├─sdb14               4M
└─sdb15             106M /boot/efi
sdc     1:0:1:0       4G
└─sdc1                4G /mnt
```
