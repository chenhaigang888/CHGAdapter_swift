//
//  LoginHeader.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

struct LoginHeader {
    var name:String
    
}

extension LoginHeader : CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        return LoginHeaderFooterView.self
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 100
    }
    
    
}
