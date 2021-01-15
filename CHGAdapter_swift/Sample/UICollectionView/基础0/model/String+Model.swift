//
//  String+Model.swift
//  CHGAdapter_swift
//
//  Created by 陈海刚 on 2021/1/15.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit


extension String : CHGCollectionViewCellModelProtocol {
    public func cellClass(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        StringCollectionViewCell.self
    }
    
    public func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = UIScreen.main.bounds.width * 0.48
        return CGSize(width: w, height: w)
    }
}

extension String : CHGTableViewCellModelProtocol {
    public func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        StringTableViewCell.self
    }
    
    public func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        44
    }
    
    
}
