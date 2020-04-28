//
//  CVTitleModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CVTitleModel: NSObject {
    var name:String?
    var aaa:Int? = 998
    
    
    init(name:String) {
        super.init()
        self.name = name
    }
    
}

extension CVTitleModel : CHGCollectionViewCellModelProtocol {
    
    func cellClassName(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        return CVTitleCollectionViewCell.self
    }
    
////以下注释的代码为设置item的大小
//    func cellItemSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 1 {
//            return CGSize.init(width: 150, height: 150)
//        }
//        return CGSize.init(width: 100, height: 100)
//    }
    
}
