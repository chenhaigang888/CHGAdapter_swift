//
//  TVSuccHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVSuccHeaderFooterView: CHGTableViewHeaderFooterView {
    
    @IBOutlet weak var title:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(titleTap(sender:))))
    }
    
    override func headerFooter(section: NSInteger, tableView: UITableView, data: Any, type: CHGTableViewHeaderFooterViewType,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        super.headerFooter(section: section, tableView: tableView, data: data, type: type,eventTransmissionBlock: eventTransmissionBlock)
        let succModel:TVSuccModel = data as! TVSuccModel
        self.title?.text = succModel.title
    }
    
    @objc func titleTap(sender:AnyObject) -> Void {
        _ = self.eventTransmissionBlock!(self,self.headerFooterData!,0,nil)
    }
}
