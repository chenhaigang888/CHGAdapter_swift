//
//  TVInputTextModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVInputTextModel: NSObject {

    var placeholder:String?
    var inputText:String = ""
    
    init(placeholder:String) {
        super.init()
        self.placeholder = placeholder
    }
    
}

extension TVInputTextModel: CHGTableViewCellModelProtocol {
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return TVInputTextTableViewCell.classForCoder()
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return -1
    }
    
    
}
