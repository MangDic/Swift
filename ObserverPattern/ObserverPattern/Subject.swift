//
//  Subject.swift
//  ObserverPattern
//
//  Created by 이명직 on 2021/03/18.
//

import Foundation

/* 객체에게 업데이트를 알리는 역할
 옵저버를 attach 하면, observerArray에 넣음
 다른 객체에게 notify하면 observerArray를 순회하며 Observer 프로토콜 내 Update 함수 호출
*/
class Subject {
    private var ObserverArray = [Observer]()
    private var _number = Int()
    
    var number: Int {
        set {
            _number = newValue
            notify()
        }
        
        get {
            return _number
        }
    }
    
    func attachObserver(observer: Observer) {
        ObserverArray.append(observer)
    }
    
    private func notify() {
        for observer in ObserverArray {
            observer.update()
        }
    }
}
