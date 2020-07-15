## 클래스, 구조체, 열거형



#### 클래스

- 클래스는 설계도라고 생각
- 인스턴스는 설계도에 의해 생성된 것

~~~swift
class Circle {
    
    // 클래스의 속성(프로퍼티)
    var radius = 10.0
    let pi = 3.1415926535
    
    // 메소드
    func area() -> Double {
        return radius * radius *pi
    }
}

// 클래스 인스턴스 생성
let circle = Circle() // = Circle.init() // init은 생성자
circle.area()
~~~

~~~swift
//생성자를 이용한 초기화
init() {
    radius = 10.0
}

init(radius: Double) {
    self.radius = radius // self = this
}

//사용
let circle = Circle.init(radius: 20)
circle.area()

~~~



#### 변수, 상수를 만드는 2가지 방법

~~~ swift
// 값을 통해 생성
var weight = 65
// 생성자를 통해 생성
var weight = Int.init(65)
var evenNumber = [Int].init(arrayLiteral: 2, 4, 6, 8) // init은 생략 가능
var oddNumber = Array<Int>() // 빈 배열 생성
~~~



#### 상속

- 공통 기능들을 슈퍼 클래스로 묶고, 이 속성들을 상속받아 서브 클래스에서 사용 가능

~~~swift
class NoteBook {
    var name = ""
    
    func turnOn() {
        print("Booting...")
    }
}

// MacBook : 서브 클래스, NoteBook : 슈퍼 클래스
class MacBook: NoteBook {
    // 슈퍼 클래스 외 기능 추가
    var hasTouchBar = true
    var macOSVersion = "10.13"
    
    // override 사용
    override func turnOn() {
        super.turnOn() // 슈퍼 클래스의 인스턴스를 가리킴
        print("\(name)'s current macOSVersion is \(macOSVersion)'")
    }
    
    func turnOnTouchBar() {
        
    }
}

let macBook = MacBook()
macbook.name = "MacBook Pro"
macBook.turnOn()


~~~



#### 클래스 vs 구조체

- 공통점

  - 속성(Property) 정의
  - 메소드 정의
  - 생성자를 통한 초기 설정
  - extension, protocol 사용 가능

- class만의 추가적인 특징

  - 상속
  - 타입 캐스팅 : 타입을 바꿀 수 있음
  - 소멸자를 통한 리소스 정리

  ~~~swift
  // class를 structure로 바꾸면 에러 발생
  class Circle {
      var radius = 0
      
      // 생성자
      init() {
          print("Initializer called")
      }
      
      // 소멸자
      deinit {
          print("DeInitializer called")
      }
  }
  
  // 생성만 되고 소멸은 x 
  var circle1 = Circle()
  
  // 이 scope에 진입하는 순간 생성, 빠져나가는 순간 소멸
  if true {
  	var circle1 = Circle()
  }
  ~~~

  - 참조 타입
    - 구조체는 넘길 때 복사가 되는 값 타입
    - 클래스는 참조 횟수만 증가하는 참조 타입



#### 값 vs 참조 전달

~~~swift
//구조체
struct Circle {
    var radius = 0
}

// Circle 구조체 인스턴스 메모리에 생성 후 circle1 변수가 인스턴스 참조
var circle1 = Circle()

// 새로운 Circle 구조체 인스턴스 메모리에 생성 후 circle2 변수가 인스턴스 참조
var circle2 = circle1
circle2.radius = 10

print(circle2.radius) // 10
print(circle1.radius) // 0

// 결과적으로 circle1과 circle2는 다른 참조를 가짐
---------------------------------
// 클래스
class Circle {
    var radius = 0
}

// 클래스 인스턴스가 메모리에 생성되고 circle1 인스턴스가 참조하여 참조 횟수 1
var circle1 = Circle()

// circle1과 같은 인스턴스를 가리킴 - 같은 참조로 참조 횟수 2
var circle2 = circle1
circle2.radius = 10

print(circle2.radius) // 10
print(circle1.radius) // 10

// circle1, circle2는 같은 참조로 값이 같음
~~~



#### 구조체

- 구조체  사용

  - 몇 가지 간단한 데이터 값을 캡슐화 

    ~~~swift
    struct Rectangle {
        var width = 0
        var height = 0
    }
    
    struct Coordinate3D {
        var x = 0
        var y = 0
        var z = 0
    }
    ~~~

  - 할당 및 전달 시 복사가 합리적일 때

  - 모든 속성도 값 타입 - 복사가 맞을 때

  - 상속이 필요 없을 때



#### 열거형(Enumeration)

- 비슷한 값들을 그룹으로 묶어서 정의하고, 함수 등에서 값을 입력 받을 때 미리 정해진 값만을 한정해서 받을 때 유용하게 사용

- default 문이 없어도 에러가 발생하지 않는다

  ~~~ swift
  enum AppleOS {
      case iOS
      case macOS
      case tvOS
      case watchOS
  }
  
  var osType: AppleOS = AppleOS.~
  // 축약형
  var osType: AppleOS = .~
  
  // 정의
  func printAppleDevice(osType: AppleOS) {
      switch osType {
          case .iOS:
        		print("iPhone")
          case .macOS:
        		print("iMac")
          case .tvOS:
        		print("Apple TV")
          case .watchOS:
        		print("Apple watch")
      }
  }
  
  // 사용
  printAppleDevice(osType: .watchOS)
  
  ~~~