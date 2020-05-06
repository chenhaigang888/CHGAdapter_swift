//
//  CHGCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGCollectionViewCell: UICollectionViewCell,CHGViewLifeCycleProtocol {
    open var indexPath: IndexPath?
    
    open func cellForRowAt(indexPath: IndexPath, targetView: UIView, model: Any, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.indexPath = indexPath;
        self.targetView = targetView;
        self.model = model;
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocols:[CHGViewLifeCycleProtocol] = protocols as? [CHGViewLifeCycleProtocol] else { return }
        for item in protocols {
            item.cellForRowAt(indexPath: indexPath, targetView: targetView, model: model, eventTransmissionBlock: eventTransmissionBlock)
        }
    }
    
    open func cellWillReuse(with identifier: String) {
        guard let protocols:[CHGViewLifeCycleProtocol] = protocols as? [CHGViewLifeCycleProtocol] else { return }
        for item in protocols {
            item.cellWillReuse(with: identifier)
        }
    }
    
    open func cellWillReuse(with identifier: String, indexPath: IndexPath) {
        guard let protocols:[CHGViewLifeCycleProtocol] = protocols as? [CHGViewLifeCycleProtocol] else { return }
        for item in protocols {
            item.cellWillReuse(with: identifier, indexPath: indexPath)
        }
    }
    
    open func cellWillAppear() {
        guard let protocols:[CHGViewLifeCycleProtocol] = protocols as? [CHGViewLifeCycleProtocol] else { return }
        for item in protocols {
            item.cellWillAppear()
        }
    }
    
    open func cellDidDisappear() {
        guard let protocols:[CHGViewLifeCycleProtocol] = protocols as? [CHGViewLifeCycleProtocol] else { return }
        for item in protocols {
            item.cellDidDisappear()
        }
    }
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
    open var protocols: [Any]? = [Any]()
    
//    open var eventTransmissionBlock:CHGEventTransmissionBlock?
//    open var indexPath:IndexPath?
//    weak open var collectionView:UICollectionView?
//    open var cellData:Any?
//
//    open func cellForRow(atIndexPath indexPath:IndexPath,collectionView:UICollectionView?,data:Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) -> Void {
//        self.indexPath = indexPath
//        self.collectionView = collectionView
//        self.cellData = data
//        self.eventTransmissionBlock = eventTransmissionBlock
//    }
//
//    open func adapterTag()->NSInteger? {
//        return self.collectionView?.collectionViewAdapter?.tag
//    }
//
//    open func customData()->Any? {
//        return self.collectionView?.collectionViewAdapter?.adapterData.customData
//    }
//
//    open func controller()->UIViewController?{
//        return self.collectionView?.collectionViewAdapter?.controller
//    }
//
//    /**
//     将被复用
//
//     @param identifier identifier
//     @param indexPath indexPath
//     */
//    open func willReuseWithIdentifier(identifier:NSString,indexPath:NSIndexPath)->Void {
//
//    }
//
//    /**
//     cell将要显示
//     */
//    open func cellWillAppear()->Void {
//
//    }
//
//    /**
//     cell已经消失
//     */
//    open func cellDidDisappear()->Void {
//
//    }
}
