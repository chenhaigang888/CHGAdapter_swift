//
//  Products.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


/// 产品
struct Products {
    var name:String?
    var price:String?
    var image:String?
    var desc:String?
}

extension Products : CHGTableViewCellModelProtocol {
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return ProductsTableViewCell.self
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
