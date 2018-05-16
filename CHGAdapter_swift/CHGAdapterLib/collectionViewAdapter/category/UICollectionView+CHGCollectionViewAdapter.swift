//
//  UICollectionView+CHGCollectionViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import Foundation
import UIKit

private var collectionViewAdapterKey:Void?
private var eventTransmissionBlockKey:Void?
private var collectionDidSelectRowBlockKey:Void?
private var collectionViewEmptyDataShowKey:Void?

extension UICollectionView {
    
    var collectionViewAdapter:CHGCollectionViewAdapter? {
        get {
            return objc_getAssociatedObject(self, &collectionViewAdapterKey) as? CHGCollectionViewAdapter
        }
        set(newValue) {
            objc_setAssociatedObject(self, &collectionViewAdapterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.delegate = newValue
            self.dataSource = newValue
        }
    }
    
    var eventTransmissionBlock:CHGEventTransmissionBlock? {
        get {
            return objc_getAssociatedObject(self, &eventTransmissionBlockKey) as? CHGEventTransmissionBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &eventTransmissionBlockKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setEventTransmissionBlock(eventTransmissionBlock:@escaping CHGEventTransmissionBlock) -> Void {
        self.eventTransmissionBlock = eventTransmissionBlock
    }
    
    var collectionDidSelectRowBlock:CHGCollectionDidSelectRowBlock? {
        get {
            return objc_getAssociatedObject(self, &collectionDidSelectRowBlockKey) as? CHGCollectionDidSelectRowBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &collectionDidSelectRowBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func setCollectionDidSelectRowBlock(collectionDidSelectRowBlock:@escaping CHGCollectionDidSelectRowBlock) -> Void {
        self.collectionDidSelectRowBlock = collectionDidSelectRowBlock
    }
    
    var collectionViewEmptyDataShow:CHGCollectionViewEmptyDataShow? {
        get {
            return objc_getAssociatedObject(self, &collectionViewEmptyDataShowKey) as? CHGCollectionViewEmptyDataShow
        }
        set(newValue) {
            objc_setAssociatedObject(self, &collectionViewEmptyDataShowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setEmptyDataShow(_ title:NSString?,imageName:NSString?) -> Void {
        
    }
    
    func hiddHeadView() -> Void {
        
    }
    
    func hiddenFooterView() -> Void {
        
    }
    
    func autoHeight() -> Void {
        
    }
}
