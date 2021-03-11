//
//  ViewController.swift
//  MVVM_Pattern
//
//  Created by 이명직 on 2021/03/07.
//

import UIKit

class MvvmTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var wh: UILabel!
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TableView: UITableView!
    
    let viewModel = MvvmViewModel()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.peopleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = viewModel.peopleData[indexPath.row] as! Person
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "MvvmTableViewCell") as! MvvmTableViewCell
        
        cell.name.text = person.name
        cell.age.text = "\(person.age) 세"
        cell.wh.text = "\(person.weight) / \(person.height)"
        
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
  


}

