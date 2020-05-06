//
//  GoodsTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/11.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class GoodsTableViewCell: CHGTableViewCell {
    
    @IBOutlet weak var title:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) {
//        super.cellForRow(atIndexPath: indexPath, tableView: tableView, data: data,eventTransmissionBlock: eventTransmissionBlock)
//        let model:Goods = data as! Goods
//        title?.text = model.name
//    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        let model:Goods = self.model as! Goods
        title?.text = model.name
    }
}
