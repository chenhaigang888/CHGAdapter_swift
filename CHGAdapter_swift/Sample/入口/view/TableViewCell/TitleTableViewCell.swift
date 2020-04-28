//
//  TitleTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TitleTableViewCell: CHGTableViewCell {
    
    @IBOutlet weak var name:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        super.cellForRow(atIndexPath: indexPath, tableView: tableView, data: data,eventTransmissionBlock: eventTransmissionBlock)//不要忘记调用父类的方法
        let titleModel:TitleModel = data as! TitleModel
        self.name?.text = titleModel.name
    }
    
}
