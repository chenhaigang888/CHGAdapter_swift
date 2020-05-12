//
//  CHGCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGCollectionViewCell: UICollectionViewCell,CHGViewLifeCycleProtocol {
    public var section: Int?
    
    public var type: CHGAdapterViewType?
    
    public var kind: String?
    
    open var indexPath: IndexPath?
    open var protocolsVMO: [ViewMappingObject]? = [ViewMappingObject]()
    
    open func cellForRowAt(indexPath: IndexPath, targetView: UIView, model: Any, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.indexPath = indexPath;
        self.targetView = targetView;
        self.model = model;
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol {
                if let mapping = viewKey.mapping, let key:AnyKeyPath = mapping[.CellType]! as? AnyKeyPath, let subModel = model[keyPath:key] {
                    view.cellForRowAt(indexPath: indexPath, targetView: targetView, model: subModel, eventTransmissionBlock: eventTransmissionBlock)
                } else {
                    view.cellForRowAt(indexPath: indexPath, targetView: targetView, model: model, eventTransmissionBlock: eventTransmissionBlock)
                }
            }
        }
    }
    
    open func cellWillReuse(with identifier: String) {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol {
                view.cellWillReuse(with: identifier)
            }
        }
    }
    
    open func cellWillReuse(with identifier: String, indexPath: IndexPath) {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol  {
                view.cellWillReuse(with: identifier, indexPath: indexPath)
            }
        }
    }
    
    open func cellWillAppear() {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol {
                view.cellWillAppear()
            }
        }
    }
    
    open func cellDidDisappear() {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol  {
                view.cellDidDisappear()
            }
        }
    }
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
    
    open func addAutoDistributionModel(view:CHGViewProtocol, mapping:[CHGAdapterViewType:Any]?) -> Void {
        self.protocolsVMO?.append(ViewMappingObject.init(view: view, mapping: mapping))
    }
    
    public func replaceAt(index: Int, autoDistributionModel view: CHGViewProtocol, mapping: [CHGAdapterViewType : Any]?) {
        guard let range:Range<Int> = Range<Int>.init(NSMakeRange(index, 1)) else { return }
        self.protocolsVMO?.replaceSubrange(range, with: [ViewMappingObject.init(view: view, mapping: mapping)])
    }
    
    open func removeAutoDistributionModelViewAt(index:Int) -> Void {
        self.protocolsVMO?.remove(at: index)
    }
    
    open func removeAutoDistributionModelView() -> Void {
        self.protocolsVMO?.removeAll()
    }}
