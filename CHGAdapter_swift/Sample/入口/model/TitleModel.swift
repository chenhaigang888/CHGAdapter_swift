//
//  TitleModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

/// 这是一个cell的Model
class TitleModel: NSObject {
    var name:String?
    
    init(name:String) {
        super.init()
        self.name = name
    }
}


// MARK: - 如果TitleModel类需要在TableView类中的Cell中使用则需要实现CHGTableViewCellModelProtocol协议
extension TitleModel: CHGTableViewCellModelProtocol {
    func cellClassName(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return TitleTableViewCell.self
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return -1//返回cell的高度，-1表示跟进约束自动判断cell的高度
    }
}

// MARK: - 如果TitleModel类需要在TableView类中的HeadFooterView中使用则需要实现CHGTableViewHeaderFooterModelProtocol协议
extension TitleModel: CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> AnyClass? {
        return nil//"这里填写tableView的HeadFooterView类名 必须是CHGTableViewHeaderFooterView的子类"
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> CGFloat {
        return 30
    }
}

// MARK: - 如果TitleModel类需要在CollectionView类中的Cell中使用则需要实现CHGCollectionViewCellModelProtocol协议
extension TitleModel: CHGCollectionViewCellModelProtocol {
    func cellClassName(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        return TitleCollectionViewCell.self
    }
}

// MARK: - 如果TitleModel类需要在CollectionView类中的Cell中使用则需要实现CHGCollectionViewSupplementaryElementModelProtocol协议
extension TitleModel: CHGCollectionViewSupplementaryElementModelProtocol {
    func reusableView(collectionView: UICollectionView, supplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> AnyClass? {
        return nil//"这里填写collectionView的HeadFooterView类名 必须是CHGCollectionReusableView的子类"
    }
}
