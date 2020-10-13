//
//  PopUpViewController.swift
//  PopUpView
//
//  Created by 이명직 on 2020/10/13.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var str: UILabel!
    
    var strText = "nil"
    override func viewDidLoad() {
        super.viewDidLoad()

        str.text = strText
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
