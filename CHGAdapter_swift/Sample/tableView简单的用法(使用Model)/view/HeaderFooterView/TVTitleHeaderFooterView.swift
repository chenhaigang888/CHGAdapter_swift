//
//  TVTitleHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVTitleHeaderFooterView: CHGTableViewHeaderFooterView {
    
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
        let titleModel:TVTitleModel = data as! TVTitleModel
        title?.text = titleModel.title
    }

}
