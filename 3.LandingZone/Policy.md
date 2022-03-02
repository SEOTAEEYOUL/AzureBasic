# 정책(Policy )
- Azure 에서 제공하는 정책(Policy)은 조직의 표준을 적용하고 준수여부를 평가하는 기능  
- 기존에 정의된 정책을 적용하거나 원하는 수준의 사용자 정의 정책을 정의하여 관리그룹, 구독 또는 리소스그룹 단위에 적용 할 수 있음
- 준수여부를 평가하여 추가, 감사, 거부, 배포를 트리거 할 수 있음
- 리소스 생성 시 특정 정책의 거부에 해당할 경우 리소스 생성이 불가하며 정책에 맞게 수정하여 배포해야 함


## Policy 구현
### 엔터프라이즈 레별 규정준수 적용
- 대상 : 할당된 정책 범위의 모든 리소스
- 예시 : 리소스 태깅 준수, 특정 SKU의 리소스만 생성, 특정 지역의 리소스만 생성
- Enforcement & Complicance : Built-in Policy 및 Custom Policy 적용 가능, 실시간 준수여부 확인
- Apply policies at Scale : Management Group 에 적용 및 상속 가능, Policy 묶음 다발인 Initiative 사용, 개별 Definition 사용, Exclusion Scope 가능
- Deny: 비준수 리소스 생성 불가
- Audit : 비준수 리소스 감사로깅
- Remediation : 비준수 리소스 보정가능

## 정책 목록  
| No. | Type | 이름 | 평가 |  
|:---|:---|:---|:---|  
| 1	| Built-In | 가상 머신에서 관리 포트를 닫아야 합니다. |	감사 | 
| 2	| Built-In | 가상 머신에서 IP 전달을 사용하지 않도록 설정해야 합니다. |	감사 |  
| 3	| Built-In | 관리 되는 디스크를 사용 하지 않는 VM이 있는지 감사합니다. | 감사 | 
| 4	| Built-In | 스토리지 계정은 네트워크 액세스를 제한해야 합니다.	| 감사 |  
| 5	| Built-In | Network Watcher를 사용하도록 설정해야 합니다. | 감사 |  
| 6	| Built-In | Key Vault의 진단 로그를 사용하도록 설정해야 합니다. | 감사 |  
| 7	| Built-In | Azure Cosmos DB 계정에 방화벽 규칙이 있어야 합니다. | 감사 |  
| 8	| Built-In | Azure SQL Database에서 공용 네트워크 액세스를 사용하지 않도록 설정해야 합니다.	| 감사 |  
| 9	| Built-In | PostgreSQL 서버에 대해 공용 네트워크 액세스를 사용하지 않도록 설정해야 합니다. | 감사 |  
| 10 | Built-In | MySQL 서버에 대해 공용 네트워크 액세스를 사용하지 않도록  설정 해야 합니다.	 | 감사 |
| 11 |	Built-In | MariaDB 서버에 대해 공용 네트워크 액세스를 사용하지 않도록 설정해야 합니다.	| 감사 |
| 12 |	Built-In | 컨테이너 레지스트리는 무제한 네트워크 액세스를 허용해서는 안 됩니다. | 	감사 | 
| 13 |	Built-In | 컨테이너 레지스트리는 프라이빗 링크를 사용해야 합니다. | 감사 |
| 14 |	Built-In | Cognitive Services 계정은 네트워크 액세스를 제한해야 합니다. | 감사 |  
| 15 |	Built-In | 쓰기 권한이 있는 외부 계정을 구독에서 제거해야 합니다.| 감사 | 
| 16 |	Built-In | 읽기 권한이 있는 외부 계정을 구독에서 제거해야 합니다. | 감사 |
| 17 |	Built-In | 구독에서 쓰기 권한이 있는 계정에 MFA를 사용하도록 설정해야 합니다.	 | 감사 | 
| 18 |	Built-In | 구독에서 소유자 권한이 있는 계정에 MFA를 사용하도록 설정 해야 합니다. | 	감사 | 
| 19 |	Built-In | 구독에서 읽기 권한이 있는 계정에 MFA를 사용하도록 설정해야 합니다. | 	감사 |  
| 20 |	Built-In | 인터넷에서 RDP 액세스를 차단해야 합니다. | 감사 |
| 21 |	Built-In | 인터넷에서 SSH 액세스를 차단해야 합니다. | 감사 |
| 22 |	Built-In | 서브넷을 네트워크 보안 그룹과 연결해야 합니다. | 감사 | 
| 23 |	Built-In | 인터넷 연결 가상 머신은 네트워크 보안 그룹과 함께 보호 되어야  합니다. | 	감사 |  
| 24 |	Built-In | 인터넷 연결 엔드포인트를 통한 액세스를 제한해야 합니다. | 감사 |  
| 25 |	Built-In | Application Gateway에 대해 WAF(웹 애플리케이션 방화벽)를 사용하도록 설정해야 함 | 	감사 | 
| 26 |	Custom | 소유자, 기여자, 사용자 액세스 관리자, 정책 참여자 및 보안 | 관리 |자의 권한을 거부합니다. (단, Azure 에 의해 자동생성 되는 계정은 제외) | 	거부 |
| 27 |	Custom | 리소스 그룹에 태그와 해당 값이 필요합니다.(environment) | 감사 | 
| 28 |	Custom | 리소스에 태그와 해당 값이 필요합니다.(personalinformation)	| 감사 |
| 29 |	Custom | 리소스 그룹에 태깅을 해야 합니다.(servicetitle) | 감사 |
| 30 |	Custom | NSG가 생성될 때 flow log를 Blob으로 전송하는 설정을 자동으로 추가합니다. | 배포 |  
| 31 |	Built-In | 리소스 그룹에서 태그 상속 (servicetitle) | 배포 |
| 32 |	Built-In | 리소스 그룹에서 태그 상속 (environment) | 배포 |  
| 33 |	Built-In | 리소스 그룹에서 태그 상속 (personalinformation) | 배포 | 
| 34 |	Custom | 활동로그의 진단설정 수정은 거부됩니다. | 거부 |

