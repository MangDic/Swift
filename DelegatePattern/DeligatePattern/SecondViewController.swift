//
//  SecondViewController.swift
//  DeligatePattern
//
//  Created by 이명직 on 2021/02/26.
//

import UIKit

class SecondViewController: UIViewController {

    // weak : 메모리 누수 방지
    weak var delegate: DeliveryDataProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveBack(_ sender: Any) {
        delegate?.deliveryData("전달받은 값")
        self.dismiss(animated: true, completion: nil)
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
