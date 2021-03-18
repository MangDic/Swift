//
//  Observer.swift
//  ObserverPattern
//
//  Created by 이명직 on 2021/03/18.
//

import Foundation

protocol Observer{
    var id: Int { get }
    func update()
}
