//
//  CHGCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class CHGCollectionViewCell: UICollectionViewCell {
    var eventTransmissionBlock:CHGEventTransmissionBlock?
    var indexPath:IndexPath?
    var collectionView:UICollectionView?
    var cellData:AnyObject?
    
    func cellForRow(atIndexPath indexPath:IndexPath,collectionView:UICollectionView?,data:AnyObject?) -> Void {
        self.indexPath = indexPath
        self.collectionView = collectionView;
        self.cellData = data;
    }
}
