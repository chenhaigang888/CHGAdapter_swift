//
//  CHGBaseView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/5/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

open class CHGBaseView : UIView, CHGViewLifeCycleProtocol, CHGTableViewHeaderFooterLifeCycleProtocol, CHGCollectionReusableViewLifeCycleProtocol {
    
    open var protocolsVMO: [ViewMappingObject]? = [ViewMappingObject]()
    
    open var indexPath: IndexPath?
    
    open func cellForRowAt(indexPath: IndexPath, targetView: UIView, model: Any, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.indexPath = indexPath;
        self.targetView = targetView;
        self.model = model;
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        
        for viewKey in protocolsVMO {
            if let view:CHGViewLifeCycleProtocol = viewKey.view as? CHGViewLifeCycleProtocol {
                if let mapping = viewKey.mapping, let key:AnyKeyPath = mapping[.CellType] as? AnyKeyPath, let subModel = model[keyPath:key] {
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
    
    open var section: Int?
    
    open var type: CHGAdapterViewType?
    
    open func headerFooter(for section: Int, in tableView: UITableView, model: Any, type: CHGAdapterViewType, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.section = section
        self.targetView = tableView
        self.model = model
        self.type = type
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGTableViewHeaderFooterLifeCycleProtocol = viewKey.view as? CHGTableViewHeaderFooterLifeCycleProtocol {
                if let mapping = viewKey.mapping, let key:AnyKeyPath = mapping[.CellType] as? AnyKeyPath, let subModel = model[keyPath:key] {
                    view.headerFooter(for: section, in: tableView, model: subModel, type: type, eventTransmissionBlock: eventTransmissionBlock)
                } else {
                    view.headerFooter(for: section, in: tableView, model: model, type: type, eventTransmissionBlock: eventTransmissionBlock)
                }
            }
        }
    }
    
    open func headerFooterViewWillReuse(with identifier: String) {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGTableViewHeaderFooterLifeCycleProtocol = viewKey.view as? CHGTableViewHeaderFooterLifeCycleProtocol  {
                view.headerFooterViewWillReuse(with: identifier)
            }
        }
    }
    
    open func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGTableViewHeaderFooterLifeCycleProtocol = viewKey.view as? CHGTableViewHeaderFooterLifeCycleProtocol  {
                view.headerFooterViewWillAppear(with: type)
            }
        }
    }
    
    open func headerFooterViewDidDisAppear(with type: CHGAdapterViewType) {
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
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
        self.eventTransmissionBlock = eventTransmissionBlock
        
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
    }
    
}
