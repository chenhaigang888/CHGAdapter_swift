//
//  ProductsType.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

/// 产品类型
struct ProductsType {
    //产品类型名称
    var name:String?
    
    /// 产品
    var productses:[Products]?
    
    var desc:String?
    
}

extension ProductsType : CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        if type == .HeaderType {//如果是头
            return ProductsTypeHeaderFooterView.self
        } else {//如果是尾
            return ProductsTypeFooterHeaderFooterView.self
        }
        
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 50
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inTableView tableView: UITableView) -> Any {
        return \ProductsType.productses
    }
}
