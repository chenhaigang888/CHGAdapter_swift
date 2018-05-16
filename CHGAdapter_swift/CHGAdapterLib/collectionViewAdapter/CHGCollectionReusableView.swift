//
//  CHGCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class CHGCollectionReusableView: UICollectionReusableView {
    
    var eventTransmissionBlock:CHGEventTransmissionBlock?
    var indexPath:IndexPath?
    var collectionView:UICollectionView?
    var reusableViewData:AnyObject?
    var kind:NSString?
    
    func reusableViewFor(collectionView:UICollectionView,indexPath:IndexPath,kind:NSString,reusableViewData:AnyObject?) -> Void {
        self.collectionView = collectionView
        self.indexPath = indexPath
        self.kind = kind
        self.reusableViewData = reusableViewData
    }
}
