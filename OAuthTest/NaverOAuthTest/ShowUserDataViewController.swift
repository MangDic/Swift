//
//  ShowUserDataViewController.swift
//  NaverOAuthTest
//
//  Created by 이명직 on 2021/06/11.
//

import UIKit

class ShowUserDataViewController: UIViewController {

    static var user = getData(nickName: "", email: "", age: "")
    static var type = ""
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var ageRange: UILabel!
    @IBOutlet weak var loginType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nickName.text = ShowUserDataViewController.user.nickName
        email.text = ShowUserDataViewController.user.email
        ageRange.text = ShowUserDataViewController.user.age
        loginType.text = ShowUserDataViewController.type
        // Do any additional setup after loading the view.
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
