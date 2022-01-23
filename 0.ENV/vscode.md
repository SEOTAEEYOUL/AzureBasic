# [Visual Studio Code](https://code.visualstudio.com/download)  

- IntelliSense, Debugging, Built-in Git, Extensions 등 다양한 기능들을 제공

[LINK]
[VS Code Tips and Tricks](https://github.com/Microsoft/vscode-tips-and-tricks?wt.mc_id=DX_881390#extension-recommendations)

## 확장팩  
[Extensions for the Visual Studio family of products](https://marketplace.visualstudio.com/vscode)  
[Extensions for Azure DevOps](https://marketplace.visualstudio.com/azuredevops)  

### 기본 확장팩 추천  

> [Korean Language Pack for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-ko)  
> [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme), [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)  
> [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)  
> [Bracket Pair Colorizer 2](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2)  
> [indent-rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)  
> [Auto Rename Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag)  
> [Auto close Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-close-tag)  
> [CSS Peek](https://marketplace.visualstudio.com/items?itemName=pranaygp.vscode-css-peek) : Ctrl 키로 누른 상태에서 클릭시 정의된 CSS 로 이동  
> [HTML CSS Support](https://marketplace.visualstudio.com/items?itemName=ecmel.vscode-html-css) : html 에서 css 자동 완성 이용  
> [HTML to CSS autocompletion](https://marketplace.visualstudio.com/items?itemName=solnurkarim.html-to-css-autocompletion)
> [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
> [Active File In StatusBar](https://marketplace.visualstudio.com/items?itemName=RoscoP.ActiveFileInStatusBar)  
> [REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)  
> [TODO Highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight)  
> [TypeScript Extension Pack](https://marketplace.visualstudio.com/items?itemName=loiane.ts-extension-pack)  
> [vscode-icons](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons)
> [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)  
> [Rainbow Brackets](https://marketplace.visualstudio.com/items?itemName=2gua.rainbow-brackets)  
> [Base16 Themes](https://marketplace.visualstudio.com/items?itemName=AndrsDC.base16-themes)  
> [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)  
> [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)  
> [Print](https://marketplace.visualstudio.com/items?itemName=pdconsec.vscode-print)  

### Git 확장팩  

> [gitignore](https://marketplace.visualstudio.com/items?itemName=codezombiech.gitignore)  
> [GitLens — Git supercharged](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)  
> [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)  

### Python 확장팩  

[Visual Studio Code를 사용하여 Python 초보자 개발 환경 설정](https://docs.microsoft.com/ko-kr/learn/modules/python-install-vscode/)  
[Pylance: The best Python extension for VS Code](https://towardsdatascience.com/pylance-the-best-python-extension-for-vs-code-ae299f35548c)

### Azure  
> [Azure CLI Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azurecli)  
> [Azure Account](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)  
> [Azure Resources](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureresourcegroups)  
> [Azure Resource Manager (ARM) Tools](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools)  
> [Azure Terraform](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform)  
> [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)  
> [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)  
> [Azure Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack)  


## 단축키  

- Ctrl + Shift + P : Command Palette (명령 팔레트)
- Ctrl + , : 설정
  - tab : 2, Quote Stye : single
- Ctrl + Shift + X : 확장  
- Ctrl + ` : 터미널 설정/해제
- Ctrl + P : 파일로 이동  
- Ctrl + Shift + F : 파일에서 찾기  
- F5 : 디버깅 시작 
- F12 : 정의된 곳으로 가기 (Ctrl + click) 

## 1.56.2 : 일부 windows 에서 webview 오류 발생시 대체 방업
### 오류 메시지
```
Error loading webview: Error: Could not register service workers: TypeError: Failed to register a ServiceWorker for scope ('vscode-webview://91baa7a6-f635-4dd1-8051-ab37a74ec2cb/') with script ('vscode-webview://91baa7a6-f635-4dd1-8051-ab37a74ec2cb/service-worker.js?platform=electron&id=91baa7a6-f635-4dd1-8051-ab37a74ec2cb&vscode-resource-origin=https%3A%2F%2F91baa7a6-f635-4dd1-8051-ab37a74ec2cb.vscode-webview-test.com'): ServiceWorker cannot be started.
```

### 조치 방법 : 아래 코드로 실행
```
code --no-sandSbox
```