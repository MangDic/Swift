###### 소숫점 데이터 처리

float 타입 보단(중간에 반올림되기 때문) 2배의 정밀도를 가진Double 타입 추천 

Tab 누르면 다음 입력 가능한 곳으로 이동 (Shift + Tab은 반대로)

이모티콘 : (컨트롤 + 커맨드 + 스페이스)



#### 조건문

- ###### if

  ~~~swift
  let dust = 15
  if dust <= 30 { 
      print("Cool")
  }
  else if dust > 30 && dust <= 50 {
      print("SoSo")
  }
  ~~~

- ###### switch

  ~~~swift
  let weather = "비"
  switch weather {
      case "흐림" : {
          print("")
      }
      case "비", "장마", "소나기" : { // 다른 switch문과 달리 여러 조건 가능
          print("")
      }
      case "눈" : {
          print("")
      }
      default : {
          print("")
      }
  }
  // swift의 switch는 break가 없어도 조건을 만족하면 실행 후 빠져나옴
  // 실수의 가능성을 줄여줌
  // default 구문이 없으면 에러 발생
  ~~~

  

#### 반복문

- ###### for ~ in ~ 구문

  ~~~ swift
  for i in 1...10 { /// ...은 범위 연산자
      print(i)
  }
  
  // i가 1 ~ 10까지 2씩 증가
  for i in stride(from: 1, to: 10, by: 2) {
      print(i)
  }
  // i가 10부터 1까지 2씩 감소
  for i in stride(from: 10, to: 1, by: -2)
  
  // 구구단 2단 출력 ㅋㅋ
  for i in 1...9 {
      print(2 * i)
  }
  
  // 변수 출력
  for j in 2...9 {
      for i in 1...9 {
          print(String(j) + " X " + String(i) + " = " + String(j * i))
          // = print("\(j) X \(i) = \(i*j)") 
          //스트링 인터폴레이션 사용
      }
  }
  ~~~

- ###### while

  ~~~swift
  // 기본 while문
  var i = 0
  while i < 10 {
      i += 1
      print(i)
  }
  
  리피트 while
  i = 0
  repeat {
      i += 1
      print(i)
  } while i < 10
  ~~~

  

#### 배열

- 컬렉션 타입 : 하나의 변수나 상수에 여러개의 값을 가지는 타입 (배열, 딕셔너리 등..)

  ~~~  swift
  // 축약형
  var toDoArray = ["Travel", "Work", "Call"]
  var evenNumber: [Int] = [2, 4, 6, 8]
  
  // 전체
  var toDoArray: Array<String> = ["Travel", "Work", "Call"]
  var evenNumber: Array<Int> = [2, 4, 6, 8]
  
  // swift 배열은 여러값을 저장해도 메모리에 연속으로 저장되지 않기 때문에 중간에 추가 제거 가능
  
  toDoArray[0] = "Play" // 0번째 원소 값 변경
  evenNumber.append(10) // 배열 마지막에 10이라는 값 추가
  evenNumber.insert(12, at: 0) // 0번째 인덱스에 12 추가
  evenNumber.remove(at: 0) // 0번째 인덱스 제거
  
  // 배열 모든 원소 출력
  for toDo in toDoArray {
      print(toDo)
  }
  ~~~



#### 딕셔너리

- vs 배열
  - 배열은 중간에 값을 추가, 삭제하면 뒤 원소들의 인덱스 변경
  - 딕셔너리는 키값에 맞춰서 추가, 삭제
  - 배열은 중복된 값 추가되도 인덱스와 함께 추가
  - 딕셔너리는 키 값이 중복되면 더 이상 추가 x

~~~swift
// : 앞 부분은 key, 뒤 부분은 value

// 축약형
var toDoDic = [17: "Play", 25: "Watch Movies", 28: "Travel"]

// 전체
var toDoDic2: Dictionary<String, String>= [17: "Play", 25: "Watch Movies", 28: "Travel"]

toDoDic["17"] // 값 가져오기
toDoDic["31"] = "Study" // 값 추가
print(toDoDic) // toDoDic 모두 출력
toDoDic.removeValue(forKey: "31") // "31" 이라는 key를 가지는 값 삭제

toDoDic["28"] = nil // 마찬가지로 "28"에 해당하는 값 제거 (nil : 값이 없다는 의미)

toDoDic.removeAll() // toDoDic 원소값 모두 제거

// toDoDic 키, 값 출력
for (key, value) in toDoDic {
    print("key: \(key), value: \(value)")
}

// toDoDic 키 출력
for key in toDoDic.keys {
    print(key)
}

// toDoDic 값 출력
for value in toDoDic.values {
    print(value)
}
~~~

