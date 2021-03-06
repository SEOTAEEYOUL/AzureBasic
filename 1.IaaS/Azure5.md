# CDN 적용을 통한 고도화
3-tier 기본 환경에 CDN 적용, Azure DNS 설정, AppGateway 구성 변경
Upload
- Azure CDN 배포 및 구성
- 정상 동작 테스트
- apache 서버 삭제  

## 1. [Azure CDN 구성](./AzureCDN.md)  
- CDN 프로필 : skcc1-homepage-prd-cdn
- endpoint 생성
  - 호스트 이름 : skcc1-homepage-dev-cdn.azureedge.net
    - 프로토콜 : HTTP,HTTPS
    - 원본형식 : 사용자 지정 원본
    - www.nodespringboot.org

## 2. Tomcat 에 Apache 의 Static 문서 Copy
## 3. Application Gateway 백 엔드 풀 변경
#### 이름 : appgw-homepage-ap1-network-bepool
#### 백 엔드 대상 IP : Apache 에서 Tomcat 으로 변경
예) 10.0.0.7 (Apache Server Private IP) -> 10.1.0.4 (Tomcat Server Private IP)
![appgw-homepage-ap1-network-bepool-백엔드대상편집.png](./img/appgw-homepage-ap1-network-bepool-백엔드대상편집.png)  

### CDN 원본 그룹 만들기
원본 그룹 이름 : origin-homepage-grp-01
![CDN-원본그룹만들기.png](./img/CDN-원본그룹만들기.png)  

### 캐시규칙
쿼리 문자열 캐시 동작 : 각 고유한 URL 캐시
![CDN-캐시규칙.png](./img/CDN-캐시규칙.png)

### 캐시규칙
#### +규칙 추가
##### originHomepageGrp01Rule1
.do 를 캐시하지 않도록 함
전역 없음
![CDN-규칙엔진-originHomepageGrp01Rule1.png](./img/CDN-규칙엔진-originHomepageGrp01Rule1.png)  



## 4. [DNS 영역 변경](./AzureDNS.md)
### DNS 에 cdn 에 CDN endpoint 등록
#### 홈 > DNS 영역 > nodespringboot.org > " + 레코드 집합"
- 이름 : www  
- 유형 : CNAME - 하위 도메인을 다른 레코드에 연결  
- 별칭 : skcc1web.koreacentral.cloudapp.azure.com  

![DNS-nodesprintboot.org.png](./img/DNS-nodesprintboot.org.png)  

## 5. CDN 의 사용자 지정 도메인 추가
### 홈 > CDN 프로필 > skcc-network-cdn > 개요 > "+ 사용자 지정 도메인"  
"DNS 영역"에 추가 후 사용자 지정 도메인 ("www.nodespringboot.org" ) 설정  
![CDN-개요-사용자지정도메인.png](./img/CDN-개요-사용자지정도메인.png)



## 6. Browser 를 통한 정상 동작 확인  
- Cache 적용됨을 확인 : X-Cache: TCP_HIT 
  > [Microsoft의 Azure CDN에 대한 HTTP 헤더 디버그](https://docs.microsoft.com/ko-kr/azure/cdn/cdn-msft-http-debug-headers) 

### CDN 적용전 (Application Gateway 를 통한 호출)
![appgw.nodespringboot.org-books.do.png](./img/appgw.nodespringboot.org-books.do.png)  
![png-reply-header.png](./img/png-reply-header.png)  

### CDN 적용 후 (CDN 를 통한 호출 )
![www.nodespringboot.org-books.do-TCP-HIT.png](./img/www.nodespringboot.org-books.do-TCP-HIT.png)  
![X-Cache-TCP_HIT.png](./img/X-Cache-TCP_HIT.png)  