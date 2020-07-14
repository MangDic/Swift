## 함수



#### 기본 구조

~~~ swift
// -> : 리턴 에로우
func 함수명(파라미터 명: 타입) -> 반환하는 데이터 타입 {
    함수 바디
}

// 정의
func hello(name: String) -> String {
    let message = "Hello~ " + name
    return message
    // = return "Hello~ " + name
}

func addTwoNumbers(num1: Int, num2: Int) -> Int {
    let sum = num1 + num2
    return sum
}

// 호출
let message = hello(name: "명직")
~~~



#### 코드 스니핏

- 자주 사용하는 코드 조합들
- 드래그해서 가져오면 코드 생성됨!!
- 반대로 드래그해서 코드 스니핏에 추가 가능



#### 함수의 다양한 형태

~~~ swift
func hello() { } // 매개변수가 없고 리턴값이 void인 형태

func addTwoNumbers(num1: Int, num2: 100) -> Int {
    let sum = num1 + num2
    return sum
}
addTwoNumbers(num1: 5) // 값은 105


// 파라미터 개수를 모를 경우
func addNumbers(numbers: Int...) -> Int {
    var sum = 0
    for num in numbers {
        sum += num      
    }
    return sum
}
addNumbers(numbers: 1, 2, 3, 4, 5)


// return값이 여러개인 경우
func myInfo() -> (name: String, age: Int) {
    return ("명직", 26) // swift 튜플 이용
}
let info = myInfo();
print(info.name)
print(info.age)
print(info)
~~~



#### print 함수

- 개발자 문서 보는 법 3가지

  - 함수 클릭 후 유틸리티 -> 퀵 헬프 인스펙터
  - 옵션키 + 함수 클릭
  - 헬프 메뉴 -> Developer Documentation

- print의 파라미터

  - items(AnyType), separator(기본값 - " "), terminator(기본 값 - (\n))

    ~~~swift
    print(123, "Hello", true, 123.345)
    // 123 Hello true 123.345
    // separator의 기본 값에 의해 띄어쓰기, terminator 기본 값에 의해 줄바꿈
    
    print(123, "Hello", true, 123.345, separator: "---")
    print("Cool")
    // 123---Hello---true---123.345
    // Cool
    
    print(123, "Hello", true, 123.345, separator: "---", terminator: "")
    // 123---Hello---true---123.345Cool
    
    ~~~

    

#### Scope

- 변수와 상수를 사용할 수 있는 유효한 범위

- let : 상수, 초기화해도 값이 바뀌지 않음

- var : 변수, 초기화 후 값이 바뀜

  ~~~swift
  func addTwoNumbers(num1: Int, num2: Int) -> Int {
      let sum = num1 + num2 // sum 값이 바뀌지 않음 -> let
      return sum
  }
  
  func addNumbers(numbers: Int...) -> Int {
      var sum = 0 // sum 값이 바뀜 -> var
      for num in numbers {
          sum += num
      }
      return sum
  }
  ~~~

  

#### Argument Label

- 함수 뿐만 아니라 입력 값에도 설명(역할) 추가 가능
- _로 생략 가능

~~~swift
// 파라미터 네임 앞에 있는 것이 Argument Label
func calulate(multiflyFirstNumber num1, Int, bySecondNumber num2: Int) -> Int {
    return num1*num2
}

func calulate(divideFirstNumber num1, Int, bySecondNumber num2: Int) -> Int {
    return num1*num2
}
~~~



#### inout 키워드

~~~ swift
func addTwoNumber(num1: Int, num2: Int) -> { // num1, num2는 상수
    // num2 = 7 - 만약 이 코드를 넣으면 에러 발생 - num2가 let이기 때문
    return num1 + num2
}


//num2를 바꾸고 싶다면 inout 붙이기
func addTwoNumber(num1: Int, num2: inout Int) -> { // num1, num2는 상수
    num2 = 7
    return num1 + num2
}
var test1 = 1
var test2 = 2
// test1은 값이 복사되어 넘어가고, test2는 변수 자체가 들어가기 때문에 출력시 값이 바뀜
addTwoNumber(num1: test1, num2: &test2) // & 붙이기
print(test2) // 7 출력
// test1 : call by value(값에 의한 전달) - 복사해서 전달
// test2 : call by reference(참조에 의한 전달) - 변수 자체를 전달
~~~



#### 값에 의한 전달 vs 참조에 의한 전달

- 참조에 의한 전달 : 값이 저장되어 있는 메모리의 주소를 넘김. 같은 메모리의 주소를 공유
- 값에 의한 전달 : 값이 복사되어 전달. 서로 다른 메모리 주소를 가짐



#### 16진수를 사용하는 이유

- 정보 저장 시 비트 8개를 묶어 1바이트 단위로 저장
- 1 바이트는 0 ~ 255까지 256가지의 정보 저장 가능 
- 0 = 0x0, 255 = 0xff
- 사용 이유
  - 데이터 저장 단위인 바이트와 16진수가 잘 맞아 떨어짐
  - 컴퓨터는 2진수로 표현하지만 2진수로 수를 표현하면 너무 길어짐(2진수 데이터를 간결하게 표현) - 가독성을 높임
  - 최고의 퍼포먼스를 위해 64비트(8바이트) cpu에서는 8바이트로 주소 표현
-  프로그래머 계산기를 사용하면 용이