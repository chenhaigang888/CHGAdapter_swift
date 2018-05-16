//
//  Sample1HeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class Sample1HeaderFooterView: CHGTableViewHeaderFooterView {
    
    var btn:UIButton = UIButton()
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var frame: CGRect {
        didSet {
            super.frame = frame
            self.addSubview(self.btn)
            self.btn.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            self.btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        }
    }

    override func headerFooter(headerFooterForSection section: NSInteger, tableView: UITableView, data: AnyObject, type: CHGTableViewHeaderFooterViewType) {
        super .headerFooter(headerFooterForSection: section, tableView: tableView, data: data, type: type)
        self.btn.setTitle(data as? String, for: UIControlState.normal)
    }
    
}
