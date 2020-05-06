//
//  CHGCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGCollectionReusableView: UICollectionReusableView,CHGCollectionReusableViewLifeCycleProtocol {
    open var indexPath: IndexPath?
    
     open func reusableView(for collectionView: UICollectionView, indexPath: IndexPath, kind: String, model: Any, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.targetView = collectionView;
        self.indexPath = indexPath;
        self.kind = kind;
        self.model = model;
        self.eventTransmissionBlock = eventTransmissionBlock
        
           guard let protocols:[CHGCollectionReusableViewLifeCycleProtocol] = protocols as? [CHGCollectionReusableViewLifeCycleProtocol] else { return }
           for item in protocols {
               item.reusableView(for: collectionView, indexPath: indexPath, kind: kind, model: model, eventTransmissionBlock: eventTransmissionBlock)
           }
       }
       
       open func reusableViewWillReuse(with identifier: String, indexPath: IndexPath) {
           guard let protocols:[CHGCollectionReusableViewLifeCycleProtocol] = protocols as? [CHGCollectionReusableViewLifeCycleProtocol] else { return }
           for item in protocols {
               item.reusableViewWillReuse(with: identifier, indexPath: indexPath)
           }
       }
       
       open func reusableViewWillAppear() {
           guard let protocols:[CHGCollectionReusableViewLifeCycleProtocol] = protocols as? [CHGCollectionReusableViewLifeCycleProtocol] else { return }
           for item in protocols {
               item.reusableViewWillAppear()
           }
       }
       
       open func reusableViewDidDisappear() {
           guard let protocols:[CHGCollectionReusableViewLifeCycleProtocol] = protocols as? [CHGCollectionReusableViewLifeCycleProtocol] else { return }
           for item in protocols {
               item.reusableViewDidDisappear()
           }
       }
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    open var kind: String?
    
    
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
    open var protocols: [Any]? = [Any]()
    
    
}
