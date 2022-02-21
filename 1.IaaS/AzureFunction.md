# Azure Function

## Azure Functions Runtime 에서 사용할 수 있는 버전
| 언어 | 1.x | 2.x | 3.x | 4.x | Linux | Windows |    
|:---|:---|:---|:---|:---|:---|:---| 
| JavaScript | GA(Node.js 6) | GA(Node.js 10 & 8) | GA(Node.js 14, 12, & 10) | GA(Node.js 14) </br> 미리 보기(Node.js 16) | ✓ | ✓ |  
| Java | 해당 없음 | GA(Java 8) | GA(Java 11 & 8) | GA(Java 11 & 8) |  ✓ | ✓ |
| PowerShell | 해당 없음 | GA(PowerShell Core 6) | GA(PowerShell 7.0 & Core 6)	 | GA(PowerShell 7.0) |   | ✓ |
| Python | 해당 없음 | GA(Python 3.7 & 3.6) | GA(Python 3.9, 3.8, 3.7, & 3.6) | GA(Python 3.9, 3.8, 3.7) | ✓ | ✓ |  
| TypeScript2 | N/A | GA | GA | GA | ✓ | ✓ | 

## Pythone
## Azure Function Core tools 설치
```
npm install -g azure-functions-core-tools@3 --unsafe-perm true
```
```
PS C:\workspace\AzureBasic> npm install -g azure-functions-core-tools@3 --unsafe-perm true
C:\Users\taeey\AppData\Roaming\npm\func -> C:\Users\taeey\AppData\Roaming\npm\node_modules\azure-functions-core-tools\lib\main.js
C:\Users\taeey\AppData\Roaming\npm\azfun -> C:\Users\taeey\AppData\Roaming\npm\node_modules\azure-functions-core-tools\lib\main.js
C:\Users\taeey\AppData\Roaming\npm\azurefunctions -> C:\Users\taeey\AppData\Roaming\npm\node_modules\azure-functions-core-tools\lib\main.js

> azure-functions-core-tools@3.0.3904 postinstall C:\Users\taeey\AppData\Roaming\npm\node_modules\azure-functions-core-tools
> node lib/install.js

attempting to GET "https://functionscdn.azureedge.net/public/3.0.3904/Azure.Functions.Cli.win-x64.3.0.3904.zip"
[==================] Downloading Azure Functions Core Tools

Telemetry
---------
The Azure Functions Core tools collect usage data in order to help us improve your experience.
The data is anonymous and doesn't include any user specific or personal information. The data is collected by Microsoft.

You can opt-out of telemetry by setting the FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT environment variable to '1' or 'true' using your favorite shell.

+ azure-functions-core-tools@3.0.3904
updated 1 package in 23.715s
PS C:\workspace\AzureBasic> 
```

### 가상환경 만들기 및 활성화
#### py -m venv .venv
#### .venv\scripts\activate
```
PS C:\workspace\AzureBasic\1.IaaS> py -m venv .venv
PS C:\workspace\AzureBasic\1.IaaS> .venv\scripts\activate
(.venv) PS C:\workspace\AzureBasic\1.IaaS> 
```

### Project 및 Git 리포지토리 만들기
#### func init funcPyton --python
```
(.venv) PS C:\workspace\AzureBasic\1.IaaS> func init funcPyton --python
Found Python version 3.9.1 (py).
Writing requirements.txt)
Writing .funcignore
Writing getting_started.md
Writing .gitignore
Writing host.json
Writing local.settings.json
Writing C:\workspace\AzureBasic\1.IaaS\funcPyton\.vscode\extensions.json
(.venv) PS C:\workspace\AzureBasic\1.IaaS> 
```