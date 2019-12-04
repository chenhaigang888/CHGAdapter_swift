//
//  CityTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class CityTableViewCell: CHGTableViewCell {
    
    @IBOutlet weak var title:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: Any?) {
        super.cellForRow(atIndexPath: indexPath, tableView: tableView, data: data)
        let model:CityModel = data as! CityModel
        title?.text = model.name
    }
    
}
