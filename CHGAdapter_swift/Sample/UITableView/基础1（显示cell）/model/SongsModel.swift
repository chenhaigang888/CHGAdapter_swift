//
//  SongsModel.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/3.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


struct SongsModel {
    var name:String?
    var cover:String?
    
}

//当SongsModel在UITableView中显示的时候实现以下协议
extension SongsModel : CHGTableViewCellModelProtocol {
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return SongsModelTableViewCell.self
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



