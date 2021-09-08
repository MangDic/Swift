//
//  ViewController.swift
//  TestProject
//
//  Created by 이명직 on 2021/08/28.
//

import UIKit

class ViewController: UIViewController {

    var completionHandler: (() -> ())?
    
    @IBOutlet weak var getValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapNextBtn(_ sender: Any) {
        let stroyboard = UIStoryboard?.init(UIStoryboard(name: "Main", bundle: nil))
        let vc = stroyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        
        print("first - present")
        present(vc, animated: true)
        
        print("first - completionHandler 생성")
        //_ = completionHandler?()
        
        vc.completionHandler = { result in
            print("first - in completionHandler closure")
            print("result : \(result)")
            
            self.getValue.text = result
            
        }
        print("first - out completionHandler closure")
        
        
    }
    
}

