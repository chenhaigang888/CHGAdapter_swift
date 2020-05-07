//
//  CHGTableViewHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

public enum CHGTableViewHeaderFooterViewType {
    case HeaderType
    case FooterType
}

open class CHGTableViewHeaderFooterView: UITableViewHeaderFooterView,CHGTableViewHeaderFooterLifeCycleProtocol {
    open var protocolsVMK: [ViewMappingKey]? = [ViewMappingKey]()
    
    open var section: Int?
    
    open var type: CHGTableViewHeaderFooterViewType?
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
    
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
}
