# Azure DevOps 를 통한 자원 배포(IaC - 2)
azure devops 에 저장소 설정 및 Pipeline 을 만들어 배포 하기  

### [Azure DevOps](https://devops.azure.com)
![AzureDevOps-ProjectHome.png](./img/AzureDevOps-ProjectHome.png)
### Project 만들기
"Start Free" > _"+ New project"
![AzureDevOps-NewProject.png](./img/AzureDevOps-NewProject.png)  

### Repos 만들기
자원 생성 코드를 담아둘 저장소를 만듦(Git)  
- 프로젝트명 : Create-VM
#### Files
![AzureDevOps-Create-VM-Files.png](./img/AzureDevOps-Create-VM-Files.png)  

"Clond in VS Code" 선택
1. 작업 디렉토리를 선택 :  \workspace
2. 새 VS Code 로 프로젝트 를 열음 : \workspace\Create-VM
3. README.md 를 만든 후 git 명령을 이용해 저장소에 올림
![AzureDevOps-Create-VM-VSCode.png](./img/AzureDevOps-Create-VM-VSCode.png)  
```powershell
PS C:\workspace\Create-VM> git add *
PS C:\workspace\Create-VM> git commit -m "first commit"
[master (root-commit) ff2b901] first commit
 1 file changed, 3 insertions(+)
 create mode 100644 README.md
PS C:\workspace\Create-VM> git push
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 16 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 291 bytes | 291.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
remote: Analyzing objects... (3/3) (5 ms)
remote: Storing packfile... done (120 ms)
remote: Storing index... done (61 ms)
To https://dev.azure.com/ca07456/Create-VM/_git/Create-VM
 * [new branch]      master -> master
PS C:\workspace\Create-VM> 
```
![AzureDevOps-Create-VM-Files-Readme.png](./img/AzureDevOps-Create-VM-Files-Readme.png)  

### Pipeline 만들기
1. "Create Pipeline" 선택
2. "Azure Repos Git" 선택
3. "Create-VM" 선택
4. Configure your pipeline | "Starter pipeline" 선택
5. "Review your pipeline YAML" | "Show assitant" 클릭 | "Azure PowerShell" 선택
  - 구독 : 
  - Script Type : Inline Script
    ```powershell
    New-AzResourceGroup -Name myResourceGroup -Location 'KoreaCentral'

    New-AzVm `
        -ResourceGroupName 'myResourceGroup' `
        -Name 'myVM' `
        -Location 'KoreaCentral' `
        -VirtualNetworkName 'myVnet' `
        -SubnetName 'mySubnet' `
        -SecurityGroupName 'myNetworkSecurityGroup' `
        -PublicIpAddressName 'myPublicIpAddress' `
        -OpenPorts 80,3389

    Get-AzPublicIpAddress -ResourceGroupName 'myResourceGroup' | Select-Object -Property  'IpAddress'

    Install-WindowsFeature -Name Web-Server -IncludeManagementTools  
    ```

  - Script Arguments : 

6. 
