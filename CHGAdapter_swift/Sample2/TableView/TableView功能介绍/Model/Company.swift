//
//  Company.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

/// 公司
class Company: NSObject {

    ///公司名称
    var name:String?
    ///产品
    var products:[Any]?
        
    init( name:String,products:[Any]) {
        super.init()
        self.name = name
        self.products = products
    }
    
}

extension Company : CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        return CompanyHeaderFooterView.classForCoder()
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 30
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inTableView tableView: UITableView) -> Any {
        return \Company.products
    }
    
    
}
