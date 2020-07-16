## 프레임워크

- 다양한 클래스들을 비슷한 범주의 클래스들끼리 묶어놓은 것
- ex) UIkit..
- 더 큰 범주는 IOS운영체제
- IOS 운영체제 계층
  - Cocoa Touch
    - IOS 앱에 사용자 인터페이스(UI) 관련 계층
    - UIKit, MapKit, Message UI 등의 프레임워크
    - 스토리보드, 오토 레이아웃, 제스처 인식, 애플 푸시 알림 기능 등을 여기서 담당
  - Media
    - 2D, 3D 그래픽 애니메이션 이미지 효과, 오디오, 비디오 기능 담당
    - Core Graphics, AVKit(동영상 재생), Metal(하드웨어 가속 그래픽 연산 기능) 프레임워크
  - Core Service
    - 사용자의 인터페이스와는 직접적인 관련 x
    - Core OS와 관련
    - Core Data(데이터 베이스와 비슷), Foundation(하위 계층 시스템이나 서비스에 접근할 수 있는 유틸리티 클래스), Core Foundation 프레임워크
    - 데이터 관리, Int와 String 등의 자료형, 
  - Core OS
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



#### 접근 제어(Access Control)

- 캡슐화 : 프레임 워크나 클래스 등에서 꼭 필요한 부분만 외부에 노출 시킴

- open 

  - 정의된 모듈외에서도 접근 가능

  - 모든 접근수준 중 open만이 모듈 밖의 다른 모듈에서 상속 가능 (클래스)
  - 모든 접근수준 중 open으로 선언된 클래스의 멤버(프로퍼티, 메소드)들만이 다른 모듈에서 override 가능
    - ex) UIViewController

- public 

  - open과 마찬가지로, 정의된 모듈외에서도 접근 가능
  - 외부에서 생성은 할 수 있으나 override가 불가능 하다는 점에서 open과 차이

- internal 

  - 안드로이드에서 default
  - 같은 모듈 내에서는 어디서든 접근 가능하며 클래스의 경우 상속 가능

- fileprivate 

  - 하나의 swift 파일 내부에서만 접근이 가능한 접근제어 수준
  - 같은 모듈 내 어디서든 접근 가능하며 클래스의 경우 상속 가능

- private 

  - 그 요소가 선언된 영역(블록)내에서만 접근 가능

- 특징

  - 외부 요소의 접근제어 수준보다 높은 수준의 내부 요소는 있을 수 없음
    - 클래스의 접근수준이 private 이면 클래스의 멤버들은 public, internal 등 private보다 상위 수준의 접근수준이 될 수 없고 선언이 되어도 private으로 취급
  - 특정 접근제어 수준의 타입이 함수의 매개변수나 반환되는 타입일 경우 함수는 해당 값은 접근제어보다 높을 수 없음
    -  메소드나 함수가 public한데 private한 매개변수를 받거나 private한 값을 반환하는 것은 상식적으로 맞지 않음. 
    - 이때 매개변수의 타입이나 반환되는 값의 접근제어 수준은 메소드나 함수의 접근제어 수준과 같거나 높아야 함

  ~~~swift
  class NoteBook {
      var name = ""
      
      func turnOn() {
          print("Booting...")
      }
  }
  
  class MacBook: NoteBook {
      
      var hasTouchBar = true
      var macOSVersion = "10.13"
      
      override func turnOn() {
          super.turnOn() 
          print("\(name)'s current macOSVersion is \(macOSVersion)'")
      }
      
      func turnOnTouchBar() {
          
      }
  }
  
  let macBook = MacBook()
  macbook.name = "MacBook Pro"
  macBook.turnOn()
  // 만약 MacBook 내의 요소의 접근제어자가 private면 접근 불가 (MacBook 내에서는 접근 가능)
  // fileprivate면 같은 파일 내에 있으므로 접근 가능
  ~~~

  

~~~swift
import Foundation

// enum은 상속 불가로 open 사용 시 에러
public enum LogLevel: String {
    case none = ""
    case success = ""
    case info = ""
    case warning = ""
    case error = ""
}

open class OpenLogger {
    
    // 파일명과 라인
    open static func logMessage(log: String, level: LogLevel, file: String = #file, line: Int = #line) {
        print(level.rawValue, file, line, log)
    }
    public static func logMessage(log: String) {
        print(log)
    }
    internal static func logMessage(log: String) {
        print(log)
    }
    fileprivate static func logMessage(log: String) {
        print(log)
    }
    private static func logMessage(log: String) {
        print(log)
    }
}

public class PublicLogger {
    open static func logMessage(log: String) {
        print(log)
    }
    public static func logMessage(log: String) {
        print(log)
    }
    internal static func logMessage(log: String) {
        print(log)
    }
    fileprivate static func logMessage(log: String) {
        print(log)
    }
    private static func logMessage(log: String) {
        print(log)
    }
}

private class Logger {
    open static func logMessage(log: String) {
        print(log)
    }
    public static func logMessage(log: String) {
        print(log)
    }
    internal static func logMessage(log: String) {
        print(log)
    }
    fileprivate static func logMessage(log: String) {
        print(log)
    }
    private static func logMessage(log: String) {
        print(log)
    }
}
~~~

- 확인을 위해서 생성된 프레임워크를 새로운 프로젝트의 General -> Embedded Binaries에 드래그하여 추가
- 프레임워크 실행 디바이스와 프레임워크를 사용하려는 프로젝트의 디바이스를 맞춰야 함
  - IOS Device : IOS Device에 최적화된 프레임워크 생성
  - 시뮬레이터 : 맥에 있는 cpu에 최적화된 프레임워크 생성
  - 그래서 서로 맞춰줘야 함

~~~swift
import UIKit
import 생성된 프레임워크

// 만약 Open이 아니라 Publuc이면 에러 -> 다른 모듈에서 상속 불가
class Test: OpenLogger {
    
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OpenLogger.openLogMessage(log: #function, level: .success)
    }
}
~~~



#### NSLog

- ex) NSLog("viewDidLoad")

- 속도가 매우 느림 -> 옵저버 이펙트(관찰자 효과)

  - 로그를 남기는 함수가 앱의 속도를 저하시켜서 타이밍이 달라져 빌드 시 에러

- 통합 로그 -> 속도가 빠름, 옵저버 이펙트 최소화 (IOS ver10 이상)

  ~~~swift
  import os.log
  
  class ViewController: UIViewController {
      override func viewDidLoad() {
          super.viewDidLoad()
          os_log("viewDidLoad")
      }
  }
  ~~~

- Window -> Devices and Simulators -> Open Console 에서도 실시간 앱 로그 확인 가능



#### IOS 버전

- Google -> ios market share 검색하면 애플에서 주기적으로 발표하는 기기 점유율 확인 가능
- 이를 통해 적절한 버전 선택 및 근거 제시



#### API

- Application Programming Interface
- 인터페이스 : 사람과 컴퓨터/앱 간에 의사소통을 하기 위한 매개체
- os_log도 일종의 api



#### 무선 디버깅

- xcode 9, 아이폰 11 이상부터 지원

- 최초 유선으로 연결하여 실행

- Window -> Devices and Simulators

  - Takge ScreenShot : 아이폰의 스크린 샷을 남김

  - Connect via network : 체크하면 네트워크 연결 아이콘 생김(무선 디버깅 가능)

    - 위에서 말했듯이 11 미만 버전에서는 나오지 않음

    - 아이폰과 맥북 와이파이가 같아야 함
    - 같음에도 연결이 되지 않는다면 네트워크 재연결