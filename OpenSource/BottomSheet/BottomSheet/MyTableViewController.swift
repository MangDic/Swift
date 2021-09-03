//
//  MyTableViewController.swift
//  BottomSheet
//
//  Created by 이명직 on 2021/09/03.
//

import UIKit
import PanModal

class MyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MyTableViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    // 접혔을 때
    var shortFormHeight: PanModalHeight {
        // 높이를 250으로 설정
        return .contentHeight(250)
    }
    
    // 펼쳐졌을 때
    var longFormHeight: PanModalHeight {
        // Top 부터 120 만큼 떨어지게 설정
        return .maxHeightWithTopInset(120)
    }
    
    // true 값을 리턴하면 화면 화면 최상단까지 스크롤 불가
    var anchorModalToLongForm: Bool {
        return true
    }
    
    var allowsDragToDismiss: Bool {
        return false
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.blue.withAlphaComponent(0.5)
    }
}
