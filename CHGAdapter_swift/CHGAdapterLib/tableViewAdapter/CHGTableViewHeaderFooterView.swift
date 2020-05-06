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
    open var section: Int?
    
    open var type: CHGTableViewHeaderFooterViewType?
    
    open func headerFooter(for section: Int, in tableView: UITableView, model: Any, type: CHGTableViewHeaderFooterViewType, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.section = section
        self.targetView = tableView
        self.model = model
        self.type = type
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocols:[CHGTableViewHeaderFooterLifeCycleProtocol] = protocols as? [CHGTableViewHeaderFooterLifeCycleProtocol] else { return }
        for item in protocols {
            item.headerFooter(for: section, in: tableView, model: model, type: type,eventTransmissionBlock: eventTransmissionBlock)
        }
        
    }
    
    open func headerFooterViewWillReuse(with identifier: String) {
        guard let protocols:[CHGTableViewHeaderFooterLifeCycleProtocol] = protocols as? [CHGTableViewHeaderFooterLifeCycleProtocol] else { return }
        for item in protocols {
            item.headerFooterViewWillReuse(with: identifier)
        }
    }
    
    open func headerFooterViewWillAppear(with type: CHGTableViewHeaderFooterViewType) {
        guard let protocols:[CHGTableViewHeaderFooterLifeCycleProtocol] = protocols as? [CHGTableViewHeaderFooterLifeCycleProtocol] else { return }
        for item in protocols {
            item.headerFooterViewWillAppear(with: type)
        }
    }
    
    open func headerFooterViewDidDisAppear(with type: CHGTableViewHeaderFooterViewType) {
        guard let protocols:[CHGTableViewHeaderFooterLifeCycleProtocol] = protocols as? [CHGTableViewHeaderFooterLifeCycleProtocol] else { return }
        for item in protocols {
            item.headerFooterViewDidDisAppear(with: type)
        }
    }
    
    open var eventTransmissionBlock: CHGEventTransmissionBlock?
    
    weak open var targetView: UIView?
    
    open var model: Any?
    
    open var protocols: [Any]? = [Any]()
    
}
