//
//  User.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/7.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import Foundation
import UIKit

struct User : CHGTableViewCellModelProtocol{
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return UserTableViewCell.self
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    var name:String?
    var friends:[Friend]?

}

struct Friend : CHGCollectionViewCellModelProtocol{
    func cellClass(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        FriendCollectionViewCell.self
    }
    
    func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    var name:String?
    var sex:Int = 1
}
