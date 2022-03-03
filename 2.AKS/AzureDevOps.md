# [Azure DevOps](dev.azure.com)
![azure-devops.png](./img/azure-devops.png)

[미리 정의된 변수 사용](https://docs.microsoft.com/ko-kr/azure/devops/pipelines/build/variables?view=azure-devops&tabs=yaml) 

| 변수명 | 설명 |
|:---|:---|
| $(System.DefaultWorkingDirectory) | 소스 코드 파일이 다운로드되는 에이전트의 로컬 경로 |  
| $(Build.ArtifactStagingDirectory) | 대상에 푸시되기 전에 아티팩트가 복사되는 에이전트의 로컬 경로 |  


## Organization Settings
  - Billing -> Set up Builling -> 종량제 선택 -> Save
    ![AzureDevOps-OranizationSettings-Billing.png](./img/AzureDevOps-OranizationSettings-Billing.png)
  
## ![AzureDevOps-New-Project.png](./img/AzureDevOps-New-Project.png)
New Create Project
  - name : SpringMySQL
  ![AzureDevOps-New-Project-1.png](./img/AzureDevOps-New-Project-1.png)

#### Azure Container Repository 정보
| 구분 | 내용 | 
|:---|:---|
| ACR | acrhomeeee.azurecr.io |  
| Registry | acrHomeeee |  
| Repogitory | springmysql |  

## "Repos" > "Files"
- "Clone in VS Code" 로 소스파일 생성  
- **Import a repository** 로 Git 저장소의 소스 가져오기(★)
  - https://github.com/SEOTAEEYOUL/SpringBootMySQL.git
- Files
![AzureDevOps-SpringMysql-Repos.png](./img/AzureDevOps-SpringMysql-Repos.png)  
![AzureDevOps-Repos-ImportaRepository.png](./img/AzureDevOps-Repos-ImportaRepository.png)  

## Overview > Summary 만들기
#### SpringMySQL > Summary > **"+ Add Project Description"**
![AzureDevOps-SpringMySQL-Summary-AddProjectDescription.png](./img/AzureDevOps-SpringMySQL-Summary-AddProjectDescription.png)  
#### About this project
- Description : SpringMySQL
- About : Readme file : SpringMySQL (Repos 선택)
  ![AzureDevOps-SpringMySQL-Summary-AddProjectDescription-ReadmeFile-SpringMySQL.png](./img/AzureDevOps-SpringMySQL-Summary-AddProjectDescription-ReadmeFile-SpringMySQL.png)  

## Pipelines 
### Pipelines(**CI**)
#### 1. Pipelines -> Create Pipelines 
![AzureDevOps-Pipelines-Pipelins-CreatePipeline.png](./img/AzureDevOps-Pipelines-Pipelins-CreatePipeline.png)  
#### 2. **Use the classic editor** Click
  ![AzureDevOps-Pipeline-Pipelines-CreatePipelines.png](./img/AzureDevOps-Pipelines-Pipelines-CreatePipelines-Connect-UsetheClassicEditor.png)  

#### 3. Select a source
- **Azure Repos Git** 선택(★)
- continue 선택  
![AzureDevOps-Pipelines-AzureReposGit.png](./img/AzureDevOps-Pipelines-AzureReposGit.png)

- Get source -> other Git 선택  
  ``` 
  Default branch for manual and scheduled builds : master
  Connection name : nodejs-bot.gitea  
  Repository : http://gitea.nodespringboot.org/taeyeol/nodejs-bot.git
  Connection name : nodejs-bot-deploy 
  Repository : http://gitea.chatops.ga/chatadmin/nodejs-bot-deploy.git
  ```		
  ![AzureDevOps-Pipelines-OtherGit.png](./img/AzureDevOps-Pipelines-OtherGit.png)


#### 4. **Empty Job** 클릭  
  ![AzureDevOps-Pipelines-SelectaTemplate-Emptyjob.png](./img/AzureDevOps-Pipelines-SelectATemplate-Emptyjob.png)  
  
  - **Agent job -> Pipeline -> Agent Specification -> ubuntu-20.04**
    
  ![AzureDevOps-Pipelines-nodejs-bot-CI-Agent job.png](./img/AzureDevOps-Pipelines-nodejs-bot-CI-Agent job.png)  

#### 5. Pipeline 설정
- Name : SpringMySQL-CI
- Agent pool : Azure Pipelines
- Agent Sepecification : ubuntu-20.04
  ![AzureDevOps-Pipelines-SpringMySQL-Ci-Pipeline.png](./img/AzureDevOps-Pipelines-SpringMySQL-Ci-Pipeline.png)  

#### 6. Task(Agent job) 설정
- Display name :  CI  
- Agent selection
  - Agent pool : Azure Pipelines
  - Agent Specification : ubuntu-20.04
![AzureDevOps-Pipelines-nodejs-bot-CI-AgentJob-CI.png](./img/AzureDevOps-Pipelines-nodejs-bot-CI-AgentJob-CI.png)  


#### 7. **CI** angent job 의 "+" 로 Task 추가  
##### 7.1 **Maven** 추가 (Maven pom.xml)
- 그대로 사용
##### 7.1 Node.js tool installer (Use Node 6.x)
- 그대로 사용
##### 7.1.1 **코드 커밋시 , 자동 트리거 설정**  
  - Triggers 탭 선택
  - repository : **Enable continuous integration** check
    ![AzureDevOps-SpringMySQL-Ci-Tiggers.png](./img/AzureDevOps-SpringMySQL-Ci-Tiggers.png)  
    ![AzureDevOps-nodejs-bot-Ci-Tiggers.png](./img/AzureDevOps-nodejs-bot-Ci-Tiggers.png)  

##### 7.2 **Copy Files** (Copy Files to)
- Display name : Copy Files to:
- Source Folder : **$(System.DefaultWorkingDirectory)**
- Contents : k8s/* 
- Target Folder : **$(Build.ArtifactStagingDirectory)**
  ![AzureDevOps-SpringMySQL-Ci-CopyFiles.png](./img/AzureDevOps-SpringMySQL-Ci-CopyFiles.png)  
  ![AzureDevOps-SpringMySQL-Ci-CopyFiles-1.png](./img/AzureDevOps-SpringMySQL-Ci-CopyFiles-1.png)  
#### 7.3 **Publish Build Artifacts** (Publish Artifact: drop)
- Display name : Publish Artifact: drop
- Path to publish : **$(Build.ArtifactStagingDirectory)**
- Artifact name : drop
- Artifact publish location : Azure Pipelines
  ![AzureDevOps-SpringMySQL-Ci-PublishBuildArtifacts.png](./img/AzureDevOps-SpringMySQL-Ci-PublishBuildArtifacts.png)  
  ![AzureDevOps-SpringMySQL-Ci-PublishBuildArtifacts-1.png](./img/AzureDevOps-SpringMySQL-Ci-PublishBuildArtifacts-1.png)  

##### 7.4 **Docker** 선택(buildAndPush 로 Taks 추가)
- Display name : buildAndPush
- Container Repository
  - Container registry : AKS
- **New service connection** 생성
  - Registry type : **Azure Container Registry** 선택
  - Subscription: **Azure subscrition 1(...)** 선택
  - Azure Container registry : **acrHomeeee** 선택 
  - Service connection name : **acrHomeeee** 입력
  - **Grant access permission to all pipelines** 체크
    ![AzureDevOps-SpringMySQL-Ci-Docker.png](./img/AzureDevOps-SpringMySQL-Ci-Docker.png)  
    ![AzureDevOps-Pipelines-Pipelins-Tasks-Docker-Newserviceconnection-0.png](./img/AzureDevOps-Pipelines-Pipelins-Tasks-Docker-Newserviceconnection-0.png)  
    ![AzureDevOps-Pipelines-Pipelins-Tasks-Docker-Newserviceconnection.png](./img/AzureDevOps-Pipelines-Pipelins-Tasks-Docker-Newserviceconnection.png)
- **Container repository** : springmysql  
- **Commands**
  - Command : buildAndPush
  - Dockerfile : **/Dockerfile 
  - Build context : **
  - Tags : $(Build.BuildId)
  - **Add Pipeline metadata to image(s)** Check
  - **Add base image metadata to image(s)** Check
    ![AzureDevOps-Pipelines-nodejs-bot-CI-Task-Docker-0.png](./img/AzureDevOps-Pipelines-nodejs-bot-CI-Task-Docker-0.png)  
    ![AzureDevOps-Pipelines-nodejs-bot-CI-Task-Docker.png](./img/AzureDevOps-Pipelines-nodejs-bot-CI-Task-Docker.png)  


#### 8. Save  & queue 클릭
- **Save** 선택
	  
### Releases(**CD**)  
Articatis 의 deploy 의 container tag 를 빌드한 버전으로 바꿔준 후 Deployment(Pod) 와 Service 를 배포함

### 1. New pipeline
- **Empty job** 선택
![AzureDevOps-Pipelines-Releases-Newpipeline-Emptyjob.png](./img/AzureDevOps-Pipelines-Releases-Newpipeline-Emptyjob.png)  

### 2. Stage
- Properties
  - Stage name : **Dev**  

![AzuerDevOps-Pipelines-Releases-NewPipeline-Stage.png](./img/AzuerDevOps-Pipelines-Releases-NewPipeline-Stage.png)  

### 3. Add an Artifact
- Soruce type
- Project : **SpringMySQL** 선택
- Source (build pipeline) : **SpringMySQL-CI**
- Default version : Latest
- Source alias : _SpringMySQL-CI
![AzureDevOps-Pipelines-Release-NewPipeline-Artifacts-0.png](./img/AzureDevOps-Pipelines-Release-NewPipeline-Artifacts-0.png)  
![AzureDevOps-Pipelines-Release-NewPipeline-Artifacts.png](./img/AzureDevOps-Pipelines-Release-NewPipeline-Artifacts.png)  

### 4. Continous deployment trigger(번개 아이콘) 클릭 -> 활성화
- Continuous deployment trigger : **Enabled**  
git 소스가 변경될 때 CI 후 CD 가 되도록 설정  
![AzureDevOps-Pipelines-Release-NewPipeline-Artifacts-ContinousDeploymentTrigger-0.png](./img/AzureDevOps-Pipelines-Release-NewPipeline-Artifacts-ContinousDeploymentTrigger-0.png)  

![AzureDevOps-Pipelines-Release-NewPipeline-Artifacts-ContinousDeploymentTrigger.png](./img/AzureDevOps-Pipelines-Release-NewPipeline-Artifacts-ContinousDeploymentTrigger.png)  

### 5. **Stage** Task 설정
#### 5.1 Stage 화면에서 **"1 job, 0 task"** 클릭
#### 5.2 Agent Job 에 Taks 추가(**+**)
##### 5.2.1 **Bash** (Bash Script)
- Taks version : 3.*
- Display name : **Bash Script**
- Type: **Inline** 선택
- Script  
  ```bash
  sed -i "s/latest/$(Build.BuildId)/g" $(System.DefaultWorkingDirectory)/_SpringMySQL-CI/drop/k8s/springmysql-deploy.yaml
  ```
  ![AzureDevOps-Pipelines-Releases-NewRelease-AgentJob-bash-0.png](./img/AzureDevOps-Pipelines-Releases-NewRelease-AgentJob-bash-0.png)
  ```bash
  sed -i "s/latest/$(Build.BuildId)/g" $(System.DefaultWorkingDirectory)/_NodeJs-Bot-CI/drop/k8s/nodejs-bot-deploy.yaml
  ```   
  ![AzureDevOps-Pipelines-Releases-NewRelease-AgentJob-bash.png](./img/AzureDevOps-Pipelines-Releases-NewRelease-AgentJob-bash.png)  

##### 5.2.2 **kubectl** (kubectl apply Deployment)
- Kubectl
  - Taks version: 1.*
  - Display name : kubectl apply deployment
- Kubernetes Cluster
  - Service connection type : Kubernetes service connection
  - Kubernetes service connection : aks-cluster-Homeeee
    없을 시 **+ New** 버튼을 눌러 아래와 같이 추가함  
    ![AzureDevOps-Pipelinses-Release-NewServiceConnection.png](./img/AzureDevOps-Pipelinses-Release-NewServiceConnection.png)
  - Namespace : 비워둠
- Commands
  - Commands: apply
  - **Use configuration** 체크
  - Configureation type : Inline configuration
  - Inline configuration
    ```bash
    $(System.DefaultWorkingDirectory)/_SpringMySQL-CI/drop/k8s/springmysql-deploy.yaml
    ```
    ```bash
    $(System.DefaultWorkingDirectory)/_nodejs-bot-CI/drop/k8s/nodejs-bot-deploy.yaml
    ```  

![AzureDevOps-Pipelines-Releases-New Release-AgentJob-Kubectl-apply-deploy.png](./img/AzureDevOps-Pipelines-Releases-NewRelease-AgentJob-Kubectl-apply-deploy.png)

##### 5.2.3 **kubectl** (kubectl apply Service)
- Kubectl
  - Taks version: 1.*
  - Display name : kubectl apply service
- Kubernetes Cluster
  - Service connection type : Kubernetes service connection
  - Kubernetes service connection : aks-cluster-Homeeee
    없을 시 **+ New** 버튼을 눌러 아래와 같이 추가함  
    ![AzureDevOps-Pipelinses-Release-NewServiceConnection.png](./img/AzureDevOps-Pipelinses-Release-NewServiceConnection.png)
  - Namespace : 비워둠
- Commands
  - Commands: apply
  - **Use configuration** 체크
  - Configureation type : Inline configuration
  - Inline configuration
    ```
    $(System.DefaultWorkingDirectory)/_SpringMySQL-CI/drop/k8s/springmysql-svc.yaml
    ```
    ```
    $(System.DefaultWorkingDirectory)/_nodejs-bot-CI/drop/k8s/nodejs-bot-svc.yaml
    ```  

![AzureDevOps-Pipelines-Releases-New Release-AgentJob-Kubectl-apply-service.png](./img/AzureDevOps-Pipelines-Releases-NewRelease-AgentJob-Kubectl-apply-service.png)  

![AzureDevOps-Pipelines-Releases-New Release-AgentJob-Tasks.png](./img/AzureDevOps-Pipelines-Releases-NewRelease-AgentJob-Tasks.png)  

##### 6. Pipeline 명 바꾸기
- SpringMySQL-CD
  ![AzureDevOps-Pipelinses-Release-EditPipelineName.png](./img/AzureDevOps-Pipelinses-Release-EditPipelineName.png)  

---
## SpringMySql

#### Azure Container Repository 정보
| 구분 | 내용 | 
|:---|:---|
| ACR | acrhomeeee.azurecr.io |  
| Registry | acrHomeeee |  
| Repogitory | springmysql |  


## Pipelines > Pipelines(CI)
### Tasks
Build Step
![AzureDevOps-Tasks.png](./img/AzureDevOps-Tasks.png)
#### Task 추가

Docker 선택 (buildAndPush)
![AzureDevOps-Tasks-buildAndPush.png](./img/AzureDevOps-Tasks-buildAndPush.png)

- Copy Files(Copy Files to:)
  - $(system.defaultworkingdirectory) : 소스디렉토리
  - $(Build.ArtifactStagingDirectory) : 

Publish build artifacts(Publish)
![AzureDevOps-Pipeline-Addtaks-Pulibshbuildartifacs.png](./img/AzureDevOps-Pipeline-Addtaks-Pulibshbuildartifacs.png)  
![AzureDevOps-Tasks-Publish-build-artifacts.png](./img/AzureDevOps-Tasks-Publish-build-artifacts.png)  

$(System.DefaultWorkingDirectory)/_SpringMySQL-CI/drop/k8s/springmysql-deploy.yaml

## Pipelines > Release(CD)
![AzureDevOps-SpringMySQL-CD.png](./img/AzureDevOps-SpringMySQL-CD.png)
### 승인후배포
#### 설정하기
![AzureDevOps-Release-SpringMySQL-CD-Stage-Pre-deploymentCondition(승인후배포).png](./img/AzureDevOps-Release-SpringMySQL-CD-Stage-Pre-deploymentCondition(승인후배포).png)  

#### 승인하기
![AzureDevOps-Release-SpringMySQL-CD-Stage-Pre-deploymentCondition(승인후배포)-1.png](./img/AzureDevOps-Release-SpringMySQL-CD-Stage-Pre-deploymentCondition(승인후배포)-1.png)
#### 승인 후 배포 결과
![AzureDevOps-Release-SpringMySQL-CD-Stage-Pre-deploymentCondition(승인후배포)-2.png](./img/AzureDevOps-Release-SpringMySQL-CD-Stage-Pre-deploymentCondition(승인후배포)-2.png)  
![AzureDevOps-Release-SpringMySQL-CD-Stage-Pre-deploymentCondition(승인후배포)-2-0.png](./img/AzureDevOps-Release-SpringMySQL-CD-Stage-Pre-deploymentCondition(승인후배포)-2-0.png)  

### Project(SpringMySQL) Pipeline 을 Export 받기
#### SpringMySQL > Pipelines > Pipelines > SpringMySQL-CI > (More actions) > Export to YAML
![AzureDevOps-ExportYaml.png](./img/AzureDevOps-ExportYaml.png)   
#### SpringMySQL > Pipelines > Release > (More actions) > Export
![AzureDevOps-Release-Export.png](./img/AzureDevOps-Release-Export.png)  

### 빌드 후 통보 받기(Service hooks 설정)
Project Settings > Service hooks > **+ Create subscription** > Service > **Slack**
![ProjectSettings-Service-Slack-0.png](./img/ProjectSettings-Service-Slack-0.png)  
![ProjectSettings-Service-Slack-1.png](./img/ProjectSettings-Service-Slack-1.png)  
![ProjectSettings-Service-Slack-2.png](./img/ProjectSettings-Service-Slack-2.png)  
![ProjectSettings-Service-Slack-3.png](./img/ProjectSettings-Service-Slack-3.png)  

#### Slack 화면  
![AzureDevOps-Slack.png](./img/AzureDevOps-Slack.png)  

