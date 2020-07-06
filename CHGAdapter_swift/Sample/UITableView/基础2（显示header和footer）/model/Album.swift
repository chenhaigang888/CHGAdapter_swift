//
//  Album.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/3.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


struct Album {
    
    /// 专辑名称
    var name:String?
    /// 专辑发布时间
    var createTime:String?
    
}

extension Album : CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        return AlbumTableViewHeaderFooterView.self
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 30
    }
    
    
}
