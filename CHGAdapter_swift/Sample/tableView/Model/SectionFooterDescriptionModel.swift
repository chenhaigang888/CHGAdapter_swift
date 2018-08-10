//
//  SectionFooterDescriptionModel.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/7/26.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class SectionFooterDescriptionModel: NSObject {

    var descriptionContent:String?
    
    init(descriptionContent:String?) {
        super.init()
        self.descriptionContent = descriptionContent
    }
}

extension SectionFooterDescriptionModel:CHGTableViewHeaderFooterModelProtocol{
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> String {
        return "SectionFooterDescriptionContentHeaderFooterView"
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> CGFloat {
        return 50
    }
    
//    func getHeaderFooterClass() -> String {
//        return "SectionFooterDescriptionContentHeaderFooterView"
//    }
//    
//    func getHeaderFooterHeigh() -> CGFloat {
//        return 50
//    }
    
    
}
