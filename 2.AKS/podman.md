# podman

## 설치(ubuntu 1.18)
```
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository -y ppa:projectatomic/ppa
sudo apt-get install podman -y
```
```
podman info
```

## podman 으로 ACR 에 push/pull 하기
- docker 와 사용법은 동일
- ACR(Azure Container Repository)에 접근하기 위해서는 login 이 필요
### container build 하기
    ```
    podman build --rm=true --network=host --tag nodejs-bot:1.1.0 .
    ```
### container tag 달기
    ```
    podman tag nodejs-bot:1.1.0 acrchatops.azurecr.io/nodejs-bot:1.1.0
    ```
### docker push
  - acr token 얻기
    ```
    az acr login -n acrChatOps --expose-token
    ```
  - acr login
    ```
    podman login acrchatops.azurecr.io --username 00000000-0000-0000-0000-000000000000 -p "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjQ1NlA6WjNCRjpCQ0tPOkpUN0w6MlNLSTpVQUpZOkRCSU46VU5KWTpHWUZHOjdMQTI6WUpNSzpWUkVaIn0.eyJqdGkiOiJiNzE5Njk3MS05Mjk2LTQ3NTItYTRmYi1jNTdmMzgzOWM5ZWIiLCJzdWIiOiJsank2MTZAYW5hYmFyYWxzay5vbm1pY3Jvc29mdC5jb20iLCJuYmYiOjE2MjU0NTAwMDgsImV4cCI6MTYyNTQ2MTcwOCwiaWF0IjoxNjI1NDUwMDA4LCJpc3MiOiJBenVyZSBDb250YWluZXIgUmVnaXN0cnkiLCJhdWQiOiJhY3JjaGF0b3BzLmF6dXJlY3IuaW8iLCJ2ZXJzaW9uIjoiMS4wIiwicmlkIjoiNzQzZTJkNjQ2YmFmNDdhYzliZTJlNzQ0ZTEyNjg1Y2MiLCJncmFudF90eXBlIjoicmVmcmVzaF90b2tlbiIsImFwcGlkIjoiMDRiMDc3OTUtOGRkYi00NjFhLWJiZWUtMDJmOWUxYmY3YjQ2IiwidGVuYW50IjoiZTJlZjgxMDQtN2VjMi00NDJmLWFlZTctN2Y4YzM4ZDNkODdkIiwicGVybWlzc2lvbnMiOnsiYWN0aW9ucyI6WyJyZWFkIiwid3JpdGUiLCJkZWxldGUiXSwibm90QWN0aW9ucyI6bnVsbH0sInJvbGVzIjpbXX0.hBJBQHwHXXGoII_WDRHPFOnIt_Cj-1CiFK5AXV49oW2X3rQxtUg9yM4khFgNuLVDZO2ktTQOtgmaZb5sDkYB0yLYndetJBOKKpLCqLIhzjxYnSA8wp0K8LIn9_Yix4QsEdU7w1d8cew-Fl0k7-o4zsiyPbTQ2HdMpnKsfbXopNudTmmk3znGsh6ZTdrZhR9qKlZGBxX6tH_gesYSEVC0dM_PdVRrePtJGFmXgTa4ISsiqjwIm6oROkoqOVsrGbnCiprukAWRXI1pSz9mOFD1YXvhnyoFHtirIkQwrFvN9yQdMkNFDLnCBLKUF1qEQM17lGyozEyrKbYRMYwwdBjg0Q"
    ```
  - container image push
    ```
    podman push acrchatops.azurecr.io/nodejs-bot:1.1.0
    ```

## harbor
## login
### login
```
$ podman login registry.chatops.ga
Username: admin
Password:
Login Succeeded!
```
### 정보 확인
```
$ cat /run/user/`id -u`/containers/auth.json
{
        "auths": {
                "registry.chatops.ga": {
                        "auth": "YWRtaW46Q2hhdE9wczAxIQ=="
                }
        }
}
```

## push

### tag
```
podman tag localhost/nodejs-bot:1.0.0 registry.chatops.ga/app/nodejs-bot:1.0.0
### push
- harbor 에 로그인해서 먼저 project 를 만들어 주어야 함
```
![harbor-project.png](./img/harbor-project.png)  

```
$ podman push registry.chatops.ga/app/nodejs-bot:1.0.0
```
```
Getting image source signatures
Copying blob f70713405493 done
Copying blob 267090b0ca6c done
Copying blob dcad94415578 done
Copying blob 54186556e54b done
Copying blob dc9baddfe85f done
Copying blob 89169d87dbe2 done
Copying blob 7c191ee1fb66 done
Copying blob 102c926c7ae2 done
Copying blob c8992e9a0045 done
Copying blob 5f70bf18a086 done
Copying blob 02fc894e6902 done
Copying blob e2a46da99419 done
Copying blob fbc0fa91ef23 done
Copying blob 6c17768cf843 done
Copying blob a85a5c464dc3 done
Copying blob 5bda30359381 done
Copying blob 3f7187d46c05 done
Copying blob 82c28daab6e3 done
Copying blob ae827f87abe4 done
Copying blob 20a05b738f9d done
Copying blob d4add955fac4 done
Copying blob 933011da1ddc done
Copying blob 7a917f164a42 done
Copying blob 47bcdde6abea done
Copying config 8bbf9fe29a done
Writing manifest to image destination
Storing signatures
```
![harbor-app-nodejs.png](./img/harbor-app-nodejs.png)
