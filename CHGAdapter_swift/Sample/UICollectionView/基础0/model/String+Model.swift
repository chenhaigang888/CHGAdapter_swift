//
//  String+Model.swift
//  CHGAdapter_swift
//
//  Created by 陈海刚 on 2021/1/15.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

//String 在collectionView的cell中
extension String : CHGCollectionViewCellModelProtocol {
    public func cellClass(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        StringCollectionViewCell.self
    }
    
    public func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = UIScreen.main.bounds.width * 0.48
        return CGSize(width: w, height: w)
    }
}

//String 在collectionView的Header，footer中
extension String : CHGCollectionViewSupplementaryElementModelProtocol {
    public func reusableView(collectionView: UICollectionView, supplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> AnyClass? {
        StringCollectionReusableView.self
    }
    
    public func referenceHeaderSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 20)
    }
    
    public func referenceFooterSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 20)
    }
}

//String 在tableView的cell中
extension String : CHGTableViewCellModelProtocol {
    public func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        StringTableViewCell.self
    }
    
    public func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        44
    }
}

//String 在tableView的Header，footer中
extension String : CHGTableViewHeaderFooterModelProtocol {
    public func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        StringTableViewHeaderFooterView.self
    }
    
    public func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        44
    }
    
}


