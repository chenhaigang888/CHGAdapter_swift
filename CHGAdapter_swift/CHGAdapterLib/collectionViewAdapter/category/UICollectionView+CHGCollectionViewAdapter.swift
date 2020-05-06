//
//  UICollectionView+CHGCollectionViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import Foundation
import UIKit
//import DZNEmptyDataSet
import EmptyDataSet_Swift

private var collectionViewAdapterKey:Void?
private var eventTransmissionBlockKey:Void?
private var collectionViewDidSelectItemAtIndexPathBlockKey:Void?
private var collectionViewEmptyDataShowKey:Void?
private var scrollListenerKey:Void?

extension UICollectionView {
    
    open var collectionViewAdapter:CHGCollectionViewAdapter? {
        get {
            guard let adapter = objc_getAssociatedObject(self, &collectionViewAdapterKey) as? CHGCollectionViewAdapter else {
                self.collectionViewAdapter = CHGSimpleCollectionViewAdapter.init()
                return self.collectionViewAdapter
            }
            return adapter
            
        }
        set(newValue) {
            objc_setAssociatedObject(self, &collectionViewAdapterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.delegate = newValue
            self.dataSource = newValue
        }
    }
    
    open var scrollListener: ScrollListener? {
        get {
            let  scrollListener = objc_getAssociatedObject(self, &scrollListenerKey)
            guard scrollListener != nil else {
                self.scrollListener = ScrollListener()
                return self.scrollListener
            }
            return scrollListener as? ScrollListener
        }
        set(newValue) {
            objc_setAssociatedObject(self, &scrollListenerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open var eventTransmissionBlock:CHGEventTransmissionBlock? {
        get {
            return objc_getAssociatedObject(self, &eventTransmissionBlockKey) as? CHGEventTransmissionBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &eventTransmissionBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    open func setEventTransmissionBlock(eventTransmissionBlock:@escaping CHGEventTransmissionBlock) -> Void {
        self.eventTransmissionBlock = eventTransmissionBlock
    }
    
    open var collectionViewDidSelectItemAtIndexPathBlock:CHGCollectionViewDidSelectItemAtIndexPathBlock? {
        get {
            return objc_getAssociatedObject(self, &collectionViewDidSelectItemAtIndexPathBlockKey) as? CHGCollectionViewDidSelectItemAtIndexPathBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &collectionViewDidSelectItemAtIndexPathBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    open func setCollectionViewDidSelectItemAtIndexPathBlock(collectionViewDidSelectItemAtIndexPathBlock:@escaping CHGCollectionViewDidSelectItemAtIndexPathBlock) -> Void {
        self.collectionViewDidSelectItemAtIndexPathBlock = collectionViewDidSelectItemAtIndexPathBlock
    }
    
    open var collectionViewEmptyDataShow:CHGCollectionViewEmptyDataShow? {
        get {
            return objc_getAssociatedObject(self, &collectionViewEmptyDataShowKey) as? CHGCollectionViewEmptyDataShow
        }
        set(newValue) {
            objc_setAssociatedObject(self, &collectionViewEmptyDataShowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.setEmpty(newValue!, delegate: newValue!)
        }
    }
    
    open func setEmptyDataShow(_ title:NSString?,imageName:NSString?) -> Void {
        let collectionViewEmptyDataShow = CHGCollectionViewEmptyDataShow.init()
        collectionViewEmptyDataShow.imageName = imageName!
        collectionViewEmptyDataShow.title = title!
        collectionViewEmptyDataShow.emptyDataSetShouldAllowScroll = true
        self.collectionViewEmptyDataShow = collectionViewEmptyDataShow;
    }
    
    private func setEmpty(_ dataSource:EmptyDataSetSource,delegate:EmptyDataSetDelegate) ->Void {
        self.emptyDataSetSource = dataSource
        self.emptyDataSetDelegate = delegate
    }
    
}

// MARK: - 增加快速使用的API
extension UICollectionView {
    open var adapterData: CHGCollectionViewAdapterData {
        get {
            return (self.collectionViewAdapter?.adapterData)!
        }
        set {
            self.collectionViewAdapter?.adapterData = newValue
        }
    }
    
    open var cellDatas: [Any]? {
        get {
            return self.collectionViewAdapter?.adapterData.cellDatas
        }
        set {
            self.collectionViewAdapter?.adapterData.cellDatas = newValue
        }
    }
    
    open var footerDatas: [Any]? {
        get {
            return self.collectionViewAdapter?.adapterData.footerDatas
        }
        set {
            self.collectionViewAdapter?.adapterData.footerDatas = newValue
        }
    }
    
    open var headerDatas: [Any]? {
        get {
            return self.collectionViewAdapter?.adapterData.headerDatas
        }
        set {
            self.collectionViewAdapter?.adapterData.headerDatas = newValue
        }
    }
    
    open var customData: Any? {
        get {
            return self.collectionViewAdapter?.adapterData.customData
        }
        set {
            self.collectionViewAdapter?.adapterData.customData = newValue
        }
    }
    
}
