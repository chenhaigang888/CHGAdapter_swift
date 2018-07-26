//
//  SectionFooterDescriptionContentHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/7/26.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class SectionFooterDescriptionContentHeaderFooterView: CHGTableViewHeaderFooterView {

    lazy var descriptionLabel:UILabel = {
        let descriptionLabel = UILabel.init()
        return descriptionLabel
    }()
    
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
            self.addSubview(self.descriptionLabel)
            self.descriptionLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.addSubview(descriptionLabel)
//
//    }
    
    override func headerFooter(headerFooterForSection section: NSInteger, tableView: UITableView, data: AnyObject, type: CHGTableViewHeaderFooterViewType) {
        super .headerFooter(headerFooterForSection: section, tableView: tableView, data: data, type: type)
        let sectionFooterDescriptionModel:SectionFooterDescriptionModel = data as! SectionFooterDescriptionModel
        descriptionLabel.text = sectionFooterDescriptionModel.descriptionContent
    }
}
