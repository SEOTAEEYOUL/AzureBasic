# Azure Client
Windows, macOS, Linux, Docker, Azure Cloud Shell 에서 작동함  

- Cross-platform command-line program  
- Linux, macOS, Windows 에서 사용 가능 (Python 기반)  
- 대화식 또는 스크립팅 모드 지원  
- 명령어는 _groups_ 와 _subgroups_에서 구조화 됨  
- find 를 사용하여 명령어 검색
- 사용 방법에 대해서는 --help 플래그 사용

> [Install Azure CLI on Windows](https://docs.microsoft.com/ko-kr/cli/azure/install-azure-cli-windows?tabs=azure-cli)  
> [Azure Command-Line Interface (CLI) documentation](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)  
> [az Commands Refernce - 명령어 참조](https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)

## login
```
az login
You have logged in. Now let us find all the subscriptions to which you have access...
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "160bacea-7761-4c83-bfa0-354f9b047f5a",
    "id": "9ebb0d63-8327-402a-bdd4-e222b01329a1",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure subscription 1",
    "state": "Enabled",
    "tenantId": "160bacea-7761-4c83-bfa0-354f9b047f5a",
    "user": {
      "name": "ca07456@sktda.onmicrosoft.com",
      "type": "user"
    }
  }
]
```


## Azure CLI version 보기
### Upgrade 가 필요할 경우
```
azure-cli                         2.18.0 *

core                              2.18.0 *
telemetry                          1.0.6

Python location 'C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\python.exe'
Extensions directory 'C:\Users\taeey\.azure\cliextensions'

Python (Windows) 3.6.8 (tags/v3.6.8:3c6b436a57, Dec 23 2018, 23:31:17) [MSC v.1916 32 bit (Intel)]

Legal docs and information: aka.ms/AzureCliLegal


You have 2 updates available. Consider updating your CLI installation with 'az upgrade'

Please let us know how we are doing: https://aka.ms/azureclihats
and let us know if you're interested in trying out our newest features: https://aka.ms/CLIUXstudy
```

### 최신 버전일 경우
```
az --version
azure-cli                         2.19.1

core                              2.19.1
telemetry                          1.0.6

Extensions:
account                            0.2.1

Python location 'C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\python.exe'
Extensions directory 'C:\Users\Administrator\.azure\cliextensions'

Python (Windows) 3.6.8 (tags/v3.6.8:3c6b436a57, Dec 23 2018, 23:31:17) [MSC v.1916 32 bit (Intel)]

Legal docs and information: aka.ms/AzureCliLegal


Your CLI is up-to-date.

Please let us know how we are doing: https://aka.ms/azureclihats
and let us know if you're interested in trying out our newest features: https://aka.ms/CLIUXstudy
```

## Upgrade
```
PS D:\workspace\Azure> az upgrade
This command is experimental and not covered by customer support. Please use with discretion.
Your current Azure CLI version is 2.14.0. Latest version available is 2.19.1.
Please check the release notes first: https://docs.microsoft.com/cli/azure/release-notes-azure-cli
Do you want to continue? (Y/n): Y
```

## 명령예

### 계정 보기
```
az account list -o tsv
AzureCloud      9515311f-d116-4323-8ed0-cf4b816d5cf0    False   N/A(tenant level account)       Enabled 9515311f-d116-4323-8ed0-cf4b816d5cf0
AzureCloud      160bacea-7761-4c83-bfa0-354f9b047f5a    9ebb0d63-8327-402a-bdd4-e222b01329a1    True    0       Azure subscription 1    Enabled 160bacea-7761-4c83-bfa0-354f9b047f5a
```

### 자원 그룹 보기
```
az group list -o tsv
/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/DefaultResourceGroup-CUS     centralus       None    DefaultResourceGroup-CUS                None    Microsoft.Resources/resourceGroups
/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg_jin       koreacentral    None    rg_jin                  Microsoft.Resources/resourceGroups
/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/RG_chuls     koreacentral    None    RG_chuls                        Microsoft.Resources/resourceGroups
/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/NetworkWatcherRG     koreacentral    None    NetworkWatcherRG                None    Microsoft.Resources/resourceGroups
/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg_taeeyoul  koreacentral    None    rg_taeeyoul                     Microsoft.Resources/resourceGroups
```

### 가능한 확장 목록 보기
```
az extension list-available -o table
Name                            Version    Summary                                                                                                            Preview    Experimental    Installed
------------------------------  ---------  -----------------------------------------------------------------------------------------------------------------  ---------  --------------  -----------
account                         0.2.1      Microsoft Azure Command-Line Tools SubscriptionClient Extension                                                    False      True            True
acrtransfer                     1.0.0      Microsoft Azure Command-Line Tools Acrtransfer Extension                                                           True       False           False
ad                              0.1.0      Microsoft Azure Command-Line Tools DomainServicesResourceProvider Extension                                        False      False           False
aem                             0.2.1      Manage Azure Enhanced Monitoring Extensions for SAP                                                                False      False           False
ai-examples                     0.2.5      Add AI powered examples to help content.                                                                           True       False           False
aks-preview                     0.5.5      Provides a preview for upcoming AKS features                                                                       True       False           False
alertsmanagement                0.1.0      Microsoft Azure Command-Line Tools Alerts Extension                                                                False      True            False
alias                           0.5.2      Support for command aliases                                                                                        True       False           False
application-insights            0.1.13     Support for managing Application Insights components and querying metrics, events, and logs from such components.  True       False           False
arcappliance                    0.1.1      Microsoft Azure Command-Line Tools Arcappliance Extension                                                          True       False           False
attestation                     0.2.0      Microsoft Azure Command-Line Tools AttestationManagementClient Extension                                           False      True            False
automation                      0.1.0      Microsoft Azure Command-Line Tools AutomationClient Extension                                                      False      True            False
azure-batch-cli-extensions      6.0.0      Additional commands for working with Azure Batch service                                                           False      False           False
azure-cli-ml                    1.23.0     Microsoft Azure Command-Line Tools AzureML Command Module                                                          False      False           False
azure-devops                    0.18.0     Tools for managing Azure DevOps.                                                                                   False      False           False
azure-firewall                  0.9.0      Manage Azure Firewall resources.                                                                                   True       False           False
azure-iot                       0.10.10    The Azure IoT extension for Azure CLI.                                                                             False      False           False
baremetal-infrastructure        0.0.2      Additional commands for working with BareMetal instances.                                                          False      False           False
blockchain                      0.1.0      Microsoft Azure Command-Line Tools BlockchainManagementClient Extension                                            False      True            False
blueprint                       0.2.1      Microsoft Azure Command-Line Tools Blueprint Extension                                                             False      True            False
cli-translator                  0.3.0      Translate ARM template to executable Azure CLI scripts.                                                            False      True            False
codespaces                      0.3.0      The Azure CLI Codespaces extension                                                                                 True       False           False
communication                   0.1.0      Microsoft Azure Command-Line Tools CommunicationServiceManagementClient Extension                                  False      True            False
confluent                       0.1.0      Microsoft Azure Command-Line Tools ConfluentManagementClient Extension                                             False      True            False
connectedk8s                    1.0.0      Microsoft Azure Command-Line Tools Connectedk8s Extension                                                          False      False           False
connectedmachine                0.3.0      Microsoft Azure Command-Line Tools ConnectedMachine Extension                                                      False      True            False
cosmosdb-preview                0.5.0      Microsoft Azure Command-Line Tools Cosmosdb-preview Extension                                                      True       False           False
costmanagement                  0.1.0      Microsoft Azure Command-Line Tools CostManagementClient Extension                                                  False      True            False
csvmware                        0.3.0      Manage Azure VMware Solution by CloudSimple.                                                                       True       False           False
custom-providers                0.1.0      Microsoft Azure Command-Line Tools Custom Providers Extension                                                      False      True            False
databox                         0.1.0      Microsoft Azure Command-Line Tools DataBox Extension                                                               False      True            False
databricks                      0.7.2      Microsoft Azure Command-Line Tools DatabricksClient Extension                                                      False      False           False
datafactory                     0.2.0      Microsoft Azure Command-Line Tools DataFactoryManagementClient Extension                                           False      True            False
datashare                       0.1.1      Microsoft Azure Command-Line Tools DataShareManagementClient Extension                                             False      True            False
db-up                           0.2.1      Additional commands to simplify Azure Database workflows.                                                          True       False           False
deploy-to-azure                 0.2.0      Deploy to Azure using Github Actions.                                                                              True       False           False
desktopvirtualization           0.1.0      Microsoft Azure Command-Line Tools DesktopVirtualizationAPIClient Extension                                        False      True            False
dev-spaces                      1.0.6      Dev Spaces provides a rapid, iterative Kubernetes development experience for teams.                                False      False           False
dms-preview                     0.12.0     Support for new Database Migration Service scenarios.                                                              True       False           False
eventgrid                       0.4.9      Microsoft Azure Command-Line Tools EventGrid Command Module.                                                       True       False           False
express-route-cross-connection  0.1.1      Manage customer ExpressRoute circuits using an ExpressRoute cross-connection.                                      False      False           False
footprint                       1.0.0      Microsoft Azure Command-Line Tools FootprintMonitoringManagementClient Extension                                   False      True            False
front-door                      1.0.11     Manage networking Front Doors.                                                                                     False      False           False
fzf                             1.0.2      Microsoft Azure Command-Line Tools fzf Extension                                                                   False      True            False
guestconfig                     0.1.0      Microsoft Azure Command-Line Tools GuestConfigurationClient Extension                                              False      True            False
hack                            0.4.3      Microsoft Azure Command-Line Tools Hack Extension                                                                  True       False           False
hardware-security-modules       0.1.0      Microsoft Azure Command-Line Tools AzureDedicatedHSMResourceProvider Extension                                     False      True            False
healthbot                       0.1.0      Microsoft Azure Command-Line Tools HealthbotClient Extension                                                       False      True            False
healthcareapis                  0.3.1      Microsoft Azure Command-Line Tools HealthcareApisManagementClient Extension                                        False      False           False
hpc-cache                       0.1.2      Microsoft Azure Command-Line Tools StorageCache Extension                                                          True       True            False
image-copy-extension            0.2.8      Support for copying managed vm images between regions                                                              False      False           False
import-export                   0.1.1      Microsoft Azure Command-Line Tools StorageImportExport Extension                                                   False      True            False
interactive                     0.4.4      Microsoft Azure Command-Line Interactive Shell                                                                     True       False           False
internet-analyzer               0.1.0rc5   Microsoft Azure Command-Line Tools Internet Analyzer Extension                                                     True       False           False
ip-group                        0.1.2      Microsoft Azure Command-Line Tools IpGroup Extension                                                               True       False           False
k8s-configuration               1.0.0      Microsoft Azure Command-Line Tools K8s-configuration Extension                                                     False      False           False
k8sconfiguration                0.2.4      Microsoft Azure Command-Line Tools K8sconfiguration Extension                                                      True       False           False
kusto                           0.2.0      Microsoft Azure Command-Line Tools KustoManagementClient Extension                                                 False      True            False
log-analytics                   0.2.2      Support for Azure Log Analytics query capabilities.                                                                True       False           False
log-analytics-solution          0.1.1      Support for Azure Log Analytics Solution                                                                           False      True            False
logic                           0.1.2      Microsoft Azure Command-Line Tools LogicManagementClient Extension                                                 False      True            False
maintenance                     1.1.0      Microsoft Azure Command-Line Tools MaintenanceClient Extension                                                     True       False           False
managementpartner               0.1.3      Support for Management Partner preview                                                                             False      False           False
mesh                            0.10.6     Support for Microsoft Azure Service Fabric Mesh - Public Preview                                                   True       False           False
mixed-reality                   0.0.2      Mixed Reality Azure CLI Extension.                                                                                 True       False           False
monitor-control-service         0.1.0      Microsoft Azure Command-Line Tools MonitorClient Extension                                                         True       False           False
netappfiles-preview             0.3.2      Provides a preview for upcoming Azure NetApp Files (ANF) features.                                                 True       False           False
next                            0.1.2      Microsoft Azure Command-Line Tools Next Extension                                                                  False      True            False
notification-hub                0.2.0      Microsoft Azure Command-Line Tools Notification Hub Extension                                                      False      True            False
offazure                        0.1.0      Microsoft Azure Command-Line Tools AzureMigrateV2 Extension                                                        False      True            False
peering                         0.2.0      Microsoft Azure Command-Line Tools PeeringManagementClient Extension                                               False      True            False
portal                          0.1.1      Microsoft Azure Command-Line Tools Portal Extension                                                                False      True            False
powerbidedicated                0.2.0      Microsoft Azure Command-Line Tools PowerBIDedicated Extension                                                      True       False           False
providerhub                     0.1.0      Microsoft Azure Command-Line Tools Providerhub Extension                                                           False      True            False
quantum                         0.2.0      Microsoft Azure Command-Line Tools Quantum Extension                                                               True       False           False
rdbms-connect                   0.1.2      Support for testing connection to Azure Database for MySQL & PostgreSQL servers.                                   True       False           False
redisenterprise                 0.1.0      Microsoft Azure Command-Line Tools RedisEnterpriseManagementClient Extension                                       True       False           False
resource-graph                  1.1.0      Support for querying Azure resources with Resource Graph.                                                          True       False           False
resource-mover                  0.1.0      Microsoft Azure Command-Line Tools ResourceMoverServiceAPI Extension                                               False      True            False
sap-hana                        0.6.4      Additional commands for working with SAP HanaOnAzure instances.                                                    False      False           False
scheduled-query                 0.2.2      Microsoft Azure Command-Line Tools Scheduled_query Extension                                                       True       False           False
sentinel                        0.1.0      Microsoft Azure Command-Line Tools SecurityInsights Extension                                                      False      True            False
spring-cloud                    2.2.1      Microsoft Azure Command-Line Tools spring-cloud Extension                                                          False      False           True
ssh                             0.1.0      SSH into VMs                                                                                                       True       False           False
stack-hci                       0.1.2      Microsoft Azure Command-Line Tools AzureStackHCIClient Extension                                                   False      False           False
storage-blob-preview            0.4.0      Microsoft Azure Command-Line Tools Storage-blob-preview Extension                                                  True       False           False
storage-preview                 0.7.0      Provides a preview for upcoming storage features.                                                                  True       False           False
storagesync                     0.1.0      Microsoft Azure Command-Line Tools MicrosoftStorageSync Extension                                                  False      True            False
stream-analytics                0.1.0      Microsoft Azure Command-Line Tools stream-analytics Extension                                                      False      True            False
subscription                    0.1.4      Support for subscription management preview.                                                                       True       False           False
support                         1.0.2      Microsoft Azure Command-Line Tools Support Extension                                                               False      False           False
synapse                         0.3.0      Microsoft Azure Command-Line Tools Synapse Extension                                                               True       False           False
timeseriesinsights              0.2.0      Microsoft Azure Command-Line Tools TimeSeriesInsightsClient Extension                                              False      True            False
virtual-network-tap             0.1.0      Manage virtual network taps (VTAP).                                                                                True       False           False
virtual-wan                     0.2.4      Manage virtual WAN, hubs, VPN gateways and VPN sites.                                                              True       False           False
vm-repair                       0.3.4      Auto repair commands to fix VMs.                                                                                   False      False           False
vmware                          2.0.1      Azure VMware Solution commands.                                                                                    False      False           False
webapp                          0.3.1      Additional commands for Azure AppService.                                                                          True       False           False
```

### azure-evops 확장 설치
```
az extension add -n azure-devops 
```

### 설치된 확장 보기
```
az extension list -o table
Experimental    ExtensionType    Name          Path                                                      Preview    Version
--------------  ---------------  ------------  --------------------------------------------------------  ---------  ---------
True            whl              account       C:\Users\Administrator\.azure\cliextensions\account       False      0.2.1
False           whl              azure-devops  C:\Users\Administrator\.azure\cliextensions\azure-devops  False      0.18.0
False           whl              spring-cloud  C:\Users\Administrator\.azure\cliextensions\spring-cloud  False      2.2.1
```