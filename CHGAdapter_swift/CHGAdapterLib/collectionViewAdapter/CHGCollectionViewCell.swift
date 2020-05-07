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
    open var protocolsVMK: [ViewMappingKey]? = [ViewMappingKey]()
    
    open func cellForRowAt(indexPath: IndexPath, targetView: UIView, model: Any, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.indexPath = indexPath;
        self.targetView = targetView;
        self.model = model;
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol {
                if let key:AnyKeyPath = viewKey.key, let subModel = model[keyPath:key] {
                    view.cellForRowAt(indexPath: indexPath, targetView: targetView, model: subModel, eventTransmissionBlock: eventTransmissionBlock)
                } else {
                    view.cellForRowAt(indexPath: indexPath, targetView: targetView, model: model, eventTransmissionBlock: eventTransmissionBlock)
                }
            }
        }
    }
    
    open func cellWillReuse(with identifier: String) {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol {
                view.cellWillReuse(with: identifier)
            }
        }
    }
    
    open func cellWillReuse(with identifier: String, indexPath: IndexPath) {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol  {
                view.cellWillReuse(with: identifier, indexPath: indexPath)
            }
        }
    }
    
    open func cellWillAppear() {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol {
                view.cellWillAppear()
            }
        }
    }
    
    open func cellDidDisappear() {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol  {
                view.cellDidDisappear()
            }
        }
    }
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
}
