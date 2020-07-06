//
//  Entry.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


/// 入口
struct Entry {
    var title:String?
    var vc:UIViewController.Type?
    
}

extension Entry : CHGTableViewCellModelProtocol {
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return EntryTableViewCell.self
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}


