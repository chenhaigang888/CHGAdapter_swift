//
//  TVSuccModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVSuccModel: NSObject {

    var title:String?
    
    init(title:String) {
        super.init()
        self.title = title
    }
    
}

extension TVSuccModel: CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> String {
        return "TVSuccHeaderFooterView"
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> CGFloat {
        return 30
    }
    
    
}
