//
//  CVHeaderModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CVHeaderModel: NSObject {

    var name:String?
    var bgColor:UIColor = UIColor.white
    
    init(name:String,bgColor:UIColor) {
        super.init()
        self.name = name
        self.bgColor = bgColor
    }
    
}

extension CVHeaderModel: CHGCollectionViewSupplementaryElementModelProtocol {
    
    func reusableViewInCollectionView(collectionView: UICollectionView, supplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> String {
        return "CVHeaderCollectionReusableView"
    }
    
    ///以下注释的代码为设置cell 和 header footer view的布局信息
//    func sectionInsetInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if section == 0 {
//            return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
//        }
//        return UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
//    }
//
//    func minimumLineSpacingInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 30
//        }
//        return 80
//    }
//
//    func minimumInteritemSpacingCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 30
//        }
//        return 150
//    }
//
//    func referenceHeaderSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
//        if section == 0 {
//            return CGSize.init(width: collectionView.frame.width, height: 30)
//        }
//        return CGSize.init(width: collectionView.frame.width, height: 80)
//    }
//
//    func referenceFooterSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
//        if section == 0 {
//            return CGSize.init(width: collectionView.frame.width, height: 30)
//        }
//        return CGSize.init(width: collectionView.frame.width, height: 80)
//    }
    
}
