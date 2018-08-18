//
//  TitleModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TitleModel: NSObject {
    var name:String?
    
    init(name:String) {
        super.init()
        self.name = name
    }
}

extension TitleModel: CHGTableViewCellModelProtocol {
    func cellClassName(_ tableView: UITableView, indexPath: IndexPath) -> String {
        return "TitleTableViewCell"
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return -1//返回cell的高度，-1表示跟进约束自动判断cell的高度
    }
    
    
}
