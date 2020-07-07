//
//  Singer.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


/// 歌手
struct Singer {
    
    /// 歌手名字
    var name:String?
    
    /// 歌曲
    var songs:[SongsModel] = [SongsModel]()
    
    var desc:String?
    
}

extension Singer : CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        if type == .HeaderType {
            return SingerHeaderFooterView.self
        } else {
            return SingerDescHeaderFooterView.self
        }
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 50
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inTableView tableView: UITableView) -> Any {
        return \Singer.songs
    }
}

