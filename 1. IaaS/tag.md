# Tag
Azure 리소스, 리소스 그룹 및 구독에 태그를 적용하여 논리적으로 분류에 활용 할 수 있음

## Tag 의 가이드라인
1. 태크 이름(키)의 최대 길이 : 512 자, 태그 값의 최대 길이 : 256자
2. 태그 이름에 포함할 수 없는 문자 : <, >, %, &, \, ?, /
3. 태그능 해당 리소스 그룹의 리소스에 상속되지 않은 리소스 그룹에 적용 가능
4. 태그 이름은 대소문자 구분이 없으며 태그값은 대소문자를 구분해야 함
5. 태깅은 반듯이 필요한 것만 사용하여 최소화 할 것
6. "필수" 항목 태그는 미 입력 시 리소스 생성 불가하도록 정책적용

## 필수 Tag
| 대상 | 태그 이름 | 태그 값 | 내용|
|:---|:---|:---|:---|
|Resource Group | servicetitle | 서비스 별 고유명사 | 서비스 명 |
|Resource Group | environment | 'prd', 'stg', 'dev', 'poc' | 운영 구분 |
|Resource Group | personalinformation | 'yes', 'no' | 개인정보 포함 여부 |

## 권장 태그
### Business
| 태그 이름 | Key | 설명 | 예제 값 |  
|:---|:---|:---|:---|  
| 비즈니스 단위 | BusinessUnit | 워크로드 또는 서비스의 Owner 가 속한 최상위 사업부 | |
| 부서 | Department | 워크로드 또는 서비스의 Owner 가 속한 하위팀 | |
| 생성자 | Creator | 워애플리케이션, 워크로드 또는 서비스의 생성자 | 사번 |
| 소유자 | Owner | 애플리케이션, 워크로드 또는 서비스의 소유자 | Kim, MinJun |
| 운영자 | Operator | 애플리케이션, 워크로드 또는 서비스의 운영자 | Kim, MinJun |
| 설명 | Description | 리소스에 대한 설명 | |  

### Technical
| 태그 이름 | Key | 설명 | 예제 값 |  
|:---|:---|:---|:---|  
| 역활 | ApplicationRole | 리소스의 역활 | web, was, db, app, if, batch |
| 모니터링 | Datadog | Datadog 사용 여부 | monitored |
| 지역 | Region | 배포되는 지역 | koce, koso |
| 버전 | ApplicationVersion | 배포된 애플리케이션 및 리소스의 버전을 식별 | v1.0 |

### Security  
| 태그 이름 | Key | 설명 | 예제 값 |  
|:---|:---|:---|:---|  
| 기밀성 | Confidentiality | 취급 데이터의 기밀성 | Internal Use Only |
