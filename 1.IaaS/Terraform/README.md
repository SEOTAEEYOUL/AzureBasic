# [Terraform](https://github.com/hashicorp/terraform)  
HashiCorp 가 제공하는 IaC 도구  
인프라 구축 및 설정을 코드(템플릿 파일)로 관리하면서 인프라 배포를 자동화할 수 있음  

> [Azure의 Terraform 설명서](https://docs.microsoft.com/ko-kr/azure/developer/terraform/)  
> [Examples](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples)  
> [Get Started - Azure](https://learn.hashicorp.com/collections/terraform/azure-get-started)  
> [Get Started - AWS](https://learn.hashicorp.com/collections/terraform/aws-get-started?utm_source=terraform_io_download)  
> [Getting Started with AWS EKS using Terraform](https://medium.com/stakater/getting-started-with-aws-eks-using-terraform-7487ffeac48f)  
> [Tutorial: Standing up an EKS Cluster with Terraform](https://medium.com/devops-dudes/tutorial-standing-up-an-eks-cluster-with-terraform-4139ff0f1189)  
> [Using Terraform to Deploy to EKS](https://www.cloudforecast.io/blog/using-terraform-to-deploy-to-eks/)  
> [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)  
> [Linux AMI 찾기](https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/finding-an-ami.html)  
> [Amazon EC2 AMI Locator - ubuntu](https://cloud-images.ubuntu.com/locator/ec2/)  
> [busybox](https://busybox.net/)  
> [Build Infrastructure - Terraform AWS Example](https://learn.hashicorp.com/tutorials/terraform/aws-build)  
> [TERRAFORM & AWS 101](https://terraform101.inflearn.devopsart.dev/)  
> [CloudFormation to Terraform](https://github.com/humanmade/cf-to-tf)    
> [How to use s3 backend with a locking feature in Terraform to collaborate more efficiently? (easily and visually explained)](https://medium.com/clarusway/how-to-use-s3-backend-with-a-locking-feature-in-terraform-to-collaborate-more-efficiently-fa0ea70cf359)  


## [terraform download](https://www.terraform.io/downloads)
> [amd64](https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_windows_amd64.zip)   
path가 걸려 있는 곳에 binary copy 후 사용 

**terraform version**
```
PS C:\workspace\AWSBasic\1.IaaS\Terraform> terraform version
Terraform v1.1.7
on windows_amd64
```

## 테라폼 기본 개념

### 프로비저닝
어떤 프로세스나 서비스를 실행하기 위한 준비 단계

### Provider
Terraform 과 외부 서비스를 연결해주는 기능을 하는 모듈
- AWS
- Microsoft Azure
- Google Cloud Platform
- Github
- Datadog
- DNSimple
- MySQL
- RabbitMQ
- Docker ...

### Resource
특정 Provider 가 제공해 주는 조작 가능한 최소 단위


### HLC(Harshicorp Configuration Language)  
Terraform 에서 사용하는 설정 언어  
파일의 확장자는 .tf 사용

### Plan
terraform directory 아래의 모든 .tf 가 실제 적용 가능한지 확인하는 작업  
리소스의 생성, 수정, 삭제 될지를 보여줌  
배포하기 전에 bug 수정할 수 있음

### Apply
terraform directory 아래의 모든 .tf 파일의 내용대로 resource 를 생성, 수정, 삭제하는 일  

### destroy
resource 제거

## HCL 로 Resource 정의 및 Provisioning
### 1. Resource 정의
1. Provider 정의
  ```
  provider "aws" {
    region  = "ap-northeast-2"
    profile = "ca07456"
  }
  ```
2. Resource 정의
3. 프로젝트 초기화
   terraform init
### 2. 생성가능한지 Plan 을 확인
- terraform plan
### 3. 선언된 Resource 을 Apply 함
- terraform apply

## 변수 사용
복잡하고 반복되는 작업들을 줄이기 위해 중복되는 값은 변수로 선언  
### Input variable (입력 변수)
- description : 변수에 대한 사용방법을 작성할 때 사용
- default : 변수값이 null 일 경우 사용하는 값
- type : 변수의 유형 지정
```
variable "NAME" {
  [CONFIG ...]
}
```
```
variable "http_port" {
  description = "This is HTTP Port!"
  type        = number
}

# list variable example
variable "list_vars" {
  description = "An example of a map in Terraform"
  type        = list(number)
  default     = [1, 2, 3]
}

# map variable example
variable "map_vars" {
  description = "An example of a map in Terraform"
  type        = map(string)
  default     = {
    key1 = "values1"
    key2 = "values2"
    key3 = "values3"
  }
}

# object example
variable "object_example_with_error" {
  description = "An example of a structural type in type in Terrraform with an error"
  type      = object({
    name    = string
    age     = number
    tags    = list(string)
    enabled = bool
  })
  default     = {
    name    = "values1"
    age     = 42
    tags    = ["a", "b", "c"]
    enabled = true
  }  
}
```
### 변수 지정 방식
- var : cli 에 옵션을 입력
- var-file : 옵션을 파일로 불러 들임
- TF_VAR_<name> : 환경 변수 지정 방식

#### 변수 참조
var.<VARIABLE_NAME>
```
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port  = var.server_port
    to_port    = var.server_port
    protocol   = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }
}
```

#### 문자열 리터럴 참조 - interplation
"{...}"

#### TF_VAR_<name>
```
export TF_VAR_server_port=8080
terrafrom plan
```

#### terraform -var "server_port=8080"
#### terraform -file-var

### 출력 변수
- description : 출력 변수에 어떤 유형의 데이터가 포함되어 있는지 알려 줌
- sensitive : true 로 설정하여 terraform apply 실행이 끝날 때 출력을 기록하지 않도록 terraform 에게 지시
```
output "<NAME>" {
  value = <VALUE>
  [CONFIG ...]
}
```

### 샘플 실행
#### Login 확인
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform> az login
A web browser has been opened at https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize. Please continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
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
PS D:\workspace\AzureBasic\1.IaaS\Terraform> az account show
{
  "environmentName": "AzureCloud",
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
PS D:\workspace\AzureBasic\1.IaaS\Terraform> 
```

#### terraform init
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform> terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 2.0"...
- Finding latest version of hashicorp/random...
- Installing hashicorp/azurerm v2.99.0...
- Installed hashicorp/azurerm v2.99.0 (signed by HashiCorp)
- Installing hashicorp/random v3.3.1...
- Installed hashicorp/random v3.3.1 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
PS D:\workspace\AzureBasic\1.IaaS\Terraform>
```

#### terraform plan
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform> terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = (known after apply)
    }

  # random_pet.rg-name will be created
  + resource "random_pet" "rg-name" {
      + id        = (known after apply)
      + length    = 2
      + prefix    = "rg"
      + separator = "-"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + resource_group_name = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
PS D:\workspace\AzureBasic\1.IaaS\Terraform> 
```

#### terraform apply
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform> terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = (known after apply)
    }

  # random_pet.rg-name will be created
  + resource "random_pet" "rg-name" {
      + id        = (known after apply)
      + length    = 2
      + prefix    = "rg"
      + separator = "-"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + resource_group_name = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
PS D:\workspace\AzureBasic\1.IaaS\Terraform> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = (known after apply)
    }

  # random_pet.rg-name will be created
  + resource "random_pet" "rg-name" {
      + id        = (known after apply)
      + length    = 2
      + prefix    = "rg"
      + separator = "-"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + resource_group_name = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_pet.rg-name: Creating...
random_pet.rg-name: Creation complete after 0s [id=rg-good-lynx]
azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 4s [id=/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-good-lynx]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

resource_group_name = "rg-good-lynx"
PS D:\workspace\AzureBasic\1.IaaS\Terraform> 
```

#### 결과 확인(terraform output)
```
PS D:\workspace\AzureBasic\1.IaaS\Terraform> terraform output
resource_group_name = "rg-good-lynx"
PS D:\workspace\AzureBasic\1.IaaS\Terraform> echo "$(terraform output resource_group_name)"
"rg-good-lynx"
PS D:\workspace\AzureBasic\1.IaaS\Terraform>
```



