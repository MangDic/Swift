//
//  NaviMainViewController.swift
//  sendData
//
//  Created by 이명직 on 2020/08/04.
//  Copyright © 2020 LMJ. All rights reserved.
//

import UIKit

class NaviMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Click_MoveBtn(_ sender: Any) {
        
        // 스토리 보드를 찾아서 있으면 진행(옵셔널 바인딩)
        if let controller = self.storyboard?.instantiateViewController(withIdentifier:  "NaviSubViewController") {
            
            self.navigationController?.pushViewController( controller, animated: true)
        }
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
