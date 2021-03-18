//
//  ViewController.swift
//  ObserverPattern
//
//  Created by 이명직 on 2021/03/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subject = Subject()
        let binary = BinaryObserver(subject: subject, id: 1)
        let octa = OctaObserver(subject: subject, id: 2)
        let hex = HexObserver(subject: subject, id: 3)
        
        subject.number = 17
        subject.number = 5
        
        // Do any additional setup after loading the view.
    }


}

