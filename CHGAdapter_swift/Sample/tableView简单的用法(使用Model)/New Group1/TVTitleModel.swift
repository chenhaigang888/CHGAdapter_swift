//
//  TVTitleModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVTitleModel: NSObject {

    var title:String?
    
    init(title:String) {
        super.init()
        self.title = title
    }
    
}

extension TVTitleModel: CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        return TVTitleHeaderFooterView.self
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 30
    }
    
    
}
