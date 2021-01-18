//
//  Dictionary+model.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/18.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import Pods_CHGAdapter_swift

let TB_cell_class_key = "TB_cell_class_key"
let TB_cell_height_key = "TB_cell_height_key"


//使用字典在cell中显示
extension Dictionary : CHGTableViewCellModelProtocol {
    
    public func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        let dic:Dictionary<String,Any> = self as! Dictionary<String, Any>
        guard let an:AnyClass = dic["TB_cell_class_key"] as? AnyClass else { return nil }
        return an
    }
    
    public func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        let number:NSNumber = self[TB_cell_height_key as! Key] as! NSNumber
        return CGFloat(number.floatValue)
    }
    
    
}
