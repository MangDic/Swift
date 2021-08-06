//
//  ViewController.swift
//  CustomView
//
//  Created by 이명직 on 2021/07/29.
//

import UIKit
import PagingKit

class ViewController: UIViewController {
    

    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    //var dataSource = [(menuTitle: "test1", vc: viewController(.red)), (menuTitle: "test2", vc: viewController(.blue)), (menuTitle: "test3", vc: viewController(.yellow))]
    var dataSource = [(menu: String, content: UIViewController)]() {
        didSet{
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    static var viewController: (UIColor) -> UIViewController = { (color) in
        let vc = UIViewController()
        vc.view.backgroundColor = color
        return vc
    }
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
        let menu = ["1", "2", "3", "4"]
        
        return menu.map {
            let title = $0
            switch title {
            case "1":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstViewController") as! FirstViewController
                return (menu: title, content: vc)
            default:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondViewController") as! SecondViewController
                return (menu: title, content: vc)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메뉴 셀과 포커스 뷰 연결
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        // 제공하는 언더라인 포커스뷰 사용하기도 가능
        //menuViewController.registerFocusView(view: UnderlineFocusView())
        
        // 메뉴 컨트롤러 가운데 정렬
        menuViewController.cellAlignment = .center
        
//        menuViewController.reloadData()
//        contentViewController.reloadData()
        
        dataSource = makeDataSource()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? PagingMenuViewController {
                menuViewController = vc
                menuViewController.dataSource = self
                menuViewController.delegate = self
            } else if let vc = segue.destination as? PagingContentViewController {
                contentViewController = vc
                contentViewController.dataSource = self
                contentViewController.delegate = self
            }
        }

}

// 메뉴 데이터 소스
extension ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.label.text = dataSource[index].menu
        return cell
    }
}

// 메뉴 컨트롤 델리게이트
extension ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

// 컨텐트 데이터 소스(내용)
extension ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    // dataSource의 각 뷰를 넣어줌
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

// 컨텐트 컨트롤 델리게이트
extension ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        // 컨텐트 스크롤하면 메뉴 스크롤한다!
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
