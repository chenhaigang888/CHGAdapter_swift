//
//  FuncModelTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/17.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class FuncModelTableViewCell: CHGTableViewCell {

    @IBOutlet weak var funcNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        super.cellForRow(atIndexPath: indexPath, tableView: tableView, data: data,eventTransmissionBlock: eventTransmissionBlock)
        let model:FuncModel = data as! FuncModel
        funcNameLabel.text = model.title
    }
    
    
    
}
