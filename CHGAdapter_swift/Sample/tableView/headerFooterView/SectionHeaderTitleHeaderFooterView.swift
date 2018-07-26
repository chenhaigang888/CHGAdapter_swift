//
//  SectionHeaderTitleHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/7/26.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class SectionHeaderTitleHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var title: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func headerFooter(headerFooterForSection section: NSInteger, tableView: UITableView, data: AnyObject, type: CHGTableViewHeaderFooterViewType) {
        super.headerFooter(headerFooterForSection: section, tableView: tableView, data: data, type: type)
        let sectionHeaderTitleModel:SectionHeaderTitleModel = data as! SectionHeaderTitleModel
        title.text = sectionHeaderTitleModel.title
    }

}
