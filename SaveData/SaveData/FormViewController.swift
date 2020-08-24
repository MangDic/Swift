//
//  FormViewController.swift
//  SaveData
//
//  Created by 이명직 on 2020/08/24.
//  Copyright © 2020 LMJ. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
// paramEmail paramUpdate paramInterva
    
    @IBOutlet weak var paramUpdate: UISwitch!
    @IBOutlet weak var paramInterval: UIStepper!
    @IBOutlet weak var paramEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        
        // 값을 저장한다.
        userDefaults.set(paramEmail.text, forKey: "paramEmail")
        userDefaults.set(paramUpdate.isOn, forKey: "paramUpdate")
        userDefaults.set(paramInterval.value, forKey: "paramInterval")
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
