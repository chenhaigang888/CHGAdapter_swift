//
//  TVTitleHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVTitleDicHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var title:UILabel?
    
    override func headerFooter(section: NSInteger, tableView: UITableView, data: Any, type: CHGTableViewHeaderFooterViewType,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        super.headerFooter(section: section, tableView: tableView, data: data, type: type,eventTransmissionBlock: eventTransmissionBlock)
        if data is NSDictionary {
            let dic:NSDictionary = data as! NSDictionary
            title?.text = dic["groupName"] as? String
        } else {
            let group:Group = data as! Group
            title?.text = group.groupName
        }
        
    }

}
