//
//  ItemCell.swift
//  ItemControll
//
//  Created by 이명직 on 2020/10/11.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
