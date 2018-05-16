//
//  SampleAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class SampleAdapter: CHGTableViewAdapter {
    
    override func obtainCellNameWithCell(_ data: AnyObject, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> NSString {
        if indexPath.section % 2 == 0 {
            return "Sample1TableViewCell"
        }
        return "Sample2TableViewCell"
    }

}
