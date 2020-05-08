//
//  GoodsCategoryTableViewHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/11.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class GoodsCategoryTableViewHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var title:UILabel?
    
//    override func headerFooter(section: NSInteger, tableView: UITableView, data: Any, type: CHGAdapterViewType,eventTransmissionBlock:CHGEventTransmissionBlock?) {
//        super.headerFooter(section: section, tableView: tableView, data: data, type: type,eventTransmissionBlock: eventTransmissionBlock)
//        let model:GoodsCategory = data as! GoodsCategory
//        title?.text = model.name
//    }

    
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        let model:GoodsCategory = self.model as! GoodsCategory
        title?.text = model.name
    }
}
