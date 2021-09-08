//
//  SecondViewController.swift
//  TestProject
//
//  Created by 이명직 on 2021/09/08.
//

import UIKit

class SecondViewController: UIViewController {
    
    var completionHandler: ((String) -> ())?
    @IBOutlet weak var myLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("second - didload")

    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        print("second - completionHandler 전달")
        _ = completionHandler?(self.myLabel.text!)
        self.dismiss(animated: true)
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
