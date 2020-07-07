//
//  Order.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

struct Order {
    
    var id:Int = 0
    
    /// 订单号
    var orderNO:String = ""
    
    /// 创建时间
    var createTime:String = ""
    
    /// 金额
    var amount:String = ""
    
}

extension Order : CHGTableViewCellModelProtocol {
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return OrderTableViewCell.self
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}


