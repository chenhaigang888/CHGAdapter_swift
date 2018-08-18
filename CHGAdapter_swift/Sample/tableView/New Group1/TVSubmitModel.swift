//
//  TVSubmitModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVSubmitModel: NSObject {

    var leftBtnText:String?
    var rightBtnText:String?
    
    init(leftBtnText:String, rightBtnText:String) {
        super.init()
        self.leftBtnText = leftBtnText
        self.rightBtnText = rightBtnText
    }
}

extension TVSubmitModel: CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> String {
        return "TVSubmitHeaderFooterView"
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> CGFloat {
        return 50
    }
    
    
}
