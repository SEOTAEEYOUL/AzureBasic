# [Azure DNS](https://docs.microsoft.com/ko-kr/azure/dns/dns-overview)  
Microsoft Azure 인프라를 사용하여 이름 확인을 제공하는 DNS 도메인에 대한 호스팅 서비스


## DNS 영역 만들기
```powershell
New-AzDnsZone -Name nodespringboot.org `
  -ResourceGroupName rg-skcc-homepage-dev
```
```bash
az network dns zone create `
  -g rg-skcc-homepage-dev `
  -n nodespringboot.org
```

## DNS 레코드 만들기
- 레코드 : www
- domain : nodespringboot.org
- TTL : 300
- ipaddress : 10.10.10.10
```powershell
New-AzDnsRecordSet -Name www `
  -RecordType A `
  -ZoneName nodespringboot.org `
  -ResourceGroupName rg-skcc-homepage-dev `
  -Ttl 300 `
  -DnsRecords (New-AzDnsRecordConfig -IPv4Address "10.0.0.4")
```
### 수행 결과
```powershell
PS C:\workspace\AzureBasic\1.IaaS> New-AzDnsRecordSet -Name www `
>>   -RecordType A `
>>   -ZoneName nodespringboot.org `
>>   -ResourceGroupName rg-skcc-homepage-dev `
>>   -Ttl 300 `
>>   -DnsRecords (New-AzDnsRecordConfig -IPv4Address "10.0.0.4")


Id                : /subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-skcc-homepage-dev/providers/Microsoft.Network/dnszones/nodespringboot.org/A/www
Name              : www
ZoneName          : nodespringboot.org
ResourceGroupName : rg-skcc-homepage-dev
Ttl               : 300
Etag              : 82cea57a-23c9-4065-abe5-ac753a9eb77a
RecordType        : A
TargetResourceId  : 
Records           : {10.0.0.4}
Metadata          : 
ProvisioningState : Succeeded
```
```bash
az network dns record-set a add-record `
  -g rg-skcc-homepage-dev `
  -z nodespringboot.org `
  -n www -a 10.10.10.10
```
![dns-zone-www.png](./img/dns-zone-www.png)

## 레코드 보기
```powershell
Get-AzDnsRecordSet -ZoneName nodespringboot.org `
  -ResourceGroupName rg-skcc-homepage-dev `
  -RecordType ns
```
```bash
az network dns record-set list `
  -g rg-skcc-homepage-dev `
  -z nodespringboot.org
```

## 샘플
- [비정상 DNS 레코드 찾기](abnormal-dns-record.ps1)
