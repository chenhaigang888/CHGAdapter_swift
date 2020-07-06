//
//  OrderGroup.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

struct OrderGroup {
    var desc:String?
    var btnText:String?
}


extension OrderGroup : CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        return OrderGroupHeaderFooterView.self
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 50
    }
    
    
}
