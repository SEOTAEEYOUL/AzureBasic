# CDN 적용을 통한 고도화
3-tier 기본 환경에 CDN 적용, Azure DNS 설정, AppGateway 구성 변경
Upload
- Azure CDN 배포 및 구성
- 정상 동작 테스트
- apache 서버 삭제  

## [Azure CDN 구성](./AzureCDN.md)  
- CDN 프로필 : skcc1-homepage-prd-cdn
- endpoint 생성
  - 호스트 이름 : skcc1-homepage-dev-cdn.azureedge.net
    - 프로토콜 : HTTP,HTTPS
    - 원본형식 : 사용자 지정 원본
    - www.domain.com

## [DNS 영역 변경](./AzureDNS.md)

## Browser 를 통한 정상 동작 확인  
- Cache 적용됨을 확인 : X-Cache: TCP_HIT 
  > [Microsoft의 Azure CDN에 대한 HTTP 헤더 디버그](https://docs.microsoft.com/ko-kr/azure/cdn/cdn-msft-http-debug-headers)