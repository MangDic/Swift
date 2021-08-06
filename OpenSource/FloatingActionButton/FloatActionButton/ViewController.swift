//
//  ViewController.swift
//  FloatActionButton
//
//  Created by 이명직 on 2021/08/05.
//

import UIKit
import JJFloatingActionButton

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftButton()
        setRightButton()
        // Do any additional setup after loading the view.
    }
    
    func setLeftButton() {
        let actionButton = JJFloatingActionButton()
        
        actionButton.buttonColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)

        actionButton.addItem(title: "", image: nil) { item in
            let alertController = UIAlertController(title: "작성", message: "메시지를 작성해주세요", preferredStyle: .alert)
            alertController.addTextField()
            let submitButton = UIAlertAction(title: "추가", style: .default, handler: { action in
                let textField = alertController.textFields![0]
                
                guard let userInputText = textField.text else {
                    return
                }
                
                self.label.text = userInputText
            })
            
            let cancelButton = UIAlertAction(title: "취소", style: .cancel)
            
            alertController.addAction(submitButton)
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true, completion: nil)
            
        }

        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    func setRightButton() {
        let actionButton = JJFloatingActionButton()
        
        actionButton.buttonColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)

        actionButton.addItem(title: "좋아요", image: UIImage(systemName: "hand.thumbsup.fill")?.withRenderingMode(.alwaysTemplate)) { item in
            self.label.text = "좋아요!"
        }

        actionButton.addItem(title: "관심", image: UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)) { item in
            self.label.text = "관심!"
        }

        actionButton.addItem(title: "item 3", image: nil) { item in
          // do something
        }
        
        actionButton.display(inViewController: self)

//        view.addSubview(actionButton)
//        actionButton.translatesAutoresizingMaskIntoConstraints = false
//        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
//        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }


}

