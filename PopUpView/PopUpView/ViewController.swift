//
//  ViewController.swift
//  PopUpView
//
//  Created by 이명직 on 2020/10/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func makePopUp(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "PopUp", bundle: nil)
        
        let popUp = storyboard.instantiateViewController(identifier: "PopUp")
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve
        
        let temp = popUp as? PopUpViewController
        
        temp?.strText = "전달한 값이다!"
        
        self.present(popUp, animated: true, completion: nil)
    }
    
}

