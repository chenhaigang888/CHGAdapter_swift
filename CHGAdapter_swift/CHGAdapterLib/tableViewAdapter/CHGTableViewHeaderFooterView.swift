//
//  CHGTableViewHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

enum CHGTableViewHeaderFooterViewType {
    case HeaderType
    case FooterType
}

class CHGTableViewHeaderFooterView: UITableViewHeaderFooterView {

    var eventTransmissionBlock:CHGEventTransmissionBlock?
    var section:NSInteger?
    var tableView:UITableView?
    var headerFooterData:AnyObject?
    var type:CHGTableViewHeaderFooterViewType?
    
    func headerFooter(headerFooterForSection section:NSInteger,tableView:UITableView,data:AnyObject,type:CHGTableViewHeaderFooterViewType) -> Void {
        self.section = section
        self.tableView = tableView
        self.headerFooterData = data
        self.type = type
    }
    
}
