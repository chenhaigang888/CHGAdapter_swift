//
//  CHGCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGCollectionReusableView: UICollectionReusableView,CHGCollectionReusableViewLifeCycleProtocol {
    open var protocolsVMO: [ViewMappingObject]? = [ViewMappingObject]()
    
    open var indexPath: IndexPath?
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    open var kind: String?
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
    open func reusableView(for collectionView: UICollectionView, indexPath: IndexPath, kind: String, model: Any,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        self.targetView = collectionView;
        self.indexPath = indexPath;
        self.kind = kind;
        self.model = model;
        
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGCollectionReusableViewLifeCycleProtocol = viewKey.view as? CHGCollectionReusableViewLifeCycleProtocol {
                let type:CHGAdapterViewType = kind == UICollectionView.elementKindSectionHeader ? .HeaderType : .FooterType//这里不用判断cell的情况
                if let mapping = viewKey.mapping, let key:AnyKeyPath = mapping[type] as? AnyKeyPath, let subModel = model[keyPath:key] {
                    view.reusableView(for: collectionView, indexPath: indexPath, kind: kind, model: subModel, eventTransmissionBlock: eventTransmissionBlock)
                } else {
                    view.reusableView(for: collectionView, indexPath: indexPath, kind: kind, model: model, eventTransmissionBlock: eventTransmissionBlock)
                }
            }
        }
    }
    
    open func reusableViewWillReuse(with identifier: String, indexPath: IndexPath) {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGCollectionReusableViewLifeCycleProtocol = viewKey.view as? CHGCollectionReusableViewLifeCycleProtocol {
                view.reusableViewWillReuse(with: identifier, indexPath: indexPath)
            }
        }
    }
    
    open func reusableViewWillAppear() {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGCollectionReusableViewLifeCycleProtocol = viewKey.view as? CHGCollectionReusableViewLifeCycleProtocol {
                view.reusableViewWillAppear()
            }
        }
    }
    
    open func reusableViewDidDisappear() {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGCollectionReusableViewLifeCycleProtocol = viewKey.view as? CHGCollectionReusableViewLifeCycleProtocol  {
                view.reusableViewDidDisappear()
            }
        }
    }
    
    
}
