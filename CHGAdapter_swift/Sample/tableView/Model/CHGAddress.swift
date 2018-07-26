//
//  CHGTestModel.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/7/26.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// 地址
class CHGAddress: NSObject {
    
    var type:Int = 0
    var address:String?
    var fullAddress:String?
    
    init(type:Int,address:String?,fullAddress:String?) {
        super.init()
        self.type = type
        self.address = address
        self.fullAddress = fullAddress
    }
}

// MARK: - 实现CHGTableViewCellModelProtocol协议，用返回当前model绑定的cell类以及cell的高度
extension CHGAddress:CHGTableViewCellModelProtocol {
    
    func getCellClass() -> String {
        NSStringFromClass(AddressTableViewCell.classForCoder())
        if type == 0 {
            return "AddressTableViewCell"
        } else {
            return "Address2TableViewCell"
        }
    }
    
    func getCellHeigh() -> CGFloat {
        return -1//为-1的时候代表自动布局 需要tableView设置 自动获取高度。可以自己返回想要的高度
    }
    
    
}
