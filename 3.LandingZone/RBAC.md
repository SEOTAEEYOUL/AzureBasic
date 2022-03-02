# RBAC(Role-Based Access Control)  
### RBAC(Role-Based Access Control)
- RBAC이란 사용자, 그룹 또는 Azure 리소스 등의 보안주체에게 역할을 할당  
- 할당된 역할에 정의된 권한으로 서비스를 이용  

### ID 및 액세스 관리(IAM, Identity and Access Managmenet)
- Azure Active Directory : 클라우드 및 하이브리드 환경에 ID 및 액세스 관리 기능 제공  

### [Azure 기본 제공 역활](https://docs.microsoft.com/ko-kr/azure/role-based-access-control/built-in-roles)  
|기본 제공 역활 | 설명 |  
|:---|:---|
| 소유자(Owner) |액세스 권한을 다른 사용자에게 위임할 수 있는 권한을 포함하여 모든 리소스에 대한 전체 액세스 권을 보유 |  
| 기여자(Contributor) | 모든 유형의 Azure 리소스를 만들고 관리할 수 있지만 다른 사용자에게 액세스 권한을 부여할 수 없음 |  
| 읽기 권한자(Reader) | 리소스를 볼 수 있음 |  
| 사용자 액세스 관리자(User Access Administrator) | Azure 리소스에 대한 사용자 액세스를 관리 |  


### RBAC 구현
#### 사용자 역할을 기반으로 권한을 관리하고 적용
**Security Principal - 보안 주체 정의**
- 사용자, 그룹 등

**Role Definition - 역할 정의**
- 예) 네트워크 담당자 - 필요 권한 정의

**Scope - 범위 지정**
- Management Group 적용 / 구독레벨 적용

**보안주체에게 역활과 범위를 할당**
- 예) 네트워크 담당자 - 전체 N/W 에 대한 생성/변경/삭제

### Custom Role
- Built-in Role 은 Management Group 레벨 적용 가능  
  - Built-in Role 매뉴얼 적용  
- Custom Role 은 구독(Subscription) 레벨만 적용 가능  
  - Custom Role 생성 ARM Template 적용   

| Custom Role | 설명 |  
|:---|:---|  
| Serivce Owner Role | 해당 구독의 모든 권한을 가지지만 Network 관련 생성/변경/삭제 권한 제한 |  
| Service Contributor | 리소스의 생성/수정/삭제를 담당하지만 Network 관련 생성/삭제 제한 |  
| Database Admin Role | Azure PaaS DB 제품들의 모든 권한을 가지지만 일부 Network, 보안권한 제한 |  

※ ARM Template 에서 actions 와 notActions 세부항목으로 권한 정의


