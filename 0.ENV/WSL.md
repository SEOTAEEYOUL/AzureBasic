# WSL(Windows Subsystem for Linux)  
Linux용 Windows 하위 시스템을 사용하면 개발자가 기존 가상 머신의 오버헤드 또는 듀얼 부팅 설정 없이 대부분의 명령줄 도구, 유틸리티 및 애플리케이션을 비롯한 GNU/Linux 환경을 수정하지 않고 Windows에서 직접 실행할 수 있습니다.  

※ WSL2 : 파일 시스템 성능을 높이고전체 시스템 호출 호환성을 추가

## WSL
### [WSL 설치](https://docs.microsoft.com/ko-kr/windows/wsl/install)  
```powershell
wsl --install
```

### [이전 버전 WSL의 수동 설치 단계](https://docs.microsoft.com/ko-kr/windows/wsl/install-manual) - 수동설치  
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart  
wsl --set-default-version 2

# 배포한 설치
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
```

#### [WSL 1과 WSL 2 비교](https://docs.microsoft.com/ko-kr/windows/wsl/compare-versions)  

## Terminal
### [Windows 터미널 설치 및 설정 시작](https://docs.microsoft.com/ko-KR/windows/terminal/install)  
[Windows 터미널의 동적 프로필](https://docs.microsoft.com/ko-KR/windows/terminal/dynamic-profiles)  


