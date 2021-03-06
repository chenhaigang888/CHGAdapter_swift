//
//  CHGTableViewHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

public enum CHGAdapterViewType: Int {
    case HeaderType
    case CellType
    case FooterType
}

open class CHGTableViewHeaderFooterView: UITableViewHeaderFooterView,CHGTableViewHeaderFooterLifeCycleProtocol {
    open var indexPath: IndexPath?
    
    open var kind: String?
    
    open var protocolsVMO: [ViewMappingObject]? = [ViewMappingObject]()
    
    open var section: Int?
    
    open var type: CHGAdapterViewType?
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
    
    open func headerFooter(for section: Int, in tableView: UITableView, model: Any, type: CHGAdapterViewType, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.section = section
        self.targetView = tableView
        self.model = model
        self.type = type
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocolsVMO:[ViewMappingObject] = protocolsVMO else { return }
        for viewKey in protocolsVMO {
            if let view:CHGTableViewHeaderFooterLifeCycleProtocol = viewKey.view as? CHGTableViewHeaderFooterLifeCycleProtocol {
                if let mapping = viewKey.mapping, let key:AnyKeyPath = mapping[type] as? AnyKeyPath, let subModel = model[keyPath:key] {
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
    
    open func addAutoDistributionModel(view:CHGViewProtocol, mapping:[CHGAdapterViewType:Any]?) -> Void {
        self.protocolsVMO?.append(ViewMappingObject.init(view: view, mapping: mapping))
    }
    
    open func replaceAt(index: Int, autoDistributionModel view: CHGViewProtocol, mapping: [CHGAdapterViewType : Any]?) {
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
