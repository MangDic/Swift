//
//  ViewController.swift
//  ItemControll
//
//  Created by 이명직 on 2020/10/11.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var TableMain: UITableView!
    var Item = ["HaHa", "HoHo", "Why"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableMain.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.Label1.text = "\(indexPath.row)"
        cell.Label2.text = Item[indexPath.row]
        
        return cell
    }
    
    @IBAction func InsertItem(_ sender: Any) {
        let alertController = UIAlertController(title: "아이템 추가", message: "추가할 아이템", preferredStyle: .alert)
        alertController.addTextField { (UITextField) in
            UITextField.placeholder = "아이템 이름 입력"
        }
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            let textF = alertController.textFields![0]
            if let newItem = textF.text, newItem != "" {
                self.Item.append(newItem)
                let indexPath = IndexPath(row: self.Item.count - 1, section: 0)
                self.TableMain.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            Item.remove(at: indexPath.row)
            TableMain.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableMain.delegate = self
        TableMain.dataSource = self
        
    }


}

