//
//  CountryModel.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// 国家
class CountryModel: NSObject {

    var name:String?
    var citys:[CityModel]?
    
    init(name:String,citys:[CityModel]) {
        super.init()
        self.name = name
        self.citys = citys
    }
}

extension CountryModel: CHGTableViewHeaderFooterModelProtocol {
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> AnyClass? {
        return CountryHeaderFooterView.classForCoder()
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGAdapterViewType) -> CGFloat {
        return 30
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inTableView tableView: UITableView) -> Any {
        return \CountryModel.citys
    }
    
}

extension CountryModel: CHGCollectionViewSupplementaryElementModelProtocol {
    func reusableView(collectionView: UICollectionView, supplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> AnyClass? {
        return CountyCollectionReusableView.self
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inCollectionView collectionView: UICollectionView) -> Any {
        return \CountryModel.citys
    }
}

/// 城市
class CityModel: NSObject {
    var name:String?
    
    init(name:String) {
        super.init()
        self.name = name
    }
    
}

extension CityModel: CHGTableViewCellModelProtocol {
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return CityTableViewCell.classForCoder()
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return -1
    }
}

extension CityModel: CHGCollectionViewCellModelProtocol {
    func cellClass(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        return CityCollectionViewCell.self
    }
    
    
}
