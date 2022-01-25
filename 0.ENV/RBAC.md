# RBAC(Role Based Access Control)
> [Azure RBAC(Azure 역할 기반 액세스 제어)란?](https://docs.microsoft.com/ko-kr/azure/role-based-access-control/overview)

![rbac-least-privilege.png](./img/rbac-least-privilege.png)

## 기본 제공 역할
| 기본 제공 역활 | 설명 | |
|:---|:---|:---|
| Admin  | Azure 리소스에 대한 사용자 액세스를 관리할 수 있습니다. | |
| Contributors  | 모든 리소스를 관리할 수 있는 모든 권한을 부여하지만, Azure RBAC에서 역할 할당, Azure Blueprints에서 할당 관리 또는 이미지 갤러리 공유를 허용하지 않습니다. | |
| Owner  | Azure RBAC에서 역할을 할당하는 기능을 포함하여 모든 리소스를 관리할 수 있는 모든 권한을 부여합니다. | |
| Readers  | 모든 리소스를 볼 수 있지만 변경할 수는 없습니다. | |