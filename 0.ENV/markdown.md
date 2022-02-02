# MarkDown
- 쉽고 빠르게 스타일문서를 작성
- 깃헙의 저장소Repository에 관한 정보를 기록(README.md)  
- 설치방법, 소스코드 설명, 이슈 등을 간단하게 기록하고 가독성을 높일 수 있음
![Markdown-mark.png](./img/Markdown-mark.png)
<img src=./img/Markdown-mark.png height=30>


## 장점
1. 문법이 쉽다.
2. 관리가 쉽다.
3. 지원 가능한 플랫폼과 프로그램이 다양하다.

## 단점
1. 표준이 없다.
2. 표준이 없기 때문에 도구에 따라서 변환방식이나 생성물이 다르다.
3. 모든 HTML 마크업을 대신하지 못한다.

## 문법
### Header
* 큰제목: 문서 제목
    ```
    This is an H1
    =============
    ```
    This is an H1
    =============

* 작은제목: 문서 부제목
    ```
    This is an H2
    -------------
    ```
    This is an H2
    -------------

    * 글머리: 1~6까지만 지원
```
# This is a H1
## This is a H2
### This is a H3
#### This is a H4
##### This is a H5
###### This is a H6
```
# This is a H1
## This is a H2
### This is a H3
#### This is a H4
##### This is a H5
###### This is a H6
####### This is a H7(지원하지 않음)

### BlockQuote
이메일에서 사용하는 ```>``` 블럭인용문자를 이용한다.
```
> This is a first blockqute.
>	> This is a second blockqute.
>	>	> This is a third blockqute.
```
> This is a first blockqute.
>	> This is a second blockqute.
>	>	> This is a third blockqute.

이 안에서는 다른 마크다운 요소를 포함할 수 있다.
> ### This is a H3
> * List
>	```
>	code
>	```

### 목록
### ● 순서있는 목록(번호)
순서있는 목록은 숫자와 점을 사용한다.
```
1. 첫번째
2. 두번째
3. 세번째
```
1. 첫번째
2. 두번째
3. 세번째

**현재까지는 어떤 번호를 입력해도 순서는 내림차순으로 정의된다.**
```
1. 첫번째
3. 세번째
2. 두번째
```
1. 첫번째
3. 세번째
2. 두번째

딱히 개선될 것 같지는 않다. 존 그루버가 신경안쓰고 있다고...

### ● 순서없는 목록(글머리 기호: `*`, `+`, `-` 지원)
```
* 빨강
  * 녹색
    * 파랑

+ 빨강
  + 녹색
    + 파랑

- 빨강
  - 녹색
    - 파랑
```
* 빨강
  * 녹색
    * 파랑

+ 빨강
  + 녹색
    + 파랑

- 빨강
  - 녹색
    - 파랑

혼합해서 사용하는 것도 가능하다(내가 선호하는 방식)

```
* 1단계
  - 2단계
    + 3단계
      + 4단계
```

* 1단계
  - 2단계
    + 3단계
      + 4단계

## 코드
4개의 공백 또는 하나의 탭으로 들여쓰기를 만나면 변환되기 시작하여 들여쓰지 않은 행을 만날때까지 변환이 계속된다.

### 들여쓰기
```
This is a normal paragraph:

    This is a code block.
    
end code block.
```

실제로 적용해보면,

적용예:

*****
This is a normal paragraph:

    This is a code block.

end code block.
*****

> 한줄 띄어쓰지 않으면 인식이 제대로 안되는 문제가 발생합니다.

```
This is a normal paragraph:
    This is a code block.
end code block.
```

적용예:

*****
This is a normal paragraph:
    This is a code block.
end code block.
*****

### 코드블럭
코드블럭은 다음과 같이 2가지 방식을 사용할 수 있습니다:

* `<pre><code>{code}</code></pre>` 이용방식

```
<pre>
<code>
public class BootSpringBootApplication {
  public static void main(String[] args) {
    System.out.println("Hello, Honeymon");
  }

}
</code>
</pre>
```

<pre>
<code>
public class BootSpringBootApplication {
  public static void main(String[] args) {
    System.out.println("Hello, Honeymon");
  }
}
</code>
</pre>

* 코드블럭코드("\```") 을 이용하는 방법

<pre>
<code>
```
public class BootSpringBootApplication {
  public static void main(String[] args) {
    System.out.println("Hello, Honeymon");
  }
}
```
</code>
</pre>

```
public class BootSpringBootApplication {
  public static void main(String[] args) {
    System.out.println("Hello, Honeymon");
  }
}
```

**깃헙**에서는 코드블럭코드("\```") 시작점에 사용하는 언어를 선언하여 [문법강조(Syntax highlighting)](https://docs.github.com/en/github/writing-on-github/creating-and-highlighting-code-blocks#syntax-highlighting)이 가능하다.

<pre>
<code>
```java
public class BootSpringBootApplication {
  public static void main(String[] args) {
    System.out.println("Hello, Honeymon");
  }
}
```
</code>
</pre>

```java
public class BootSpringBootApplication {
  public static void main(String[] args) {
    System.out.println("Hello, Honeymon");
  }
}
```


## 수평선 ```<hr/>```
아래 줄은 모두 수평선을 만든다. 마크다운 문서를 미리보기로 출력할 때 *페이지 나누기* 용도로 많이 사용한다.

```
* * *

***

*****

- - -

---------------------------------------
```

* 적용예
* * *

***

*****

- - -

---------------------------------------


## 링크
* 참조링크

```
[link keyword][id]

[id]: URL "Optional Title here"

// code
Link: [Google][googlelink]

[googlelink]: https://google.com "Go google"
```

Link: [Google][googlelink]

[googlelink]: https://google.com "Go google"

* 외부링크
```
사용문법: [Title](link)
적용예: [Google](https://google.com, "google link")
```
Link: [Google](https://google.com, "google link")

* 자동연결
```
일반적인 URL 혹은 이메일주소인 경우 적절한 형식으로 링크를 형성한다.

* 외부링크: <http://example.com/>
* 이메일링크: <address@example.com>
```

* 외부링크: <http://example.com/>
* 이메일링크: <address@example.com>

## 강조
```
*single asterisks*
_single underscores_
**double asterisks**
__double underscores__
~~cancelline~~
```

* *single asterisks*
* _single underscores_
* **double asterisks**
* __double underscores__
* ~~cancelline~~

> ```문장 중간에 사용할 경우에는 **띄어쓰기** 를 사용하는 것이 좋다.```   
> 문장 중간에 사용할 경우에는 띄어쓰기를 사용하는 것이 좋다.


## 이미지
```
![Alt text](/path/to/img.jpg)
![Alt text](/path/to/img.jpg "Optional title")
```
![Azure](./img/Azure.jpg)
![Azure](./img/Azure.jpg "Azure")

사이즈 조절 기능은 없기 때문에 ```<img width="" height=""></img>```를 이용한다.

예
```
<img src="./img/Azure.jpg" width="450px" height="300px" title="px(픽셀) 크기 설정" alt="Azure"></img><br/>
<img src="./img/Azure.jpg" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="Azure"></img>
```

<img src="./img/Azure.jpg" width="450px" height="300px" title="px(픽셀) 크기 설정" alt="Azure"></img><br/>
<img src="./img/Azure.jpg" width="40%" height="30%" title="%(비율) 크기 설정" alt="Azure"></img>

## 줄바꿈
3칸 이상 띄어쓰기(` `)를 하면 줄이 바뀐다.

```
* 줄 바꿈을 하기 위해서는 문장 마지막에서 3칸이상을 띄어쓰기해야 한다. 
이렇게

* 줄 바꿈을 하기 위해서는 문장 마지막에서 3칸이상을 띄어쓰기해야 한다.___\\ 띄어쓰기
이렇게
```

* 줄 바꿈을 하기 위해서는 문장 마지막에서 3칸이상을 띄어쓰기해야 한다. 이렇게

* 줄 바꿈을 하기 위해서는 문장 마지막에서 3칸이상을 띄어쓰기해야 한다.    \
이렇게


****

## ○ 참고문서
* [78 Tools for writing and previewing Markdown](http://mashable.com/2013/06/24/markdown-tools/)
* [John gruber 마크다운 번역](http://nolboo.github.io/blog/2013/09/07/john-gruber-markdown/)
* [깃허브 취향의 마크다운 번역](http://nolboo.github.io/blog/2014/03/25/github-flavored-markdown/)
* [허니몬의 마크다운 작성법](http://www.slideshare.net/ihoneymon/ss-40575068)
* Notion.so(<https://www.notion.so/product>)
* Atom(<https://atom.io/>)
* Visual Studio Code(<https://code.visualstudio.com/>)
* Notepad++(<https://notepad-plus-plus.org/>)