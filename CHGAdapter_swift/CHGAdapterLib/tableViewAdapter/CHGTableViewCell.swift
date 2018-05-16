//
//  CHGTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class CHGTableViewCell: UITableViewCell {
    
    var eventTransmissionBlock:CHGEventTransmissionBlock?
    var indexPath:IndexPath?
    var tableView:UITableView?
    var cellData:AnyObject?
    
    func cellForRow(atIndexPath indexPath:IndexPath,tableView:UITableView?,data:AnyObject?) -> Void {
        self.indexPath = indexPath
        self.tableView = tableView;
        self.cellData = data;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
