# Visual Studio Code

## Plugin
[Print](https://marketplace.visualstudio.com/items?itemName=pdconsec.vscode-print)  

## 1.56.2 : 일부 windows 에서 webview 오류 발생시 대체 방업
### 오류 메시지
```
Error loading webview: Error: Could not register service workers: TypeError: Failed to register a ServiceWorker for scope ('vscode-webview://91baa7a6-f635-4dd1-8051-ab37a74ec2cb/') with script ('vscode-webview://91baa7a6-f635-4dd1-8051-ab37a74ec2cb/service-worker.js?platform=electron&id=91baa7a6-f635-4dd1-8051-ab37a74ec2cb&vscode-resource-origin=https%3A%2F%2F91baa7a6-f635-4dd1-8051-ab37a74ec2cb.vscode-webview-test.com'): ServiceWorker cannot be started.
```

### 조치 방법 : 아래 코드로 실행
```
code --no-sandSbox
```