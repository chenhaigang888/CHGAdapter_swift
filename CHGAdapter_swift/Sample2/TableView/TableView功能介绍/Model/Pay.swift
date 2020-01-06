//
//  Pay.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2020/1/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

enum Pay {
    case aliPay, wechatPay, unionPay
    
    func desc() -> String {
        var result = ""
        switch self {
        case .aliPay:
            result = "支付宝"
            break
        case .wechatPay:
            result = "支付宝"
            break
        case .unionPay:
            result = "支付宝"
            break
        }
        return result
    }
}

extension Pay : CHGTableViewCellModelProtocol {
    func cellClassName(_ tableView: UITableView, indexPath: IndexPath) -> String {
        switch self {
        case .aliPay:
            return "AliPayTableViewCell"
        case .wechatPay:
            return "WeChatTableViewCell"
        case .unionPay:
            return "unionpayTableViewCell"
        }
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    
}
