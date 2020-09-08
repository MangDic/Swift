## ARC(Automatic Reference Counting)

#### ARC란?

- 자동 레퍼런스 카운팅으로서, 자동으로 메모리를 관리해주는 방식
- 참조 카운팅이 0이 될때만 메모리에서 해제
- 컴파일 시점에 동작

#### 동작 원리

- 클래스의 새로운 인스턴스 생성 시 ARC는 인스턴스의 정보를 저장하기 위해 메모리 할당
- 인스턴스가 더 이상 사용되지 않는다고 판단(참조 카운팅 0)하면 메모리 해제
- 레퍼런스 프로퍼티에 인스턴스를 할당하면 ARC는 참조되는 프로퍼티의 개수를 카운팅하여 참조하는 모든 변수가 인스턴스를 해제하기 전까지 인스턴스를 메모리에서 해제하지 않음

#### 장점

- 컴파일 당시 이미 인스턴스 해제 시점이 정해져 있어서 인스턴스가 언제 메모리에서 해제될지 예측 가능
- 컴파일 당시 이미 인스턴스 해제 시점이 정해져 있어서 메모리 관리를 위한 시스템 자원을 추가할 필요 없음

#### 단점

- ARC의 작동 규칙을 모르면 인스턴스가 메모리에서 영원히 해제되지 않을 가능성 존재

  

## Weak VS Strong

#### Weak(약한 참조)

- 객체를 소유하지 않고 주소값만 가지고 있는 포인터 개념
- 자신이 참조는 하지만, weak 메모리 해제 권한은 다른 클래스에 있음
- 값 지정시 리테인, 릴리즈 발생 x -> 언제 어떻게 메모리가 해제되었는지 알 수 없음
- 따라서 weak 속성을 사용하는 객체는 항상 옵셔널 타입이어야 함
- 객체가 할당될 때 레퍼런스 카운트를 증가시키지 않음
- 객체가 ARC에 의해 해제되면 nil값 할당
- [weak self]
  - ARC가 프로퍼티의 개수를 카운팅하지 않도록 만들며, 이로 인해 순환참조가 일어나지 않도록 만드는 역할
  - 그 이유는 weak 참조는 ARC에 의해 참조되는 인스턴스가 메모리에서 해제될 때 프로퍼티 값을 nil로 만들기 때문

#### Strong(강한 참조)

- 객체를 소유하여 레퍼런스 카운트가 증가하는 프로퍼티
- 값 지정 시점에 리테인이 되고, 참조가 종료되는 시점에 릴리즈됨
  - 레퍼런스 카운트를 증가시켜 ARC로 인한 메모리 해제를 피하고 객체를 안전하게 사용하고자 할 때 쓰임

#### + unowned

- 객체가 할당될 때 레퍼런스 카운트를 증가시키지 않음
- 하지만 Non-Optional 타입으로 선언되어야 함
- 객체가 ARC에 의해 메모리 해제되어도 해당 객체 값을 존재하는 것으로 인지 -> 해당 객체에 접근하면 런타임 오류 발생
- 객체의 라이프 싸이클이 명확하고 개발자에 의해 제어 가능이 명확한 경우 weak 옵셔널 타입 대신 사용하여 간결한 코딩



## MRR (Manual Retain Release)

- ARC가 등장하기 전, 개발자는 모든 객체의 레퍼런스 카운트를 직접 관리해야 했음
- 객체의 Retain(유지)과 Release(해제)를 직접 호출하는 방식을 뜻함
- Retain
  - NSObject  클래스의 함수이며, 객체의 레퍼런스 카운트를 증가시킴
  - 객체가 메모리에서 해제되지 않도록 이 함수를 호출하여 레퍼런스 카운트를 증가시킬 수 있음
- Release
  - NSObject 클래스의 함수이며, 객체의 레퍼런스 카운트를 감소시킴
  - 객체를 더이상 사용하지 않거나, 메모리에서 해제하고 싶을 때 이 함수를 호출하여 레퍼런스 카운트를 감소시킬 수 있음



## Optional

- 어떠한 변수에 값이 있을 수도 없을 수도있는 경우를 위 사용

- Swift에서 기본적으로 변수를 선언할 때 non-optional인 값을 주어야 함

- Optional 변수는 초기화 하지 않으면 nil로 자동 초기화

- 즉, 어떠한 값을 변수에 할당해야 함

  ~~~ swift
  // test에는 Int타입만 와야 함. 정수가 아닌 nil이 들어갔으므로 에러
  var test : Int
  test = nil
  
  // 변수안에 값이 확실히 있다는 것을 보장할 수 없을 때 optional 사용
  var test : Int?
  test = nil
  ~~~

- ?

  - Xcode는 값을 담을 곳에 노크를 함

  - 만약 값이 있다면 그 안에 있는 값을 얻게 됨

  - 만약 값이 있다면 nil을 반환

    ~~~swift
    // someValue 타입 어노테이션에 ?가 붙음 -> someValue에는 정수 또는 nil이 들어갈 수 있음
    var someValue : Int? = 30
    // Value는 optional 타입이고 Int형 값을 가질 수도, 안 가질수도 있음
    var Value = someValue
    // 노크를 하기 전, Int형에 Int?형을 넣었으니 오류. 서로 다른 타입!!
    var Value : Int = someValue
    ~~~

    

- !

  - 강제 언래핑

  - ?처럼 노크를 하지 않고 일단 부순다음 값을 가져오는 느낌

  - 깨부수고 운좋게 값이 있을 수도, 없을 수도 있음

    ~~~ swift
    var someValue :Int? = 30
    // ?는 에러가 발생했지만, !는 강제 언래핑으로 에러가 발생하지 않음
    var Value : Int = someValue!
    
    // 컴파일에러 x, 빌드도 성공
    // 하지만 널포인트 익셉션 발생
    var someValue : Int? = nil
    var Value : Int = someValue!
    
    ~~~

  - !를 사용하여 값이 존재하지 않는 옵셔널 값에 접근을 시도하면 런타임 에러 발생

  - !를 사용하여 강제 언래핑을 하기 전에는 항상 옵셔널 값이 nil이 아니라는 것을 확실히 해야 함

  - ?와 마찬가지로 optional이기 때문에 초기화 할 때 값을 요구하지 않음 -> 초기화 안 하면 nil

#### 옵셔널 바인딩

- 주로 if let (또는 if var) 구문과 사용

- 선 체크 후 (nil인지, 값이 있는지 확인) 경우에 따라 결과를 다르게 하고 싶을 때

  ~~~ swift
  func printName( _name : String){
      print(_name)
  }
  
   var myName: String? =  nil
  // myName이라는 곳을 체크해보고 값이 있으면 name을 넣고 조건문 실행
  // myName은 nil로 초기화되어 있으므로 조건문 실행 x -> 값이 있을 때만 실행
   if let name = myName {
       printName(_name: name)
   }
  ~~~

  ~~~swift
  // 값이 있으므로 조건문 실행
  var height : Int? = 170
  if let value = height {
      if value >= 160 {
          print("wow")
      }
  }
  
  // 위와 같은 코드. , 로 && 효과
  var height : Int? = 170
  if let value = height, value >= 160{
       print("wow")
  } 
  ~~~

#### 옵셔널 체이닝

- 하위 property에 optional 값이 있는지 연속적으로 확인하면서, 하나라도 nil이 발견된다면 nil 반환

  ~~~ swift
  // residence 변수가 Residence 클래스 상속받고 있음
  // residence에 ?가 붙었으므로 후에 Person 인스턴스가 생성되면 residence의 초기값은 nil
  class Person {
      var residence: Residence?
  }
  
  class Residence 
      var numberOfRooms = 1
  }
  
  // zedd의 초기값은 nil
  let zedd = Person()
  
  // 옵셔널 체이닝
  // residence가 nil이 아니면 넘어가서 residence의 numberOfRooms를 또 확인
  // else문 출력
  // roomCount도 당연히 옵셔널
  if let roomCount = zedd.residence?.numberOfRooms {
      print("zedd's residence has \(roomCount) room(s).")
  } 
  else {
     print("Unable to retrieve the number of rooms.")
  }
  
  // 이렇게 수정하면 residence 값이 nil이 아니게 되고, if문 출력 
   zedd.residence = Residence()
  ~~~

  - 값이 항상 있다는 것이 명백한 경우에는 굳이 옵셔널 바인딩과 옵셔널 체이닝 사용할 필요 없음

  - 이러한 옵셔널 타입을 implicitly unwrapped optionals 라고 함

  - IBOutlet 같은 변수는 연결했다는 것을 확실히 할 수 있기 때문에 !를 붙일 수 있는 것

  - IBOutlet을 선언만 하고 연결을 하지 않은 경우에는 ?를 붙이면 됨

    ~~~ swift
    func optionalTest (name : String?){
        print(name)
    }
    
    func optionalErrorTest (name: String){
        print(name)
    }
    
     optionalTest(name: nil)
    // 에러 -> 무조건 Sting이 들어가야 함
     optionalErrorTest(name: nil)
    ~~~

    

## 타입 캐스팅

- 인스턴스의 타입을 확인하거나, 인스턴스의 타입을 슈퍼클래스 또는 서브클래스 타입처럼 다루기 위해 사용

- is와 as라는 연산자로 구현하며, 값의 타입을 확인하거나 값을 다른 타입으로 변환하는 방법 제공

  ~~~ swift
  class Person {
    
      var name: String
    
      init(name: String) {
          self.name = name
      }
  }
  
  var LMJ = Person(name: "LMJ")
  
  // LMJ라는 인스턴스가 Person의 인스턴스인가?
  // true
  if LMJ is Person {
      print(true)
  }
  
  // 타입뿐만 아니라 인스턴스의 프로퍼티도 확인 가능
  // true
  if LMJ.name is String {
    print(true)
  }
  
  ~~~

  ~~~ swift
  class MediaItem {
  
      var name: String
      init(name: String) {
          self.name = name
      }
  }
  
  
  class Movie: MediaItem {
  
      var director: String
      init(name: String, director: String) {
  
          self.director = director
          super.init(name: name)
      }
  }
  
  class Song: MediaItem {
  
      var artist: String
  
      init(name: String, artist: String) {
  
          self.artist = artist
  
          super.init(name: name)
  
      }
  
  }
  
  // library 타입은 자연스럽게 MediaItem 타입
  let library = [
      Movie(name: "죽은 시인의 사회", director: "피터 위어"),
      Song(name: "창공", artist: "김준석"),
      Movie(name: "인터스텔라", director: "크리스토퍼 놀란"),
      Movie(name: "공범자들", director: "최승호")
  ]
  
  var movieCount = 0
  var songCount = 0
  
  
  for item in library {
    if item is Movie {
          movieCount += 1
      } 
    else if item is Song {
          songCount += 1
      }
  }
  
  print("Media library는 \(movieCount)개의 영화 \(songCount)개의 노래")
  
  
  ~~~

#### Downcasting

- 특정 클래스 타입의 상수 또는 변수는 하위 클래스의 인스턴스 참조 가능

- 이 경우 as를 사용하여 서브 클래스 타입으로 다운캐스팅 시도 가능

  ~~~ swift
  for item in library {
  
    // library는 MediaItem 타입의 배열
    // 그 안에 들어있는 인스턴스는 MediaItem의 서브클래스들인 Movie와 Song이므로 as? 로 다운캐스팅
    // 옵셔널이기 때문에 if let 사용
      if let movie = item as? Movie {
          print("Movie: \(movie.name), dir. \(movie.director)")
      } 
      else if let song = item as? Song {
          print("Song: \(song.name), by \(song.artist)")
     }
  
  }
  
  ~~~

  



## 타입 캐스팅에 사용하는 키워드 as

#### as

- 컴퍼일러가 타입 변환의 성공을 보장
- 컴파일 타임에 가능/불가능 여부 알 수 있음

#### as?

- 타입변환에 실패하는 경우 nil 리턴
- 컴파일 타임에 가능/불가능 여부 알 수 없음

#### as!

- 타입변환에 실패하는 경우 런타임 에러 발생
- 컴파일 타임에 가능/불가능 여부 알 수 없음



## Any VS AnyObject

#### Any

- 함수타입을 포함하여 모든 타입의 인스턴스 표현 가능

- 특정한 타입 하나가 아닌 여러 타입을 사용하고 싶은 경우

- 구조체나 클래스 타입으로 구현된 값타입은 모두 가능 (Int, String, Bool ...)

  ~~~ swift
  // 둘 모두 [1, 2, "3", "4"] 리턴
  var anyArray1 : [Any] = [1, 2, "3", "4"]
  var anyArray2 : Array<Any> = [1, 2, "3", "4"]
  ~~~

  ~~~ swift
  // 여러가지 타입 삽입 가능
  var things = [Any]()
  
  things.append(0)
  
  things.append(0.0)
  
  things.append(42)
  
  things.append(3.14159)
  
  things.append("hello")
  
  things.append((3.0, 5.0))
  
  things.append(Movie(name: "박재성", director: "별수호자"))
  
  things.append({ (name: String) -> String in "Cooooooool, \(name)" })
  ~~~

  

#### AnyObject

- 모든 클래스 타입의 인스턴스 표현 가능

- AnyObject는 모든 클래스가 암시적으로 준수하는 프로토콜

- 클래스, 클래스 타입, 클래스 전용 프로토콜의 인스턴스에 대한 구체저인 타입으로 사 가능

  ~~~swift
  // 에러 error: value of type 'Int' does not conform to expected element type 'AnyObject'
  var anyArr : [AnyObject] = [1,"hi",true,1.0]
  // 에러 x
  var anyArr : [AnyObject] = [1 as AnyObject, "hi" as AnyObject, true as AnyObject, 1.0 as AnyObject]
  
  // 클래스타입
  class aType { }
  class bType { }
  
  var anyObjectArr : [AnyObject] = [aType(),bType()]
  
  
  for thing in things {
  
      switch thing {
  
      case 0 as Int:
          print("Int타입 0")
  
      case 0 as Double:
          print("Double 타입 0")
  
      case let someInt as Int:
          print("0이 아닌 Int \(someInt)")
  
      case let someDouble as Double where someDouble > 0:
          print("양의 Double타입 \(someDouble)")
  
      case is Double:
          print("다른 Double은 출력x")
  
      case let someString as String:
          print("String값은 \"\(someString)\"")
  
      case let (x, y) as (Double, Double):
          print("\(x), \(y)")
  
      case let movie as Movie:
          print("\(movie.name), dir. \(movie.director)")
  
      case let stringConverter as (String) -> String:
          print(stringConverter("LMJ"))
  
      default:
          print("else")
      }
  }
  ~~~

  



## Class VS Struct

#### Class

- 객체화시 힙 메모리 영역에 저장되며, ARC로 객체의 메모리 해제가 관리됨
- 대입 연산 시 레퍼런스가 복사되어 할당됨 (공유 가능)
- 상속 가능
- 멀티 스레딩 시 적절한 Lock활용 필요

#### Struct

- 대입 연산 시 값 자체가 복제되어 할당됨 (공유 불가)
- 불변성(Immutable) 구현에 유리
- 상속 불가능 (프로토콜은 사용 가능)
- 멀티스레딩에 안전함



## Frame VS Bounds

#### Frame 

- SuperView 좌표 시스템 내에서 view의 위치(origin)와 크기(size)

###### Bounds

- view 자기 자신의 좌표 시스템에서의 위치와 크기

- 부모뷰와의 위치관계와는 아무런 상관 x

- 자기 자신의 좌표시스템을 가리키기 때문에 기본적으로 origindms x:0 y:0

- ScrollView/TableView등을 스크롤할 때 ScrollView/TableView.bounds가 변하고, subview 들이 그려지는 위치가 달라지는 것 -> subview의 Frame이 달라지는 것이 아님 

  

## UICollectionViewLayout 클래스에 Prepare의 역할

- 레이아웃관련 연산이 일어날 때마다 가장 먼저 호출
- 이 메소드에서 셀의 위치/크기 등을 계산하기 위한 사전처리
- UICollectionViewLayout 를 상속받아 Custom 한 CollectionView Layout 을 구성하고자 할때, 데이터소스를 참조하여 셀의 위치 및 크기를 미리 계산하여 캐싱해두고, CollectionView 로부터 셀의 위치 및 크기 요청이 들어올때, 미리 계산하여 캐싱해둔 데이터를 전달해주는 방식으로 커스텀 레이아웃을 구성하는 방식이 있음

#### 

## View Controller 생명주기

- **loadView ** 

  - 컨트롤러가 관리하는 뷰를 만든다. 뷰컨트롤러가 생성되고 순차적으로 완성되었을때만 호출

- **viewDidLoad ** 

  - 컨트롤러의 뷰가 메모리에 올라간 뒤에 호출된다. 뷰가 생성될때만 호출

- **viewWillAppear **

  -  화면에 뷰가 표시될때마다 호출 
  - 이 단계는 뷰는 정의된 바운드를 가지고 있지만 화면회전은 적용되지 않음

- **viewWillLayoutSubviews** 

  - 뷰컨트롤러에게 그 자식뷰의 레이아웃을 조정하는 것에 대한 것을 알려주기위해 호출 
  - 이 메소드는 frame이 바뀔때마다 호출

- **viewDidLayoutSubviews ** 

  - 뷰가 그 자식 뷰의 레이아웃에 영향을 준 것을 뷰컨트롤러에게 알려주기 위해 호출
  - 뷰가 그 자식 View의 레이아웃을 바꾸고난 뒤에 추가적인 변경을 하고 싶을때 사용하는 이벤트 함수

- **viewDidAppear ** 

  - 뷰가 나타났다는 것을 컨트롤러에게 알리는 역할
  - 호출되는 시점으로는 뷰가 화면에 나타난 직후에 실행

- **viewWillDisAppear ** 

  - 뷰가 사라지기 직전에 호출되는 함수
  - 뷰가 삭제 되려고하고있는 것을 ViewController에게 알림

- **viewDidDisappear **

  - viewWillDisAppear 다음에 호출

  - ViewController에게 View가 제거되었음을 알림 



## App의 생명 주기

- **application(_:didFinishLaunching:)** - 앱이 처음 시작될 때 실행
- **applicationWillResignActive**: - 앱이 active 에서 inactive로 이동될 때 실행
- **applicationDidEnterBackground**: - 앱이 background 상태일 때 실행
- **applicationWillEnterForeground**: - 앱이 background에서 foreground로 이동 될때 실행 (아직 foreground에서 실행중이진 않음)
- **applicationDidBecomeActive**: - 앱이 active상태가 되어 실행 중일 때
- **applicationWillTerminate**: - 앱이 종료될 때 실행 



## 동기 VS 비동기

#### Synchonize(동기)

- 주어진 명령을 차례로 처리하되 하나의 업무가 완료되기 전 다른 업무로 넘어가지 않음
- 중간에 대기하는 시간으로 효율은 떨어지지만, 일관된 업무 보장과 동시다발적 업무 발생 x -> 대응이 불필요하여 업무 구성 단순화

#### Asynchonize(비동기)

- 주어진 명령을 차례로 처리하되 시간이 걸리는 업무는 진행해둔 채 기다리는 동안 다른 업무 처리하는 방식
- 일관적인 업무 흐름이 깨지고, 응답에 대한 대응이 필요



## 스레드

- 하나의 프로세스 내에서 실행되는 작업흐름의 단위
- 메인 스레드 : 프로세스가 시작하는 동시에 동작하는 스레드
- 서브 스레드 : 이외의 추가로 생성되는 스레드
- 멀티 스레드 
  - 여러 개의 스레드가 동시에 진행
  - 하나의 프로세스 내에서 여러 개의 스레드가 존재
  - 스레드들이 프로세스의 자원을 공유하되 실행은 독립적으로 이루어지는 구조



## 프레임워크

- 다양한 클래스들을 비슷한 범주의 클래스들끼리 묶어놓은 것
- ex) UIkit..
- 더 큰 범주는 IOS운영체제
- IOS 운영체제 계층
  - **Cocoa Touch**
    - IOS 앱에 사용자 인터페이스(UI) 관련 계층
    - UIKit, MapKit, Message UI 등의 프레임워크
    - 스토리보드, 오토 레이아웃, 제스처 인식, 애플 푸시 알림 기능 등을 여기서 담당
  - **Media**
    - 2D, 3D 그래픽 애니메이션 이미지 효과, 오디오, 비디오 기능 담당
    - Core Graphics, AVKit(동영상 재생), Metal(하드웨어 가속 그래픽 연산 기능) 프레임워크
  - **Core Service**
    - 사용자의 인터페이스와는 직접적인 관련 x
    - Core OS와 관련
    - Core Data(데이터 베이스와 비슷), Foundation(하위 계층 시스템이나 서비스에 접근할 수 있는 유틸리티 클래스), Core Foundation 프레임워크
    - 데이터 관리, Int와 String 등의 자료형, 
  - **Core OS**
    - 하드웨어에 가장 근접한 Low Level의 계층
    - Accelerate, OpenCL, SystemConfiguration 프레임워크
      - Accelerate : 하드웨어 가속, 이미지나 비디오 프로세싱, 데이터 병렬처리 등 앱 성능향상 제공
      - OpenCL : CPU와 GPU에서 병렬처리를 도와줌
      - SystemConfiguration : 앱에서 네트워크 연결 도움
      - 커널 : 파일 시스템, 네트워크
    - 앱에서 직접 접근하지는 않지만 상위 다른 계층에서 대부분 사용하는 프레임워크
    - 병렬처리, 보안(App SandBox), Code Signing, 파일 시스템, 네트워크
    - App SandBox : 앱의 접근 권한을 특정 폴더로 한정해서 악성코드로 부터 사용자 데이터 및 시스템에 대한 최후의 방어선 구축
    - Code Signing : 앱 인증관련 보안 기술, 악의적인 코드로 인한 앱의 변경사항 감지 가능

- developer.apple.com -> Develop -> Documentation에서 다양한 프레임워크 확인 가능
- 다양한 프레임워크를 import해서 사용 가능
- IOS 버전이 올라갈 때마다 새로운 프레임워크 클래스가 추가되어 이미 구현되어 있는 api 사용
  - 당연히 버전이 낮으면 특정 기능을 사용할 수 없을 수 있음



## 접근 제어(Access Control)

#### open 

- 정의된 모듈외에서도 접근 가능

- 모든 접근수준 중 open만이 모듈 밖의 다른 모듈에서 상속 가능 (클래스)
- 모든 접근수준 중 open으로 선언된 클래스의 멤버(프로퍼티, 메소드)들만이 다른 모듈에서 override 가능
  - ex) UIViewController

#### public 

- open과 마찬가지로, 정의된 모듈외에서도 접근 가능
- 외부에서 생성은 할 수 있으나 override가 불가능 하다는 점에서 open과 차이

#### internal 

- 안드로이드에서 default
- 같은 모듈 내에서는 어디서든 접근 가능하며 클래스의 경우 상속 가능

#### fileprivate 

- 하나의 swift 파일 내부에서만 접근이 가능한 접근제어 수준
- 같은 모듈 내 어디서든 접근 가능하며 클래스의 경우 상속 가능

#### private 

- 그 요소가 선언된 영역(블록)내에서만 접근 가능

#### 특징

- 외부 요소의 접근제어 수준보다 높은 수준의 내부 요소는 있을 수 없음
  - 클래스의 접근수준이 private 이면 클래스의 멤버들은 public, internal 등 private보다 상위 수준의 접근수준이 될 수 없고 선언이 되어도 private으로 취급
- 특정 접근제어 수준의 타입이 함수의 매개변수나 반환되는 타입일 경우 함수는 해당 값은 접근제어보다 높을 수 없음
  -  메소드나 함수가 public한데 private한 매개변수를 받거나 private한 값을 반환하는 것은 상식적으로 맞지 않음. 
  -  이때 매개변수의 타입이나 반환되는 값의 접근제어 수준은 메소드나 함수의 접근제어 수준과 같거나 높아야 함



## Self

- 모든 타입 인스턴스는 `self`라는 명확한 속성을 가지며, 인스턴스 자신과 정확하게 동일
- self 속성을 사용하여 자신의 인스턴스 메소드 내에서 현재 인스턴스를 참조
- self 속성은 인자 이름과 속성 이름을 분리하도록 사용



## instance / class / static

~~~ swift
class Sample {
// 1. Instance 함수
func myInstanceFunc() {}
// 2. class 함수
class func myClassFunc() {}
// 3. static 함수
static func myStaticFunc() {}
}
~~~

#### static, class 

- 두 메소드는 타입 메소드

- class 객체보다는 **class 자체**와 연관

- () 생성자를 통해서 인스턴스를 생성하지 않더라도 바로 접근이 가능

  ~~~ Swift
  Sample.myClassFunc()
  Sample.myStaticFunc()
  ~~~

- 차이점 

  - class : override 가능

  - static : override 불가능

    ~~~ swift
    class SubSample : Sample {
    //Good!
    override class func myClassFunc() {}
    //Compile Error
    override static func myStaticFunc() {}
    }
    ~~~

  - 그러므로 상속이 불가능한 struct, enum에서 class func을 정의하면 에러 발생

#### static func VS final class func

~~~ swift
class Sample {
    class func myClassFunc() {}
    static func myStaticFunc() {}
}

//style 1 : final class
class SubSample1 : Sample {
    override final class func myClassFunc() {}
}

//style 2 : static
class SubSample2 : Sample {
    override static func myClassFunc() {}
}
// 같다!
~~~



#### 타입 프로퍼티

- 타입 메소드 : static func, class func

- 타입 프로퍼티 : 프로퍼티 앞에 static, class가 붙은 것

  ~~~ swift
  class PropertySample {
      static var myStaticProperty = 1
  
      class var myClassProperty: Int {
          return 1
      }
  }
  
  class SubPropertySample : PropertySample {
      override class var myClassProperty: Int {
          return 2
      }
  }
  ~~~

- 특징은 타입 메소드와 같음 (생성자 없이 바로 접근 가능, class 프로퍼티만 상속 가능)

- **class 타입 프로퍼티** 같은 경우, **연산 타입 프로퍼티**(Computed type property)로 표현해야 함

  ~~~ swift
  // 저장 타입 프로퍼티 형태 - 컴파일 에러
  class var errorClassProperty: Int = 1
  // 연산 타입 프로퍼티 형태 - 컴파일 OK
  class var correctClassProperty: Int {
     return 1
  }
  
  // let- 컴파일 에러
  class let errorClassProperty: Int {
     return 1
  }
  // var - 컴파일 OK
  class var correctClassProperty: Int {
     return 1
  }
  ~~~

#### static을 사용하는 이유??

- 해당 메소드나 프로퍼티가 instance보다는 type자체와 연관될 때 사용
- static property
  - 자주 변하지 않고 전역 변수처럼 공통으로 관리하는 공용 자원 느낌일 때 사용 (색상, 폰트 등...)
  - 자주 재사용되고 생성 비용이 많이 드는 object를 미리 만들어 놓고 계속 사용하면 효율을 높일 수 있을 때 (dateformatter 등...)
- static method
  - 간단한 factory 패턴 구현 시 사용



## Metatype

- 타입의 타입 (..?)

  ~~~ swift
  struct Medium {
      static let author = "naljin"
      func postArticle(name: String) {}
  }
  
  let blog: Medium = Medium()
  ~~~

  - blog 이름으로 생성한 인스턴스에서 
    - 인스턴스 메소드인 postArticle() 호출 가능
    - 클래스 프로퍼티인 author에는 접근 불가능
  - author에 접근하기 !
    - Medium.author
    - let something = type(of: blog) // Medium.Type
    - Medium의 Type은 Medium.Type // 타입의 타입 -> 메타타입

- 클래스의 메타타입 : SomeClass.Type

- 프로토콜의 메타타입 : someProtocol.Protocol

- someClass.self : 자기 자신을 반환

- someProtocol.self : 런타입에 someProtocol을 준수하는 타입의 인스턴스가 아닌 someProtocol 자체를 반환

  ~~~ swift
  class SomeBaseClass {
      class func printClassName() {
          print("SomeBaseClass")
      }
  }
  class SomeSubClass: SomeBaseClass {
      override class func printClassName() {
          print("SomeSubClass")
      }
  }
  // 컴파일타임에는 SomeBaseClass의 인스턴스 타입
  // 런타임에는 SomeSubClass의 인스턴스 타입
  let someInstance: SomeBaseClass = SomeSubClass()
  
  type(of: someInstance).printClassName()
  ~~~

  ~~~ swift
  print("\n---------- [ Instance Type Check ] ----------\n")
  
  let str = "StringInstance"
  print(str is String)           // true, str 은 String Type 의 객체, 스트링의 객체가 맞으면 참트루
  print(str == "StringInstance") // true, str 은 "StringInstance" 와 동일
  print(str is String.Type)      // false
  print(str is String.Type.Type) // false
  
  
  
  print("\n---------- [ Type's Type check ] ----------\n")
  
  print(type(of: str) is String)       // false, String is String 과 동일.. 그니까 String == String.Type을 물어본거
  print(type(of: str) == String.self)  // true, str 객체의 타입은 String 그 자체, String.Type == String.Type
  print(type(of: str) is String.Type)  // true, str 객체의 타입은 String.Type 의 객체 String의 타입 == String.type
  
  
  
  print("\n---------- [ Metatype's Type check ] ----------\n")
  
  private let meta = type(of: String.self)
  print(meta is String)  // false
  print(meta == String.self)  // false
  print(meta == String.Type.self)  // true, String 메타타입은 String.Type
  print(meta is String.Type.Type)  // true, String 메타타입은 String.Type.Type 의 객체
  ~~~

  

## Protocol

- 특정 역할을 하기 위한 메소드, 프로퍼티, 기타 요구사항등의 청사진

#### 사용

- 구조체, 클래스, 열거형은 프로토콜을 채택해서 특정 기능을 실행하기 위한 프로토콜의 요구사항을 실제로 구현 가능
- 프로토콜은 정의를 하고 제시를 할 뿐 스스로 구현하지는 않음 (조건만 정의)
- 하나의 타입으로 사용되기 때문에 아래와 같은 타입 사용이 허용되는 모든 곳에 프로토콜 사용 가능
  - 함수, 메소드, 이니셜라이저의 파라미터 타입 혹은 리턴 타입
  - 상수, 변수, 프로퍼티의 타입
  - 배열, 딕셔너리의 원소타입

##### 기본 형태

~~~ swift
protocol 프로토콜이름 {
 // 프로토콜 정의
}
~~~



## 인터페이스 VS 추상클래스

#### 인터페이스는 구현부를 가질 수 없음

- 인터페이스 메소드들은 무조건 추상메소드로 구현부를 가질 수 없음
- 추상클래스는 기본 동작을 구현한 인스턴스 메소드를 가질 수 있음

#### 인터페이스는 다중 상속 가능

- 추상클래스는 다중 상속 불가능



## 프로토콜 VS 인터페이스

#### 프로토콜은 옵셔널 키워드를 통해 선택적으로 메소드 설계 가능

- 일반적으로 특정 인터페이스를 상속한 클래스는 인터페이스에 포함된 모든 메소드를 의무적으로 구현해야 함
- 하지만 프로토콜의 경우 옵셔널 키워드를 사용하면  선택적으로 구현하는 메소드를 만들 수 있음 
- 자주 사용하는 UITableViewDelegate만 해도 상속만 하고 사용하지 않는 내부 메소드가 대부분

#### 프로토콜 Static 멤버 선언 가능

#### 프로토콜은 프로퍼티에 초기 값을 지정 가능



## Delegation

- Delegate : 대표(자), 사절, 위임, 대리(자), 위임하다, 선정하다

#### Delegation Design Pattern

- 하나의 객체가 다른 객체를 대신해 동작 또는 조정할 수 있는 기능을 제공

- Foundation, UIKit, AppKit, Cocoa Touch 등 애플의 프레임워크에서 광범위하게 활용

- 주로 프레임워크 객체가 위임 요청, 커스텀 컨트롤러 객체가 위임받아 특정 이벤트에 대한 기능 구현

- 커스텀 컨트롤러에서 세부 동작을 구현함으로써 동일한 동작에 대해 다양한 대응을 할 수 있게 해줌

  ~~~ swift
  // UITextFieldDelegate 예시
  
  // 대리자에게 특정 텍스트 필드의 문구를 편집해도 되는지 묻는 메서드
  func textFieldShouldBeginEditing(UITextField)
  	
  // 대리자에게 특정 텍스트 필드의 문구가 편집되고 있음을 알리는 메서드
  func textFieldDidBeginEditing(UITextField)
  
  // 특정 텍스트 필드의 문구를 삭제하려고 할 때 대리자를 호출하는 메서드
  func textFieldShouldClear(UITextField)
  
  // 특정 텍스트 필드의 `Return` 키가 눌렸을 때 대리자를 호출하는 메서드
  func textFieldShouldReturn(UITextField)
  ~~~

  - 델리게이트는 특정 상황에 대리자에게 메시지를 전달하고 그에 적절한 응답 받기 위한 목적으로 사용

  ~~~ swift
  // 이 뷰의 컨트롤러의 인스턴스가 player의 델리게이터로 역할을 수행하겠다고 할당
  self.player.delegate = self
  ~~~

  ~~~ swift
  // 이미지 피커에서 델리게이트 활용
  picker.delegate = self
  ...
  
  func imagePickerControllerDidCancel(...) {
    self.dismiss(...)
  }
  
  func imagePickerController(...) {
    if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      self.dismiss(...)
    }
  }
  ~~~

  

  ###### Dismiss

  - 간단히 처리하다

#### 데이터 소스

- 델리게이트와 매우 비슷한 역할
- 델리게이트 : 사용자 인터페이스 제어에 관한 권한을 위임 받음
- 데이터소스 : 데이터를 제어하는 기능을 위임 받음

#### 프로토콜

- 코코아터치에서 프로토콜을 사용해 델리게이션과 데이터소스 구현 가능
- 객체간 소통을 위한 강력한 통신규약으로, 데이터나 메시지를 전달할 때 사용
- 특정한 상황에 대한 역할을 정의하고 제시하지만, 세부 기능은 미리 구현해두지 않음
- 구조체, 클래스, 열거형에서 프로토콜을 채택하고 특정 기능을 수행하기 위한 요구사항 구현 가능



## SingleTon

- 특정 클래스의 인스턴스가 오직 하나임을 보장하는 객체를 의미
- 애플리케이션이 요청한 횟수와는 관계없이 이미 생성된 같은 인스턴스를 반환
- 즉, 애플리케이션 내에서 특정 클래스의 인스턴스가 오직 하나뿐이기에 다른 인스턴스들이 공유해서 사용 가능

#### 코코아 프레임워크에서의 싱클턴 디자인 패턴

- 싱글턴 인스턴스를 반환하는 팩토리 메소드나 프로퍼티는 일반적으로 shared라는 이름 사용
  - `FileManager`
    - 애플리케이션 파일 시스템을 관리하는 클래스
    - `FileManager.default`
  - `URLSession`
    - URL 세션을 관리하는 클래스
    - `URLSession.shared`
  - `NotificationCenter`
    - 등록된 알림의 정보를 사용할 수 있게 해주는 클래스
    - `NotificationCenter.default`
  - `UserDefaults`
    - Key-Value 형태로 간단한 데이터를 저장하고 관리할 수 있는 인터페이스를 제공하는 데이터베이스 클래스
    - `UserDefaults.standard`
  - `UIApplication`
    - iOS에서 실행되는 중앙제어 애플리케이션 객체
    - `UIApplication.shared`

#### 참고

- 객체가 불필요하게 여러 개 만들어질 필요가 없는 경우에 많이 사용
- Ex) 환경설정, 네트워크 연결처리, 데이터 관리 등
- 멀티 스레드 환경에서 동시에 싱글턴 객체를 참조할 경우 원치 않은 결과 도출 가능

~~~ swift
class UserInformation {
  // 이 타입 프로퍼티를 호출하여 항상 똑같은 인스턴스 사용
  // 하지만 shared같은 자주 쓰이는 단어로 네이밍하면 해킹 공격에 취약
  static let shared: UserInformation = UserInformation()
  
  var name: String?
  var age: String?
}

// 싱글턴에 저장 FirstController
@IBOutlet weak var nameField: UITextField!
...
UserInformation.shared.name = nameField.text


// 사용 SecondController
@IBOutlet weak var nameLabel: UILabel!
...
self.nameLable.text = UserInformation.shared.name

// 즉 데이터를 싱글턴에 저장 후 저장된 데이터를 사용
~~~



## View의 재사용

- 화면에 표시될 뷰의 개수는 한정되어 있지만, 표현해야 하는 데이터가 많은 경우 뷰 생성보다 뷰 재사용 가능
- 뷰를 재사용함으로써 메모리를 절약하고 성능 향상
- Ex) UITableViewCell, UICollectionViewCell

#### 재사용 원리

1. 테이블뷰 및 컬렉션뷰에서 셀을 표시하기 위해 데이터 소스에 뷰(셀) 인스턴스를 요청
2. 데이터 소스는 요청마다 새로운 셀을 만드는 대신 재사용 큐 (Reuse Queue)에 재사용을 위해 대기하고있는 셀이 있는지 확인 후 있으면 그 셀에 새로운 데이터를 설정하고, 없으면 새로운 셀을 생성
3. 테이블뷰 및 컬렉션뷰는 데이터 소스가 셀을 반환하면 화면에 표시
4. 사용자가 스크롤을 하게 되면 일부 셀들이 화면 밖으로 사라지면서 다시 재사용 큐에 삽입
5. 1번부터 4번까지의 과정이 계속 반복



## UIStackView

- 스택뷰의 레이아웃은 스택뷰의 `axis`, `distribution`, `alignment`, `spacing`과 같은 프로퍼티를 통해 조정
- spacing으로 간격 설정
- 이미 존재하는 뷰들을 스택뷰에 추가
  - 뷰들 선택 -> Editor -> Embed In -> StackView 또는 하단 Embed In Stack 버튼 클릭

- UIStackView 클래스의 주요 프로퍼티
  - `var arrangedSubviews: [UIView]`
    - 스택뷰의 정렬된 뷰의 배열 
    - 스택뷰에 포함된 뷰들을 이 프로퍼티에 저장하고 관리
  - `var axis: UILayoutConstraintAxis`
    - 레이아웃의 방향을 결정 (수직 vertical, 수평 horizontal)
  - `var distribution: UIStackViewDistribution` 
    - 스택뷰에 포함된 뷰가 스택뷰 내에서 어떻게 배치(분배)될지 결정
  - `var spacing: CGFloat`
    - 스택뷰에 정렬된 뷰들 사이의 간격을 결정 
    - 기본 값은 0.0
- UIStackView 클래스의 주요 메소드
  - `func addArrangeSubview(UIView)`
    - arrangedSubviews  배열에 마지막 요소에 뷰를 추가
  - `func insertArrangedSubview(UIView, at: Int)`
    - arrangedSubviews 배열의 특정 인덱스에 뷰를 추가합니다.
  - `func removeArrangedSubview(UIView)`
    -  스택뷰의 `arrangedSubviews` 배열로부터 뷰를 제거



## Target-Action

- touchDown

- - 컨트롤을 터치했을 때 발생하는 이벤트
  - UIControlEvents.touchDown

- touchDownRepeat

- - 컨트롤을 연속 터치 할 때 발생하는 이벤트
  - UIControlEvents.touchDownRepeat

- touchDragInside

- - 컨트롤 범위 내에서 터치한 영역을 드래그 할 때 발생하는 이벤트
  - UIControlEvents.touchDragInside

- touchDragOutside

- - 터치 영역이 컨트롤의 바깥쪽에서 드래그 할 때 발생하는 이벤트
  - UIControlEvents.touchDragOutside

- touchDragEnter

- - 터치 영역이 컨트롤의 일정 영역 바깥쪽으로 나갔다가 다시 들어왔을 때 발생하는 이벤트
  - UIControlEvents.touchDragEnter

- touchDragExit

- - 터치 영역이 컨트롤의 일정 영역 바깥쪽으로 나갔을 때 발생하는 이벤트
  - UIControlEvents.touchDragExit

- touchUpInside

- - 컨트롤 영역 안쪽에서 터치 후 뗐을때 발생하는 이벤트
  - UIControlEvents.touchUpInside

- touchUpOutside

- - 컨트롤 영역 안쪽에서 터치 후 컨트롤 밖에서 뗐을때 이벤트
  - UIControlEvents.touchUpOutside

- touchCancel

- - 터치를 취소하는 이벤트 (touchUp 이벤트가 발생되지 않음)
  - UIControlEvents.touchCancel

- valueChanged

- - 터치를 드래그 및 다른 방법으로 조작하여 값이 변경되었을때 발생하는 이벤트
  - UIControlEvents.valueChanged

- primaryActionTriggered

- - 버튼이 눌릴때 발생하는 이벤트 (iOS보다는 tvOS에서 사용)
  - UIControlEvents.primaryActionTriggered

- editingDidBegin

- - `UITextField`에서 편집이 시작될 때 호출되는 이벤트
  - UIControlEvents.editingDidBegin

- editingChanged

- - `UITextField`에서 값이 바뀔 때마다 호출되는 이벤트
  - UIControlEvents.editingChanged

- editingDidEnd

- - `UITextField`에서 외부객체와의 상호작용으로 인해 편집이 종료되었을 때 발생하는 이벤트
  - UIControlEvents.editingDidEnd

- editingDidEndOnExit

- - `UITextField`의 편집상태에서 키보드의 `return` 키를 터치했을 때 발생하는 이벤트
  - UIControlEvents.editingDidEndOnExit

- allTouchEvents

- - 모든 터치 이벤트
  - UIControlEvents.allTouchEvents

- allEditingEvents

- - `UITextField`에서 편집작업의 이벤트
  - UIControlEvents.allEditingEvents

- applicationReserved

- - 각각의 애플리케이션에서 프로그래머가 임의로 지정할 수 있는 이벤트 값의 범위
  - UIControlEvents.applicationReserved

- systemReserved

- - 프레임워크 내에서 사용하는 예약된 이벤트 값의 범위
  - UIControlEvents.systemReserved

- allEvents

- - 시스템 이벤트를 포함한 모든 이벤트
  - UIControlEvents.allEvents



## Gesture Recognizer (제스처 인식기)

- 여러 제스처 관련 이벤트 인식 가능
- 특정 제스처 이벤트 발생 시 각 타겟에 맞는 액션 메시지를 보내 제스처 관련 이벤트 처리 가능
- UIGestureRecognizer의 하위 클래스
  - UITapGestureRecognizer : 싱글탭 또는 멀티탭 제스처
  - UIPinchGestureRecognizer : 핀치(Pinch) 제스처
  - UIRotationGestureRecognizer : 회전 제스처
  - UISwipeGestureRecognizer : 스와이프(swipe) 제스처
  - UIPanGestureRecognizer : 드래그(drag) 제스처
  - UIScreenEdgePanGestureRecognizer : 화면 가장자리 드래그 제스처
  - UILongPressGestureRecognizer : 롱프레스(long-press) 제스처

- 타겟-액션 연결 설정 후 UIView 메소드인 addGestureRecognizer(_:) 메소드를 통해 연결

- 호출되는 액션 메소드는 아래 메소드 구현 형식 중 하나와 같아야 함

  ~~~swift
  @IBAction func myActionMethod()
  @IBAction func myActionMethod(_sender: UIGestureRecognizer)
  ~~~

- 윈도우 뷰는 터치 이벤트 전달 전, 뷰에 추가된 제스처 인식기에 터치 이벤트 전달

- 제스처 인식기가 터치 이벤트 인식 o -> 터치 이벤트 받지 못함

- 제스처 인식기가 터치 이벤트 인식 x -> 터치 이벤트 받음

- 일반적인 제스처 인식기 동작 흐름은 `cancelsTouchesInView`, `delaysTouchesBegan`, `delaysTouchesEnded` 프로퍼티의 값에 영향을 받음

  - ###### UIGestureRecognizer 주요 메소드

    - `init(target: Any?, action: Selector?)` : 제스처 인식기를 타깃-액션의 연결을 통해 초기화
    - `func location(in: UIView?) -> CGPoint` : 제스처가 발생한 좌표를 반환
    - `func addTarget(Any, action: Selector)` : 제스처 인식기 객체에 타깃과 액션을 추가
    - `func removeTarget(Any?, action: Selector?)` : 제스처 인식기 객체로부터 타깃과 액션을 제거
    - `func require(toFail: UIGestureRecognizer)` : 여러 개의 제스처 인식기를 가지고 있을 때, 제스처 인식기 사이의 의존성을 설정'

  - ###### UIGestureRecognizer 주요 프로퍼티

    - `var state: UIGestureRecognizerState` : 현재 제스처 인식기의 상태를 나타냄

    - `var view: UIView?` : 제스처 인식기가 연결된 뷰

    - `var isEnabled: Bool` : 제스처 인식기가 사용 가능한 상태인지를 나타냄

    - var cancelsTouchInView

      - 제스처가 인식되었을 때 터치 이벤트가 뷰로 전달되는 여부에 영향

      - 이 프로퍼티가 true(기본값)이고 제스처 인식기가 제스처를 인식했다면, 해당 제스처의 터치는 뷰로 전달 x
      - 이전에 전달된 터치들은 `touchesCancelled(_:with:)` 메시지를 통해 취소됨 
      - 제스처 인식기가 제스처를 인식 못하거나 이 프로퍼티의 값이 false라면 뷰가 모든 터치를 전달받음

    - `var delaysTouchesBegan` : began 단계에서 제스처 인식기가 추가된 뷰에 터치의 전달 지연 여부를 결정

    - `var delaysTouchesEnded` : end 단계에서 제스처 인식기가 추가된 뷰에 터치의 전달 지연 여부를 결정

- 사용

  ~~~swift
  // Tap Gesture Recognizer	뷰에 추가
  // 클래스와 타겟-액션 연결
  @IBAction func tapView(_ sender: UITapGestureRecognizer) {
    print("Tapped")
  }
  ~~~

  ~~~swift
  override func viewDidLoad() {
    ...
    // 액션 타겟을 통한 제스처 인식기 초기화 및 생성
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(gestureRecognizer:)))
    
    // 뷰에 제스처 인식기 연결
    self.view.addGestureRecognizer(tapRecognizer)
  }
  
  @objc func tapView(gestureRecognizer: UIGestureRecognizer) {
    print("Tapped")
  }
  ~~~

- ###### IOS의 Standard Gesture

  - Tap : 컨트롤을 활성화하거나 항목을 선택

  - Drag : 아이템을 좌우 또는 화면으로 드래그할 수 있음

  - Flick : 빠르게 스크롤하거나 화면을 넘길 수 있음

  - Swipe : 이전 화면으로 돌아가거나 테이블 뷰에서 숨겨진 삭제 버튼을 표시

  - Double tap : 이미지 또는 콘텐츠를 확대하거나 다시 축소

  - Pinch : 이미지를 세밀하게 확대하거나 다시 축소

  - Touch and hold 

    - 편집 가능한 텍스트 또는 선택 가능한 텍스트에서 수행될 경우 커서 지정을 위한 확대보기가 표시

    - 컬렉션 뷰의 경우 항목을 재배치할 수 있는 모드로 진입

  - Shake : 실행 취소 또는 다시 실행 얼럿을 띄움



## Button 디자인

~~~swift
button.layer.borderColor = UIColor.black.cgColor

// borderWidth 넣지 않으면 테두리 생성 x
button.layer.borderWidth = 1
button.layer.cornerRadius = 10
~~~



## URLSession

- HTTP/HTTPS를 통해 콘텐츠(데이터)를 주고받기 위해 API를 제공하는 클래스
- 애플리케이션이 실행중이지 않거나 일시 중단된 동안 백그라운드 작업을 통해 콘텐츠 다운로드 수행 가능
- URLSession API를 사용하기 위해 애플리케이션은 세션을 생성
- 해당 세션은 관련된 데이터 전송작업 그룹을 조정

#### URLSessionDataTask

- 세션 작업을 하나로 나타내는 클래스

#### Request

- 서버로 요청을 보낼 때 어떤 (HTTP)메소드를 사용할 것인지, 캐싱 정책은 어떻게 할 것인지 등의 설정 가능

#### Response

- URL 요청의 응답을 나타내는 객체

#### 세션의 유형

- 유형은 URLSession 객체가 소유한 configuration 프로퍼티 객체에 의해 결정
- 기본 세션(Default Session) 
  - 기본 세션은 URL 다운로드를 위한 다른 파운데이션 메소드와 유사하게 동장
  - 디스크에 저장하는 방식
- 임시 세션(Ephemeral Session)
  - 기본 세션과 유사하지만, 디스크에 어떤 데이터도 저장하지 않고 메모리에 올려 세션과 연결
  - 따라서 애플리케이션이 세션을 만료시키면 세션과 관련한 데이터가 사라짐
- 백그라운드 세션 (Background Session)
  - 백그라운드 세션은 별도의 프로세스가 모든 데이터 전송을 처리한다는 점을 제외하고는 기본 세션과 유사

#### 세션 만들기

~~~ swift
// init(configuration:) : 지정된 세션 구성으로 세션을 만듦
init(configuration: URLSessionConfiguration)
// shared : 싱글턴 세션 객체를 반환
class var shared: URLSession {get}
~~~

#### 세션 구성

~~~ swift
// configuration : 이 세션에 대한 구성 객체
@NSCopying var configuration : URLSessionConfiguraton {get}
//delegate : 이 세션의 델리게이트
var delegate : URLSessionDelegate? {get}
~~~

#### Task

- URLSessionTask는 세션 작업 하나를 나타내는 추상 클래스

- 세션 내에서 URLSession 클래스는 세 가지 작업 유형(데이터 작업, 업로드 작업, 다운로드 작업)을 지원

  - URLSessionDataTask

    - HTTP의 각종 메소드를 이용해 서버로부터 응답 데이터를 받아 Data 객체를 가져오는 작업 수행

      ~~~swift
      // URL에 데이터를 요청하는 데이터 작업 객체 생성
      func dataTask(with url: URL) -> URLSessionDataTask
      // URLRequest 객체를 기반으로 URL에 데이터를 요청하는 데이터 작업 객체 생성
      func dataTask(with request: URLRequest) -> URLSessionDataTask
      // URL에 데이터를 요청하고 요청에 대한 응답을 처리할 완료 핸들러를 갖는 데이터 작업 객체 생성
      func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
      // URLRequest 객체를 기반으로 URL에 데이터를 요청하고 요청에 대한 응답을 처리할 완료 핸들러를 갖는 데이터 작업 객체 생성
      func dataTask(with request: URLRequest, completionHandler:@escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
      ~~~

      

  - URLSessionUploadTask

    - 애플리케이션에서 웹 서버로 Data 객체 또는 파일 데이터를 업로드하는 작업 수행

    - 주로 HTTP의 POST 혹은 PUT 메소드를 이용

      ~~~ swift
      // URLRequest 객체를 기반으로 URL에 데이터를 업로드하는 작업 생성
      func uploadTask(with request: URLRequest, from bodyData: Data) -> URLSessionUploadTask
      // URLRequest 객체를 기반으로 URL에 데이터를 업로드하고 업로드 완료 후 완료 핸드러 호출하는 작업 생성
      func uploadTask(with request: URLRequest, from bodyData: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
      // URLRequest 객체를 기반으로 URL에 파일을 업로드하는 업로드 작업 생성
      func uploadTask(with request: URLRequest, fromFile fileURL: URL) -> URLSessionUploadTask
      // URLRequest 객체를 기반으로 URL에 파일을 업로드하고 완료 후 완료 핸들러를 호출하는 업로드 작업 생성
      func uploadTask(with request: URLRequest, fromFile fileURL: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -? Void) -> URLSessionUploadTask
      ~~~

      

  - URLSessionDownloadTask

    - 서버로부터 데이터를 다운로드 받아 파일의 형태로 저장하는 작업 수행

    - 애플리케이션의 상태가 대기 중이거나 실행 중이 아니라면 백그라운드 상태에서도 다운로드 가능

      ~~~ swift
      // URL에 요청한 데이터를 다운로드 받아 파일에 저장하는 다운로드 작업 생성
      func downloadTask(with url: URL) -> URLSessionDownloadTask
      // URL에 요청한 데이터를 다운로드 받아 파일에 저장하고, 저장 완료 후 완료 핸들러를 호출하는 다운로드 작업 생성
      func downloadTask(with url: URL, completionHandler: @escaping(URL?, URLResponse?, Error?) -> Void)
      // URLRequest 객체를 기반으로 URL에 요청한 데이터를 다운로드 받아 파일로 저장하는 다운로드 작업 생성
      func downloadTask(with request: URLRequest) -> URLSessionDownloadTask
      // URLRequest 객체를 기반으로 URL에 요청한 데이터를 다운로드 받아 파일로 저장하고 완료 후 완료 핸들러를 호출하는 다운로드 작업 생성
      func downloadTask(with request: URLRequest, completionHandler: @escaping(URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
      ~~~

  #### 작업(Task) 상태 제어

  ~~~ swift
  // 작업 취소
  func cancel()
  // 일시중단된 경우 작업을 다시 시작
  func resume()
  // 작업을 일시적으로 중단
  func suspend()
  // 작업의 상태를 나타냄
  var state : URLSessionTask.State{ get }
  // 작업처리 우선순위로 0.0 부터 1.0 사이
  var priority : Float{ get set }
  ~~~

  





