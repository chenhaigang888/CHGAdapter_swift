//
//  CHGCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGCollectionReusableView: UICollectionReusableView {
    
    public var eventTransmissionBlock:CHGEventTransmissionBlock?
    public var indexPath:IndexPath?
    public var collectionView:UICollectionView?
    public var reusableViewData:AnyObject?
    public var kind:NSString?
    
    open func reusableViewFor(collectionView:UICollectionView,indexPath:IndexPath,kind:NSString,reusableViewData:AnyObject?) -> Void {
        self.collectionView = collectionView
        self.indexPath = indexPath
        self.kind = kind
        self.reusableViewData = reusableViewData
    }
    
    open func adapterTag()->NSInteger? {
        return self.collectionView?.collectionViewAdapter?.tag
    }
    
    open func customData()->AnyObject? {
        return self.collectionView?.collectionViewAdapter?.adapterData?.customData
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
    open func reusableViewWillAppear()->Void {
        
    }
    
    /**
     cell已经消失
     */
    open func reusableViewDidDisappear()->Void {
        
    }
}
