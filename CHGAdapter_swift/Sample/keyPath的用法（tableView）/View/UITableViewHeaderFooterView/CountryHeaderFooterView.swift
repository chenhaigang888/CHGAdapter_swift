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
    
//    override func headerFooter(section: NSInteger, tableView: UITableView, data: Any, type: CHGAdapterViewType,eventTransmissionBlock:CHGEventTransmissionBlock?) {
//        super.headerFooter(section: section, tableView: tableView, data: data, type: type,eventTransmissionBlock: eventTransmissionBlock)
//        let model:CountryModel = data as! CountryModel
//        title?.text = model.name
//    }
    
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        let model:CountryModel = self.model as! CountryModel
        title?.text = model.name
    }

}
