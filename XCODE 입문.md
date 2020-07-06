## XCODE 입문 !!

###### 프로젝트 생성

> 새로운 프로젝트 생성 : File -> new -> Project (Shift + Command + n) 
>
> 
>
> Product Name : 앱 이름
>
> Team : 아이폰에 앱을 설치하기 위한 애플 계정 / 시뮬레이터로 할거면 None
>
> Organization Name : 프로그램 작성자 이름
>
> Organization identifier : 도메인 역순 
>
> Bundle Identifier : 겹치면 앱을 올릴 수 없음
>
> Code Data : 데이터를 저장할 수 있는 저장 스토리지를 지원해주는 프레임워크
>
> Source Control : 소스의 버전관리를 할 것인지

네비게이터 영역 : 좌측 9개 버튼에 해당하는 영역

- 1 : 프로젝트 관련 파일

  > .swift : 소스코드 작성, 중앙에 소스편집기
  >
  > .storyboard : 화면 디자인(User Interface), 중앙에 인터페이스 빌더 , 우측은 유틸리티 영역
  >
  > - 유틸리티 영역
  >
  >   > - Show the Attributes inspector (4번째 버튼)
  >   >   - 선택한 UI 요소의 속성을 설정
  >   >   - background : 10진수의 RGB 값을 16진수로 표현 (FFFFFF 흰색, 000000 검정)
  >   >   - 인스펙터 영역 : 유틸리티 영역 중 상위 버튼에 해당하는 영역
  >   >   - 라이브러리 영역 : 하단 4개 버튼에 해당하는 영역
  >   >   - 하단의 View as 를 선택하여 원하는 모델의 View에 맞출 수 있음 (모든 모델에 동일한 화면을 만들고 싶을 때 Auto Layout 사용)





###### 라이브러리 영역

- Label (TextView - 읽기만 가능)

  - lines : 0으로 설정하면 단어가 길어지면 라인 수를 무한대로 증가 시킴

  - Line Break : 영역보다 글자가 초과되면 어떻게 할지 설정

    > Clip : 넘어가면 자름
    >
    > Character Wrap : 영역보다 글자 수 가 넘어가면 라인 수에 맞춰서 넘어감
    >
    > Word Wrap : 단어 단위에 맞춰서 넘어감 

  - Autoshrink 

    > Minimum Font Scale : 영역에 맞춰서 폰트 크기 맞춤
    >
    > Minimum Font Size : 설정한 사이즈까지 줄어들고 그 이하로 줄어들면 짤림

  - Shadow Offset : 그림자 설정

  - BackGround : 글자 영역의 백그라운드

- Image View 

  - Assets.xcassets 디렉토리에 이미지 파일을 넣어서 사용

  - View - Content Mode 

    > Scale To Fill : 이미지 비율 상관 없이 영역에 맞춰서 이미지를 채움
    >
    > Aspect Fit : 원본 이미지를 유지한 채로 가로 또는 세로를 채움
    >
    > Aspect Fill : 가로와 세로를 꽉 채움(이미지 뷰를 벗어날 수 있음)

- Text View 

  - 여러 줄의 텍스트를 영역에서 보여주고 영역이 부족하면 스크롤로 보여줌

  - 만약 실행 후 텍스트 뷰를 클릭했는데 키보드가 안 나오면

    > 상단의 Hardwarer -> Keyboard -> Toggle Software KeyBoard  클릭

  - Text Input Traits -> Keyboard Type : 텍스트뷰를 클릭하면 처음에 나오는 키보드의 형태 (숫자 패드, 일반 키보드 ...)

  - Behavior의 Editable, Selectable 을 통해 편집을 불가능하게 설정

  - Scroll View -> Scrolling Enabled 체크해제 : 스크롤 불가능



###### 실행 (Command + R)

- 빌드를 하면 Products에 앱이 생성됨
- Stop (Commend + .)



###### Mission Control

- 시스템 환경설정 -> Mssion Control 에서 설정 가능
- Command + ^ : 윈도우에서 window + Tab 과 비슷
- 트릭 패드에서도 설정 가능

- 핫코너 : 마우스를 특정 모서리에 옮기면 실행되는 이벤트 설정