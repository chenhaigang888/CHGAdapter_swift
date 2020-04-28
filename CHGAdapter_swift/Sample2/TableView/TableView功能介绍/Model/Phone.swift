//
//  Phone.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit


/// 手机
class Phone: NSObject {
    var brand:String?
    
    init(brand:String?) {
        super.init()
        self.brand = brand
    }
    
}

extension Phone : CHGTableViewCellModelProtocol {
    func cellClassName(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return PhoneTableViewCell.self
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
