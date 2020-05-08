//
//  GoodsCategory.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/11.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class GoodsCategory: NSObject {

    var name:String?//商品分类名称
    var goods:[Goods]?//商品
    
    init(name:String,goods:[Goods]) {
        super.init()
        self.name = name
        self.goods = goods
    }
}

extension GoodsCategory: CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        return GoodsCategoryTableViewHeaderFooterView.classForCoder()
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 30
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inTableView tableView: UITableView) -> Any {
        return \GoodsCategory.goods
    }
    
}

extension GoodsCategory: CHGCollectionViewSupplementaryElementModelProtocol {
    func reusableView(collectionView: UICollectionView, supplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> AnyClass? {
        return GoodsCategoryCollectionReusableView.self
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inCollectionView collectionView: UICollectionView) -> Any {
        return \GoodsCategory.goods
    }
    
}

class Goods: NSObject {
    
    var name:String?//商品名称
    var price:Double?//商品价格
    
    init(name:String,price:Double) {
        super.init()
        self.name = name
        self.price = price
    }
}

extension Goods: CHGTableViewCellModelProtocol {
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return GoodsTableViewCell.classForCoder()
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return -1
    }
    
}

extension Goods: CHGCollectionViewCellModelProtocol {
    func cellClass(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        return GoodsCollectionViewCell.self
    }
    
}
