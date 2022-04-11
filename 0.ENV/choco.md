# [Chocolatey](https://docs.chocolatey.org/en-us/choco/setup)
- 윈도우즈 전용 패키지 매니저

## 설치
### Install wid cmd.exe
```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

### Install with PowerShell.exe
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## Upgrade
```
choco upgrade chocolatey
```
```
PS C:\workspace\A-TCL-ChatOps> choco upgrade choco
Chocolatey v0.10.15
Chocolatey detected you are not running from an elevated command shell
 (cmd/powershell).

 You may experience errors - many functions/packages
 require admin rights. Only advanced users should run choco w/out an
 elevated shell. When you open the command shell, you should ensure
 that you do so with "Run as Administrator" selected. If you are
 attempting to use Chocolatey in a non-administrator setting, you
 must select a different location other than the default install
 location. See
 https://chocolatey.org/install#non-administrative-install for details.


 Do you want to continue?([Y]es/[N]o): Y

Upgrading the following packages:
choco
By upgrading you accept licenses for the packages.
choco is not installed. Installing...
choco not installed. The package was not found with the source(s) listed.
 Source(s): 'https://chocolatey.org/api/v2/'
 NOTE: When you specify explicit sources, it overrides default sources.
If the package version is a prerelease and you didn't specify `--pre`,
 the package may not be found.
Please see https://chocolatey.org/docs/troubleshooting for more
 assistance.

Chocolatey upgraded 0/1 packages. 1 packages failed.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Failures
 - choco - choco not installed. The package was not found with the source(s) listed.
 Source(s): 'https://chocolatey.org/api/v2/'
 NOTE: When you specify explicit sources, it overrides default sources.
If the package version is a prerelease and you didn't specify `--pre`,
 the package may not be found.
Please see https://chocolatey.org/docs/troubleshooting for more
 assistance.
PS C:\workspace\A-TCL-ChatOps> 
```

## 일반 패키지 설치(git, base64, curl, wget, jq, sed, awk, grep, openssl 등)
```
PS C:\workspace\A-TCL-ChatOps> choco install base64
Chocolatey v0.10.15
Chocolatey detected you are not running from an elevated command shell
 (cmd/powershell).

 You may experience errors - many functions/packages
 require admin rights. Only advanced users should run choco w/out an
 elevated shell. When you open the command shell, you should ensure 
 that you do so with "Run as Administrator" selected. If you are 
 attempting to use Chocolatey in a non-administrator setting, you
 must select a different location other than the default install
 location. See 
 https://chocolatey.org/install#non-administrative-install for details.


 Do you want to continue?([Y]es/[N]o): Y

Installing the following packages:
base64
By installing you accept licenses for the packages.
Progress: Downloading base64 1.0.0... 100%

base64 v1.0.0 [Approved]
base64 package files install completed. Performing other installation steps.
The package base64 wants to run 'chocolateyinstall.ps1'.
Note: If you don't run this script, the installation will fail.
Note: To confirm automatically next time, use '-y' or consider:
choco feature enable -n allowGlobalConfirmation
Do you want to run the script?([Y]es/[A]ll - yes to all/[N]o/[P]rint): Y

WARNING: Url has SSL/TLS available, switching to HTTPS for download
Downloading base64 
  from 'https://www.rtner.de/software/base64.exe'
Progress: 100% - Completed download of C:\ProgramData\chocolatey\lib\base64\tools\base64.exe (35.5 KB).
Download of base64.exe (35.5 KB) completed.
Hashes match.
C:\ProgramData\chocolatey\lib\base64\tools\base64.exe
 ShimGen has successfully created a shim for base64.exe
 The install of base64 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey installed 1/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
PS C:\workspace\A-TCL-ChatOps> echo -n "mysql" | base64   
bXlzcWwNCg==
PS C:\workspace\A-TCL-ChatOps> echo -n "root" | base64  
PS C:\workspace\A-TCL-ChatOps> echo -n "passwd" | base64 
cGFzc3dkDQo=
PS C:\workspace\A-TCL-ChatOps> 
```
```
PS C:\workspace\KubernetesAdmin> choco install -y openssl
Chocolatey v0.10.15
Chocolatey detected you are not running from an elevated command shell
 (cmd/powershell).

 You may experience errors - many functions/packages
 require admin rights. Only advanced users should run choco w/out an
 elevated shell. When you open the command shell, you should ensure
 that you do so with "Run as Administrator" selected. If you are
 attempting to use Chocolatey in a non-administrator setting, you
 must select a different location other than the default install
 location. See
 https://chocolatey.org/install#non-administrative-install for details.

For the question below, you have 20 seconds to make a selection.

 Do you want to continue?([Y]es/[N]o): Y

Installing the following packages:
openssl
By installing you accept licenses for the packages.
Progress: Downloading vcredist2015 14.0.24215.20170201... 100%
Progress: Downloading vcredist140 14.29.30133... 100%
Progress: Downloading chocolatey-core.extension 1.3.5.1... 100%
Progress: Downloading KB3033929 1.0.5... 100%
Progress: Downloading chocolatey-windowsupdate.extension 1.0.4... 100%
Progress: Downloading KB3035131 1.0.3... 100%
Progress: Downloading KB2919355 1.0.20160915... 100%
Progress: Downloading KB2919442 1.0.20160915... 100%
Progress: Downloading KB2999226 1.0.20181019... 100%
Progress: Downloading openssl 1.1.1.1100... 100%

chocolatey-core.extension v1.3.5.1 [Approved]
chocolatey-core.extension package files install completed. Performing other installation steps.
 Installed/updated chocolatey-core extensions.
 The install of chocolatey-core.extension was successful.
  Software installed to 'C:\ProgramData\chocolatey\extensions\chocolatey-core'

chocolatey-windowsupdate.extension v1.0.4 [Approved]
chocolatey-windowsupdate.extension package files install completed. Performing other installation steps.
 Installed/updated chocolatey-windowsupdate extensions.
 The install of chocolatey-windowsupdate.extension was successful.
  Software installed to 'C:\ProgramData\chocolatey\extensions\chocolatey-windowsupdate'

KB3035131 v1.0.3 [Approved]
kb3035131 package files install completed. Performing other installation steps.
Skipping installation because update KB3035131 does not apply to this operating system (Microsoft Windows 11 Home).
 The install of kb3035131 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB3033929 v1.0.5 [Approved]
kb3033929 package files install completed. Performing other installation steps.
Skipping installation because update KB3033929 does not apply to this operating system (Microsoft Windows 11 Home).
 The install of kb3033929 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2919442 v1.0.20160915 [Approved]
kb2919442 package files install completed. Performing other installation steps.
Skipping installation because this hotfix only applies to Windows 8.1 and Windows Server 2012 R2.
 The install of kb2919442 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2919355 v1.0.20160915 [Approved]
kb2919355 package files install completed. Performing other installation steps.
Skipping installation because this hotfix only applies to Windows 8.1 and Windows Server 2012 R2.
 The install of kb2919355 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2999226 v1.0.20181019 [Approved] - Possibly broken
kb2999226 package files install completed. Performing other installation steps.
Skipping installation because update KB2999226 does not apply to this operating system (Microsoft Windows 11 Home).
 The install of kb2999226 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

vcredist140 v14.29.30133 [Approved]
vcredist140 package files install completed. Performing other installation steps.
Downloading vcredist140-x86 
  from 'https://download.visualstudio.microsoft.com/download/pr/221ed2ae-1269-497b-a962-e113045001fa/1ACD8D5EA1CDC3EB2EB4C87BE3AB28722D0825C15449E5C9CEEF95D897DE52FA/VC_redist.x86.exe'
Progress: 100% - Completed download of C:\Users\taeey\AppData\Local\Temp\chocolatey\vcredist140\14.29.30133\VC_redist.x86.exe (13.14 MB).
Download of VC_redist.x86.exe (13.14 MB) completed.
Hashes match.
Installing vcredist140-x86...
```

### Windows 용 bind 도구(dig, nslookup 등)
```
choco install bind-toolsonly
```
```
choco install bind-toolsonly
Chocolatey v0.11.3
Installing the following packages:
bind-toolsonly
By installing, you accept licenses for the packages.
Progress: Downloading vcredist2012 11.0.61031... 100%
Progress: Downloading bind-toolsonly 9.14.2... 100%

vcredist2012 v11.0.61031 [Approved]
vcredist2012 package files install completed. Performing other installation steps.
The package vcredist2012 wants to run 'chocolateyInstall.ps1'.
Note: If you don't run this script, the installation will fail.
Note: To confirm automatically next time, use '-y' or consider:
choco feature enable -n allowGlobalConfirmation
Do you want to run the script?([Y]es/[A]ll - yes to all/[N]o/[P]rint): A

WARNING: Url has SSL/TLS available, switching to HTTPS for download
Downloading vcredist2012 64 bit
  from 'https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe'
Progress: 100% - Completed download of C:\Users\taeey\AppData\Local\Temp\chocolatey\vcredist2012\11.0.61031\vcredist_x64.exe (6.85 MB).
Download of vcredist_x64.exe (6.85 MB) completed.
Hashes match.
Installing vcredist2012...
vcredist2012 has been installed.
WARNING: Url has SSL/TLS available, switching to HTTPS for download
Downloading vcredist2012
  from 'https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe'
Progress: 100% - Completed download of C:\Users\taeey\AppData\Local\Temp\chocolatey\vcredist2012\11.0.61031\vcredist_x86.exe (6.25 MB).
Download of vcredist_x86.exe (6.25 MB) completed.
Hashes match.
Installing vcredist2012...
vcredist2012 has been installed.
  vcredist2012 can be automatically uninstalled.
 The install of vcredist2012 was successful.
  Software installed as 'EXE', install location is likely default.

bind-toolsonly v9.14.2 [Approved]
bind-toolsonly package files install completed. Performing other installation steps.
Downloading bind 64 bit
  from 'https://downloads.isc.org/isc/bind9/9.14.2/BIND9.14.2.x64.zip'
Progress: 100% - Completed download of C:\Users\taeey\AppData\Local\Temp\chocolatey\bind-toolsonly\9.14.2\BIND9.14.2.x64.zip (20.47 MB).
Download of BIND9.14.2.x64.zip (20.47 MB) completed.
Hashes match.
Extracting C:\Users\taeey\AppData\Local\Temp\chocolatey\bind-toolsonly\9.14.2\BIND9.14.2.x64.zip to C:\ProgramData\chocolatey\lib\bind-toolsonly\content...
C:\ProgramData\chocolatey\lib\bind-toolsonly\content
 ShimGen has successfully created a shim for arpaname.exe
 ShimGen has successfully created a shim for delv.exe
 ShimGen has successfully created a shim for dig.exe
 ShimGen has successfully created a shim for host.exe
 ShimGen has successfully created a shim for nslookup.exe
 ShimGen has successfully created a shim for nsupdate.exe
 The install of bind-toolsonly was successful.
  Software installed to 'C:\ProgramData\chocolatey\lib\bind-toolsonly\content'

Chocolatey installed 2/2 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Did you know the proceeds of Pro (and some proceeds from other
 licensed editions) go into bettering the community infrastructure?
 Your support ensures an active community, keeps Chocolatey tip-top,
 plus it nets you some awesome features!
 https://chocolatey.org/compare
```
```
PS > dig

; <<>> DiG 9.14.2 <<>>
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 11671
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 13, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;.                              IN      NS

;; ANSWER SECTION:
.                       40112   IN      NS      m.root-servers.net.
.                       40112   IN      NS      b.root-servers.net.
.                       40112   IN      NS      c.root-servers.net.
.                       40112   IN      NS      d.root-servers.net.
.                       40112   IN      NS      e.root-servers.net.
.                       40112   IN      NS      f.root-servers.net.
.                       40112   IN      NS      g.root-servers.net.
.                       40112   IN      NS      h.root-servers.net.
.                       40112   IN      NS      a.root-servers.net.
.                       40112   IN      NS      i.root-servers.net.
.                       40112   IN      NS      j.root-servers.net.
.                       40112   IN      NS      k.root-servers.net.
.                       40112   IN      NS      l.root-servers.net.

;; Query time: 35 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Thu Nov 04 22:35:25 ;; MSG SIZE  rcvd: 239
```
### dig 를 사용한 172.0.0.1 의 DNS 서버 지정
```
dig google.com "@127.0.0.1"
```
## 일반 패키지 upgrade
```
PS C:\workspace\KubernetesAdmin> choco install -y openssl
Chocolatey v0.10.15
Chocolatey detected you are not running from an elevated command shell
 (cmd/powershell).

 You may experience errors - many functions/packages
 require admin rights. Only advanced users should run choco w/out an
 elevated shell. When you open the command shell, you should ensure
 that you do so with "Run as Administrator" selected. If you are
 attempting to use Chocolatey in a non-administrator setting, you
 must select a different location other than the default install
 location. See
 https://chocolatey.org/install#non-administrative-install for details.

For the question below, you have 20 seconds to make a selection.

 Do you want to continue?([Y]es/[N]o): Y

Installing the following packages:
openssl
By installing you accept licenses for the packages.
Progress: Downloading vcredist2015 14.0.24215.20170201... 100%
Progress: Downloading vcredist140 14.29.30133... 100%
Progress: Downloading chocolatey-core.extension 1.3.5.1... 100%
Progress: Downloading KB3033929 1.0.5... 100%
Progress: Downloading chocolatey-windowsupdate.extension 1.0.4... 100%
Progress: Downloading KB3035131 1.0.3... 100%
Progress: Downloading KB2919355 1.0.20160915... 100%
Progress: Downloading KB2919442 1.0.20160915... 100%
Progress: Downloading KB2999226 1.0.20181019... 100%
Progress: Downloading openssl 1.1.1.1100... 100%

chocolatey-core.extension v1.3.5.1 [Approved]
chocolatey-core.extension package files install completed. Performing other installation steps.
 Installed/updated chocolatey-core extensions.
 The install of chocolatey-core.extension was successful.
  Software installed to 'C:\ProgramData\chocolatey\extensions\chocolatey-core'

chocolatey-windowsupdate.extension v1.0.4 [Approved]
chocolatey-windowsupdate.extension package files install completed. Performing other installation steps.
 Installed/updated chocolatey-windowsupdate extensions.
 The install of chocolatey-windowsupdate.extension was successful.
  Software installed to 'C:\ProgramData\chocolatey\extensions\chocolatey-windowsupdate'

KB3035131 v1.0.3 [Approved]
kb3035131 package files install completed. Performing other installation steps.
Skipping installation because update KB3035131 does not apply to this operating system (Microsoft Windows 11 Home).
 The install of kb3035131 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB3033929 v1.0.5 [Approved]
kb3033929 package files install completed. Performing other installation steps.
Skipping installation because update KB3033929 does not apply to this operating system (Microsoft Windows 11 Home).
 The install of kb3033929 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2919442 v1.0.20160915 [Approved]
kb2919442 package files install completed. Performing other installation steps.
Skipping installation because this hotfix only applies to Windows 8.1 and Windows Server 2012 R2.
 The install of kb2919442 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2919355 v1.0.20160915 [Approved]
kb2919355 package files install completed. Performing other installation steps.
Skipping installation because this hotfix only applies to Windows 8.1 and Windows Server 2012 R2.
 The install of kb2919355 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2999226 v1.0.20181019 [Approved] - Possibly broken
kb2999226 package files install completed. Performing other installation steps.
Skipping installation because update KB2999226 does not apply to this operating system (Microsoft Windows 11 Home).
 The install of kb2999226 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

vcredist140 v14.29.30133 [Approved]
vcredist140 package files install completed. Performing other installation steps.
Downloading vcredist140-x86 
  from 'https://download.visualstudio.microsoft.com/download/pr/221ed2ae-1269-497b-a962-e113045001fa/1ACD8D5EA1CDC3EB2EB4C87BE3AB28722D0825C15449E5C9CEEF95D897DE52FA/VC_redist.x86.exe'
Progress: 100% - Completed download of C:\Users\taeey\AppData\Local\Temp\chocolatey\vcredist140\14.29.30133\VC_redist.x86.exe (13.14 MB).
Download of VC_redist.x86.exe (13.14 MB) completed.
Hashes match.
Installing vcredist140-x86...
vcredist140-x86 has been installed.
Downloading vcredist140-x64 64 bit
  from 'https://download.visualstudio.microsoft.com/download/pr/7239cdc3-bd73-4f27-9943-22de059a6267/003063723B2131DA23F40E2063FB79867BAE275F7B5C099DBD1792E25845872B/VC_redist.x64.exe'
Progress: 100% - Completed download of C:\Users\taeey\AppData\Local\Temp\chocolatey\vcredist140\14.29.30133\VC_redist.x64.exe (24 MB).
Download of VC_redist.x64.exe (24 MB) completed.
Hashes match.
Installing vcredist140-x64...
vcredist140-x64 has been installed.
  vcredist140 may be able to be automatically uninstalled.
 The install of vcredist140 was successful.
  Software installed as 'exe', install location is likely default.

vcredist2015 v14.0.24215.20170201 [Approved]
vcredist2015 package files install completed. Performing other installation steps.
 The install of vcredist2015 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

openssl v1.1.1.1100 [Approved]
openssl package files install completed. Performing other installation steps.
Installing 64-bit openssl...
openssl has been installed.
PATH environment variable does not have C:\Program Files\OpenSSL-Win64\bin in it. Adding...
WARNING: OPENSSL_CONF has been set to C:\Program Files\OpenSSL-Win64\bin\openssl.cfg
  openssl can be automatically uninstalled.
Environment Vars (like PATH) have changed. Close/reopen your shell to
 see the changes (or in powershell/cmd.exe just type `refreshenv`).
 The install of openssl was successful.
  Software installed to 'C:\Program Files\OpenSSL-Win64\'

Chocolatey installed 10/10 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Installed:
 - kb3033929 v1.0.5
 - chocolatey-windowsupdate.extension v1.0.4
 - vcredist140 v14.29.30133
 - kb2999226 v1.0.20181019
 - kb2919355 v1.0.20160915
 - chocolatey-core.extension v1.3.5.1
 - kb2919442 v1.0.20160915
 - vcredist2015 v14.0.24215.20170201
 - openssl v1.1.1.1100
 - kb3035131 v1.0.3

Packages requiring reboot:
 - vcredist140 (exit code 3010)

The recent package changes indicate a reboot is necessary.
 Please reboot at your earliest convenience.
PS C:\workspace\KubernetesAdmin> 
```