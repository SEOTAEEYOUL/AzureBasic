# git

## 사용자 정보 입력
### git config -global : 특정 사용자(즉 현재 사용자)에게만 적용되는 설정
```
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

### 사용자 정보 보기
```
git config user.name
```

## .gitignore
프로젝트 작업시 로컬 환경의 정보나 빌드 정보등 원격 저장소에 관리하지 말아야되는 파일들에 대해서 지정하여 원격 저장소에 실수로 올라가지 않도록 관리하는 파일  
정의한 정보들에 해당하는 파일들에 대하여 git track하지 않도록 설정하는 역할을 한다.
- 보안상으로 위험성이 있는 파일  
- 프로젝트와 관계없는 파일
- 용량이 너무 커서 제외해야되는 파일

### 작성규칙
- '#'로 시작하는 라인은 무시한다.
- 표준 Glob 패턴을 사용한다.
- 슬래시(/)로 시작하면 하위 디렉터리에 적용되지(recursivity) 않는다.
- 디렉터리는 슬래시(/)를 끝에 사용하는 것으로 표현한다.
- 느낌표(!)로 시작하는 패턴의 파일은 무시하지 않는다.

### Example
```
## ignore all .un~
**/*.un~
**/*.*~
**/*~

# ignore all .class files
*.class

# exclude lib.class from "*.class", meaning all lib.class are still tracked
!lib.class

# ignore all json files whose name begin with 'temp-'
temp-*.json

# only ignore the build.log file in current directory, not those in its subdirectories
/build.log

# specify a folder with slash in the end
# ignore all files in any directory named temp
temp/

# ignore doc/notes.txt, but not doc/server/arch.txt
bin/*.txt

# ignore all .pdf files in the doc/ directory and any of its subdirectories
# /** matches 0 or more directories
doc/**/*.pdf
```



## 사용예
### 일반적인 동기화 후 변경 사항 올리기
```
PS > git add *
PS > git commit -m "2021-05-24"
[main f86690a] 2021-05-24
 3 files changed, 8 insertions(+), 2 deletions(-)
 create mode 100644 study/VPC.md
PS > git push
Enumerating objects: 12, done.
Counting objects: 100% (12/12), done.
Delta compression using up to 8 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (7/7), 747 bytes | 747.00 KiB/s, done.
Total 7 (delta 4), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (4/4), completed with 4 local objects.
To https://github.com/SEOTAEEYOUL/A-TCL-DA.git
   ae55972..f86690a  main -> main
```

## 충돌이 발생했을 때
### 로컬과 리모트의 내용이 틀릴때 "git pull" 이 안되는 경우
```
PS D:\workspace\AzureBasic> git pull
error: Pulling is not possible because you have unmerged files.
hint: Fix them up in the work tree, and then use 'git add/rm <file>'
hint: as appropriate to mark resolution and make a commit.
fatal: Exiting because of an unresolved conflict.
```
### "git status" 명령으로 로컬 저장소의 현재 branch 에 마지막으로 commit 된 내용과 현재 상태를 비교
```
PS D:\workspace\AzureBasic> git status
On branch main
Your branch and 'origin/main' have diverged,
and have 1 and 2 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Changes to be committed:
        new file:   2.AKS/AKS.md
        new file:   2.AKS/Bastion.md
        new file:   2.AKS/IngressController.md

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   1.IaaS/AzureCDN.md
```
### git commit -am "주석" 명령을 실행한 후 git pull 수행
```
PS > git commit -am "2022-01-25 status 후"
[main d23982e] 2022-01-25 status 후
PS D:\workspace\AzureBasic> git pull
Already up to date.
PS > git add *
PS > git commit -m "2022-01-25"
On branch main
Your branch is ahead of 'origin/main' by 2 commits.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
```
### 이후 정상적으로 git push
```
PS > git push
Enumerating objects: 35, done.
Counting objects: 100% (28/28), done.
Delta compression using up to 8 threads
Compressing objects: 100% (15/15), done.
Writing objects: 100% (15/15), 7.90 KiB | 1011.00 KiB/s, done.
Total 15 (delta 11), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (11/11), completed with 8 local objects.
To https://github.com/SEOTAEEYOUL/AzureBasic.git
   428a5a4..d23982e  main -> main
```
```
PS > git add *
PS > git commit -m "2022-02-25"
[main 4538627] 2022-02-25
 1 file changed, 16 insertions(+)
PS > git push
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 8 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 578 bytes | 144.00 KiB/s, done.
Total 4 (delta 3), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
To https://github.com/SEOTAEEYOUL/AzureBasic.git
   d23982e..4538627  main -> main
PS D:\workspace\AzureBasic>
```

### 많이 쓰이는 Git 명령어
|명령어| 설명 | 비고 |
|----------|------|------|
| .gitignore 파일 | git 에서 특정 파잉릉 무시하기 위한 목적으로 사용 | |
| git init | 저장소 초기화 | |
| git add  | 수정, 추가한 파일 선택 추가 | git add * </br> git add README.md </br> git add . |
| git commit | 수정된 영역 반영 | git commit -m "수정된 내용" |
| git remote add | Remote 저장소 연결 | git remote add origin https://gitea.skmta.net/tyseo/mta-infra.git |
| git push | commit 된 내용을 저장소에 올림 | git push </br> git push -u origin master # -u 옵션을 이용하면 다음 push 때 이전 히스토리를 기억하고 반영한다.</br> git push origin --tags # 모든 태그를 push </br> git push --set-upstream origin develop |  
| git branch | git branch 생성 및 보기 | git branch develop </br> git brach # 로컬 브랜치 목록 조회 </br> git branch -r # 원격 저장소 조회 </br> git branch -a # 로컬, 원격 저장소 모두 조회|
| git tag | 읽기 전용 Commit 의 개념으로 소프트웨어 버전을 릴리즈 할 때 사용 | git tag # 태그 목록 보기 </br> git tag v0.1 # 태그 생성 </br> git tag -a v0.1 -m "first tag 0.1" # Annotated 태그 생성 </br> git tag -l "v0.1" # 생성된 태그 확인 </br> git show-ref --tags |
| git log | 태그가 붙은 커밋에 대한 정보를 간략히 볼 때 사용 | git log --decorate -1 |
| git show | 태그가 붙은 커밋에 대한 정보를 보여줌 | git show v0.1 |
| git checkout | branch 바꾸기, 이동 | git checkout develop </br> git checkout -b develop # master branch 에서 develop 란 새로운 branch 를 만들어 갈아탐   </br> git checkout -b develop origin/stage # stage 라는 특정 branch 로 부터 새로운 branch 를 만듦 </br> git checkout master # master branch 로 바꿈 | 
| git pull | 코드를 받아와 변경점을 merge 함 </br> 코드를 받아온후 즉시 merge하여 코드를 반영하기 때문에 충돌이 일어 날수 있음 </br> | git pull |
| git fetch | 코드를 받아옴 | |
| git merge | branch 에서 작업한 내용 합치기 | git merge develop |
| git rebase | branch 에서 작업한 내용 합치기 </br> 특정 지점을 base로 옮겨 기존에 있던 Commit 를 재정렬 </br> merge 보다 선형적으로 작업 | git rebase develop |
| git clone | 리모트 repository 를 로컬에 다운로드 | git clone https://gitea.skmta.net/tyseo/mta-infra.git |
| git status | 이전 커밋과 비교해서 변경 내용을 표시  | git status |
| git config | 구성 보기, 변경 | git config -l </br> git config --global user.name "tyseo" # git 계정 Name 변경 |

---

#### Branch
* 브랜치는 작업이력의 가지를 나눠서 기록해주는 역할
* 브랜치 상의 변경은 통합(merge)될 때 까지 다른 브랜치에 영향을 끼치지 않고, 받지도 않음

#### Branch model
* 브랜치 모델은 브랜치를 어떻게 운영할 것인가에 대한 것
* git-flow와 github flow 가 일반적으로 유명

---

## Git Flow 
![Git Flow](https://about.gitlab.com/images/git_flow/gitdashflow.png)

### 브랜치 전략
* 항상 유지되는 메인 브랜치들(master, develop)과 일정 기간 동안만 유지되는 보조 브랜치들(feature, release, hotfix)가 있음
* 구버전 지원을 위한 support 는 기존 Git-flow 와 다른 응용 브랜치

| branch 명 | 설명 | 비고 |
|----------|------|------|
| master | 제품으로 출시될 수 있는 브랜치 | mta-prd |
| develop | 다음 출시 버전을 개발하는 브랜치 | mta-dev |
| feature | 기능을 개발하는 브랜치 | 일감 브랜치로 기능명으로 사용 |
| release | 이번 출시 버전을 준비하는 브랜치 | mta-stg |
| hotfix | 출시 버전에서 발생한 버그를 수정 하는 브랜치 | |

* 위의 비고와 같이 할 경우 release 의 경우도 항상 유지되는 메인 브랜치에 속함(개발, 스테이징, 운영) 
* 개발, 운영일 경우는 상시 유지되는 메인 브랜치들은 master, develop 이다.

#### master
* master 브랜치에 merge된 내역은 새로운 버전이 갱신되었다는 것을 의미한다.
* 즉 master 브랜치에 변경 내역이 생기면 최종 버전인 Tag를 통해 Production에 배포된다.
  * 배포 가능한 Quality 를 보증하는 브랜치
  * release 브랜치로 부터 머지되어 갱신
  * master 브랜치 상의 직접 작업한다거나 커밋하는 것은 NG
  * tag 는 master 브랜치상에서만 존재
    * tag : 보통 릴리즈 할 때 사용(v1.0 등)

#### develop
* hotfix를 제외한 모든 변경내역이 출발하는 지점이다.
* develop 브랜치의 코드가 안정화되고 배포할 준비가 되면 master를 통해 배포 버전의 태그를 단다.
  * 개발의 추축이 되는 브랜치 
  * master 브랜치로 부터 파생
  * master 브랜치와 마찬가지로 develop 브랜치 상의 직접 작업하거나 커밋하는 것은 NG
  * develop 브랜치로 부터 feature 브랜치나 release 브랜치를 만듦

#### feature
* feature 브랜치는 배포하려고 하는 기능을 개발하는 브랜치다.
* 기능을 개발하기 시작할 때는 언제 배포할 수 있을지 알 수 없다.
* 기능을 다 완성할 때까지 유지하고 있다가 다 완성되면 develop 브랜치로 병합한다.
  * 브랜치가 생성되는 대상 : develop
  * merge 대상: develop
  * 기능 추가 또는 수정 작업을 하기 위한 브랜치
  * develop 브랜치로부터 파생
  * 어떤 작업이 이루어진 브랜치인지 한 눈에 알 수 있도록 브랜치 이름을 작명
  * merge 되면 해당 feature 브랜치는 삭제

#### release
* release 브랜치는 실제 배포할 상태가 된 경우에 생성하는 브랜치다.
  * 브랜치가 생성되는 대상 : develop
  * merge 대상: develop, master

#### hotfix
* 미리 계획되지 않은 브랜치다.
* 기본적인 동작방식은 release와 비슷하다.
* 배포 이후에 생긴 치명적인 버그는 즉시 해결해야하기 때문에 문제가 생기면 master 브랜치에 만들어둔 태그tag로 부터 긴급수정을 위한 브랜치를 생성한다.
  * 배포가 끝난 것을 긴급 수정하기 위한 용도의 브랜치
  * master 브랜치로 부터 파생
  * 수정작업 완료 후에는 master 브랜치와 develop 브랜치에 merge
  * master 브랜치에 merge 할 때의 커밋은 배포할 때의 tag 를 사용
  * merge 된 hotfix 브랜치는 삭제
    * 브랜치가 생성되는 대상 : master
    * merge 대상 : develop, master

#### support
* 구버전을 서포트 하기 위한 브랜치
* 필수는 아니지만 구 버전을 서포트하는 필요가 있는 경우에는 master 브랜치의 tag 로 부터 support 브랜치를 파생
* 구 버전에서 버그가 발생하는 경우에는 support 브랜치 상의 디버깅 작업을 하고 커밋 실시
* 버그가 과거의 여러 버전에 걸쳐 있는 경우에는 수정 커밋은 대상의 모든 버전의 support 브랜치에 cherry-pick 실시
* 서포트가 완료되면 해당 support 브랜치는 삭제


---

## github flow
* 간략화 된 브랜치 운영 모델
* master, topic 2개의 브랜치로 운영

![github flow](https://miro.medium.com/max/583/0*6pT5H4vnujVLcy0S.png)

### 브랜치 전략

#### master
* 배포 가능한 퀄리티를 보증하는 브랜치
* git-flow 모델에서의 master + develop
* master 브랜치상에서 직접 작업을 하거나 커밋하는 것은 NG
* 배포 작업은 master 브랜치 상에서 실시
* release 브랜치는 사용 x

#### topic
* 기능 추가나 버그 수정을 하는 브랜치
* 파일 편집작업은 여기에서 실시
* master 브랜치로 부터 가지가 나뉘어 지는 유일한 브랜치
* git-flow 모델에서의 feature + hotfix
* master 브랜치에 머지된 topic 브랜치는 삭제

---

#### branch 생성/조회
| 구분     | 명령어| 비고 |
|----------|------|------|
| 생성 | git branch develop | |
| 조회 | git branch  | |
| 생성 + 변경(이동) | git checkout -b develop | develop 브랜치 생성 후 이동 |
| 이름 변경 | git branch -m develop tyseo | |
| git pull no tracking info 오류 해결 | git branch --set-upstream-to=origin/master | |
| 삭제 | git branch -d tyseo | |