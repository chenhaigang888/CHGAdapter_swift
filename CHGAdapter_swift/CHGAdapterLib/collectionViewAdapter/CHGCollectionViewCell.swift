//
//  CHGCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGCollectionViewCell: UICollectionViewCell {
    open var eventTransmissionBlock:CHGEventTransmissionBlock?
    open var indexPath:IndexPath?
    weak open var collectionView:UICollectionView?
    open var cellData:Any?
    
    open func cellForRow(atIndexPath indexPath:IndexPath,collectionView:UICollectionView?,data:Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) -> Void {
        self.indexPath = indexPath
        self.collectionView = collectionView
        self.cellData = data
        self.eventTransmissionBlock = eventTransmissionBlock
    }
    
    open func adapterTag()->NSInteger? {
        return self.collectionView?.collectionViewAdapter?.tag
    }
    
    open func customData()->Any? {
        return self.collectionView?.collectionViewAdapter?.adapterData.customData
    }
    
    open func controller()->UIViewController?{
        return self.collectionView?.collectionViewAdapter?.controller
    }
    
    /**
     将被复用
     
     @param identifier identifier
     @param indexPath indexPath
     */
    open func willReuseWithIdentifier(identifier:NSString,indexPath:NSIndexPath)->Void {
        
    }
    
    /**
     cell将要显示
     */
    open func cellWillAppear()->Void {
        
    }
    
    /**
     cell已经消失
     */
    open func cellDidDisappear()->Void {
        
    }
}
