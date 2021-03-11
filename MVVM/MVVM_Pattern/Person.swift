//
//  Model.swift
//  MVVM_Pattern
//
//  Created by 이명직 on 2021/03/08.
//

import Foundation

class Person: NSObject {
    var name: String = ""
    var age: Int = 0
    var weight: Double = 0
    var height: Double = 0
    init(name: String, age: Int, weight: Double, height: Double) {
        self.name = name
        self.age = age
        self.weight = weight
        self.height = height
    }
}

class Model: NSObject {
    func getPeopleData() -> NSDictionary{
        return [
            "People": [
                ["name": "박재성", "age" : 27, "weight" : 70, "height" : 153],
                ["name": "임가람", "age" : 26, "weight" : 64, "height" : 160],
                ["name": "미미", "age" : 11, "weight" : 4, "height" : 204],
                ["name": "룰루", "age" : 400, "weight" : 25, "height" : 65]
            ]
        ]
    }
}
