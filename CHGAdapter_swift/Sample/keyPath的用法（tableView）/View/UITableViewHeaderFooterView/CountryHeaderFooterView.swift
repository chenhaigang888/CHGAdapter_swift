//
//  CountryHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class CountryHeaderFooterView: CHGTableViewHeaderFooterView {
@IBOutlet weak var title:UILabel?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func headerFooter(headerFooterForSection section: NSInteger, tableView: UITableView, data: Any, type: CHGTableViewHeaderFooterViewType) {
        super.headerFooter(headerFooterForSection: section, tableView: tableView, data: data, type: type)
        let model:CountryModel = data as! CountryModel
        title?.text = model.name
    }

}
