# 공통 환경 (도구 포함)  

## [git 설치](https://git-scm.com/downloads) 
- [2.34.1](https://git-scm.com/download/win)  

## [PowerShell 설치](https://docs.microsoft.com/ko-kr/powershell/scripting/install/installing-powershell?view=powershell-7.2)
- [Windows에 PowerShell 설치](https://docs.microsoft.com/ko-kr/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.2)
- [PowerShell-7.2.0-win-x64.msi](https://github.com/PowerShell/PowerShell/releases/download/v7.2.0/PowerShell-7.2.0-win-x64.msi)

## [Azure CLI](https://docs.microsoft.com/ko-kr/cli/azure/install-azure-cli)
- Azure CLI(명령줄 인터페이스)는 Azure에 연결하고 Azure 리소스에서 관리 명령을 실행하는 플랫폼 간 명령줄 도구
- Windows 용
  ```
  az account set --subscription "my subscription name"
  az role assignment create --assignee servicePrincipalName --role Reader
  az role assignment delete --assignee userSign-inName --role Contributor
  ```
  - PowerShell 에서 설치
    ```
    $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
    ```

## [JDK 17.0.1](https://jdk.java.net/17/)
- [Windows/x64 - zip](https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_windows-x64_bin.zip)