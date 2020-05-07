//
//  CHGBaseView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/5/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

open class CHGBaseView : UIView, CHGViewLifeCycleProtocol, CHGTableViewHeaderFooterLifeCycleProtocol, CHGCollectionReusableViewLifeCycleProtocol {
    
    open var protocolsVMK: [ViewMappingKey]? = [ViewMappingKey]()
    
    open var indexPath: IndexPath?
    
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
    
    open var section: Int?
    
    open var type: CHGTableViewHeaderFooterViewType?
    
    open func headerFooter(for section: Int, in tableView: UITableView, model: Any, type: CHGTableViewHeaderFooterViewType, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.section = section
        self.targetView = tableView
        self.model = model
        self.type = type
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGTableViewHeaderFooterLifeCycleProtocol = viewKey.view as? CHGTableViewHeaderFooterLifeCycleProtocol {
                if let key:AnyKeyPath = viewKey.key, let subModel = model[keyPath:key] {
                    view.headerFooter(for: section, in: tableView, model: subModel, type: type, eventTransmissionBlock: eventTransmissionBlock)
                } else {
                    view.headerFooter(for: section, in: tableView, model: model, type: type, eventTransmissionBlock: eventTransmissionBlock)
                }
            }
        }
    }
    
    open func headerFooterViewWillReuse(with identifier: String) {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGTableViewHeaderFooterLifeCycleProtocol = viewKey.view as? CHGTableViewHeaderFooterLifeCycleProtocol  {
                view.headerFooterViewWillReuse(with: identifier)
            }
        }
    }
    
    open func headerFooterViewWillAppear(with type: CHGTableViewHeaderFooterViewType) {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGTableViewHeaderFooterLifeCycleProtocol = viewKey.view as? CHGTableViewHeaderFooterLifeCycleProtocol  {
                view.headerFooterViewWillAppear(with: type)
            }
        }
    }
    
    open func headerFooterViewDidDisAppear(with type: CHGTableViewHeaderFooterViewType) {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGTableViewHeaderFooterLifeCycleProtocol = viewKey.view as? CHGTableViewHeaderFooterLifeCycleProtocol {
                view.headerFooterViewDidDisAppear(with: type)
            }
        }
    }
    
    open var kind: String?
    
    open func reusableView(for collectionView: UICollectionView, indexPath: IndexPath, kind: String, model: Any,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        self.targetView = collectionView;
        self.indexPath = indexPath;
        self.kind = kind;
        self.model = model;
        
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGCollectionReusableViewLifeCycleProtocol = viewKey.view as? CHGCollectionReusableViewLifeCycleProtocol {
                if let key:AnyKeyPath = viewKey.key, let subModel = model[keyPath:key] {
                    view.reusableView(for: collectionView, indexPath: indexPath, kind: kind, model: subModel, eventTransmissionBlock: eventTransmissionBlock)
                } else {
                    view.reusableView(for: collectionView, indexPath: indexPath, kind: kind, model: model, eventTransmissionBlock: eventTransmissionBlock)
                }
            }
        }
    }
    
    open func reusableViewWillReuse(with identifier: String, indexPath: IndexPath) {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGCollectionReusableViewLifeCycleProtocol = viewKey.view as? CHGCollectionReusableViewLifeCycleProtocol {
                view.reusableViewWillReuse(with: identifier, indexPath: indexPath)
            }
        }
    }
    
    open func reusableViewWillAppear() {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGCollectionReusableViewLifeCycleProtocol = viewKey.view as? CHGCollectionReusableViewLifeCycleProtocol {
                view.reusableViewWillAppear()
            }
        }
    }
    
    open func reusableViewDidDisappear() {
        guard let protocolsVMK:[ViewMappingKey] = protocolsVMK else { return }
        for viewKey in protocolsVMK {
            if let view:CHGCollectionReusableViewLifeCycleProtocol = viewKey.view as? CHGCollectionReusableViewLifeCycleProtocol  {
                view.reusableViewDidDisappear()
            }
        }
    }
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
}
