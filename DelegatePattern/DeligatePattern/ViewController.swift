//
//  ViewController.swift
//  DeligatePattern
//
//  Created by 이명직 on 2021/02/26.
//

import UIKit

// 델리게이트 패턴 : 하나의 객체가 모든 일을 처리하는 것이 아니라, 어떤 객체가 해야하는 일을 부분적으로 확장해서 대신 처리하는 것. - 부분적으로 확장??
// 하나의 객체가 해야할 일이 많을 경우 사용
class ViewController: UIViewController, DeliveryDataProtocol {
    func deliveryData(_ data: String) {
        dataLabel.isHidden = false
        dataLabel.text = data
        
    }
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveSecondView(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else {
            return
        }
        // second 뷰의 대리자는 나(first 뷰)야 !
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    

}

