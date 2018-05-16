//
//  Sample2HeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class Sample2HeaderFooterView: CHGTableViewHeaderFooterView {
    
    @IBOutlet var title:UILabel?
    
    
    
    override func headerFooter(headerFooterForSection section: NSInteger, tableView: UITableView, data: AnyObject, type: CHGTableViewHeaderFooterViewType) {
        super .headerFooter(headerFooterForSection: section, tableView: tableView, data: data, type: type)
        self.title?.text = data as? String;
    }
    
    

}
