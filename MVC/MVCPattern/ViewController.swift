//
//  ViewController.swift
//  MVCPattern
//
//  Created by 이명직 on 2021/03/11.
//

import UIKit

class MVCTabelViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var etc: UILabel!
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        peopleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableMain.dequeueReusableCell(withIdentifier: "MVCTabelViewCell") as! MVCTabelViewCell
        let person = peopleData[indexPath.row] as! Person
        
        cell.name.text = person.name
        cell.age.text = "\(person.age)"
        cell.etc.text = "\(person.height) / \(person.weight)"
        
        return cell
    }
    
    let model : Model = Model()
    var peopleData : NSArray!
    
    @IBOutlet weak var TableMain: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableMain.delegate = self
        TableMain.dataSource = self
        
        let data1 = Model().getPeopleData()["People"] as! NSArray
        let data2 = NSMutableArray()
        for i in 0..<data1.count {
            let tmpData = data1[i] as! NSDictionary
            let name = tmpData["name"] as! String
            let age = tmpData["age"] as! Int
            let weight = tmpData["weight"] as! Double
            let height = tmpData["height"] as! Double
            
            data2.add(Person(name: name, age: age, weight: weight, height: height))
        }
        peopleData = NSArray(array: data2)
        
        
        // Do any additional setup after loading the view.
    }


}

