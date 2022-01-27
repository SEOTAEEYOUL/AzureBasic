# 가상 네트워크(Virtual Network, VNet)

> [Azure Virtual Network FAQ(질문과 대답)](https://docs.microsoft.com/ko-kr/azure/virtual-network/virtual-networks-faq)  

## 구현 목적
- 리소스간 안전한 통신
- 온프레미스 인프라 리소스와의 안전한 통신
- 인터넷 아웃바운드 통신

## 주소공간
- [CIDR(Classless Inter-Domain Routing)](./CIDR.md) 표기 방법을 사용

### IP 사용 제한
SUBNET 당 5개 IP 주소
- x.x.x.0: 네트워크 주소
- x.x.x.1: 기본 게이트웨이
- x.x.x.2, x.x.x.3: Azure 에 예약된 Azure DNS IP 를 VNet 공간에 매핑
- x.x.x.255: /25 이상 크기의 서브넷에 대한 네트워크 브로드캐스트 주소, 더 작은 서브넷에서 다른 주소가 됨

### 최대/최소 크기(IPv4)
- 최대 '/8', 최소 '/29' 의 대역을 여러개 추가 가능
- 1개의 vNet 에 여러 대역의 CIDR 를 추가할 수 있음
  - 예) 하나의 vNet 에 '172.30.0.0/24', '192.18.0.1' 등 여러 CIDR 를 추가할 수 있음

### Ping, Tracerrouter 
- 기본 게이트웨이 Ping 사용 불가(VM 끼리 가능)
- tracert 사용 불가
  
### In/Outbund Traffic 흐름 제어
1. Subnet 혹은 NIC 에 Network Security Group 배포(무료)
2. Azure Firewall 배포
3. Azure Application Gateway의 WAF 기능 활성화(Stnadard 이상)  
4. Network Virtual Applicance(3rd Party 방화벽 등) 배포


### 주소 할당 방식
- 기본 주소 할당 방식은 동적 할당으로, 리소스의 상태 변경(VM 재시작 등)에 따라 바뀔수 있음
- 정적(고정) 할당한 경우 리소슬르 삭제하기 전까지 유지  

| IPv4 주소 유형 | 공인 IP | 사설 IP |  
|:---|:---|:---|  
| 용도 | Azure 리소스의 인터넷 인바운드 통신 | VNet 내부 리소스간, VNet 과 VNet 간, 클라우드 서비스와 VNet 리소스간 통신 |
| 자원 주소 범위 | 리소스 위치에서 사용 가능한 IP 주소 풀 | 10.0.0.0 ~ 10.255.255.255 </br> 172.16.0.0 ~ 172.31.255.255 </br> 192.168.0.0 ~ 192.168.255.255 |  
| 기본할당방식 | 기본 SKU: 동적 </BR> 표준 SKU: 정적(지정불가/) | 동적 |  

### public ip 를 static 으로 사용하는 경우
- DNS 이름 확인을 위해 A 레코드를 등록하는 경우
- Azure 리소스가 IP 기반 보안 모델을 사용하는 앱이나 서비스와 통신하는 경우
- IP 주소를 SSL 인증서에 연결하는 경우
- 방화벽 규칙에서 IP 범위를 사용해 트랙픽을 제어하는 경우
- 가상 머신이 도메인 컨트롤러나 DNS  서버 등의 역활을 하는 경우

---

## 설계원칙
1. VNet 주소공간(CIDR 블록) 이 다른 네트워크 범위와 켭치치 않아야 합니다.
2. 관리 노력을 줄이기 위해 다수의 작은 VNet 을 사용하기 보다 큰 VNet 을 사용하는 것이 좋습니다.

---

## 서브넷(subnet)  

### 이점
1. 네크워크 성능과 속도가 향상됨
   - subnet 을 통해 네트워크에 연결된 모든 장치에 브로드캐스트 패킷이 도달하지 않도록 제한해 Network 전체의 성능과 네트워크 간 스위칭 장치 성능을 향상 시킬 수 있음
2. 네트워크 정체를 줄임
   - 트래픽을 subnet 안으로 격리할 수 있음
3. 네트워크 보안을 향상 시킴
   - ACL 이나 QoS, 경로 테이블을 사용해 트래픽을 제어할 수 있어 위협을 확인하고 트래픽 대상을 쉽게 지정할 수 있음
4. 네트워크가 비대해지지 않게 함
   - 향 후 늘어나는 호스트 수를 고려해 네트워크의 수를 적절히 계산하여 사용
5. 관리가 용이함
   - 관리할 수 있는 호스트 수를 논리적으로 제한할 수 있음