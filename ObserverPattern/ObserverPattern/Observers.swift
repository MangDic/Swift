//
//  Observers.swift
//  ObserverPattern
//
//  Created by 이명직 on 2021/03/18.
//

import Foundation

class BinaryObserver: Observer {
    
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }
    
    func update() {
        print("Binary : \(String(subject.number, radix: 2))")
    }
}

class HexObserver: Observer {
    
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }
    
    func update() {
        print("Hex : \(String(subject.number, radix: 16))")
    }
}

class OctaObserver: Observer {
    
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }
    
    func update() {
        print("Octa : \(String(subject.number, radix: 8))")
    }
}
