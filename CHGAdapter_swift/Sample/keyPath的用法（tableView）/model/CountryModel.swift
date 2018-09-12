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
    func headerFooterClass(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> String {
        return "CountryHeaderFooterView"
    }
    
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger, type: CHGTableViewHeaderFooterViewType) -> CGFloat {
        return 30
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inTableView tableView: UITableView) -> Any {
        return \CountryModel.citys
    }
    
}

extension CountryModel: CHGCollectionViewSupplementaryElementModelProtocol {
    func reusableViewInCollectionView(collectionView: UICollectionView, supplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> String {
        return "CountyCollectionReusableView"
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
    func cellClassName(_ tableView: UITableView, indexPath: IndexPath) -> String {
        return "CityTableViewCell"
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return -1
    }
}

extension CityModel: CHGCollectionViewCellModelProtocol {
    func cellClassNameInCollectionView(collectionView: UICollectionView, atIndexPath: IndexPath) -> String {
        return "CityCollectionViewCell"
    }
    
    
}
