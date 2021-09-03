//
//  ViewController.swift
//  BottomSheet
//
//  Created by 이명직 on 2021/09/03.
//
// ViewController.swift

import UIKit
import PanModal

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentBottomSheet(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MyTableViewController") as! MyTableViewController
        
        presentPanModal(vc)
    }
    
}

