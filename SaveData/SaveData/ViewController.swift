//
//  ViewController.swift
//  SaveData
//
//  Created by 이명직 on 2020/08/24.
//  Copyright © 2020 LMJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var emailStr: UITextField!
    @IBOutlet weak var updateTerm: UITextField!
    @IBOutlet weak var autoUpdate: UITextField!
    
    
    var resultEmail : String? // 이메일 값을 전달받을 변수
    var resultUpdate : Bool? // 자동 갱신 여부를 전달받을 변수
    var resultInterval : Double? // 갱신주기 값을 전달받을 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // NSUserDefault 객체의 인스턴스를 가져온다
        let userDefaults = UserDefaults.standard
        
        if let email = userDefaults.object(forKey: "paramEmail") as? String {
            emailStr.text = email
        }
        
        if let update = userDefaults.object(forKey: "paramUpdate") as? Bool {
            if update==true {
                autoUpdate.text = "자동 갱신"
            }
            else {
                autoUpdate.text = "자동 갱신 안 함"
            }
        }
        
        if let interval = userDefaults.object(forKey: "paramInterval") as? Double {
            updateTerm.text = "\(Int(interval))분마다"
        }
    }

}

