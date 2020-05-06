//
//  CHGTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGTableViewCell: UITableViewCell,CHGViewLifeCycleProtocol {
    open func cellForRowAt(indexPath: IndexPath, targetView: UIView, model: Any, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.indexPath = indexPath
        self.targetView = targetView
        self.model = model
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocols:[CHGViewLifeCycleProtocol] = protocols as? [CHGViewLifeCycleProtocol] else { return }
        for item in protocols {
            item.cellForRowAt(indexPath: indexPath, targetView: targetView, model: model, eventTransmissionBlock: eventTransmissionBlock)
        }
    }
    
    open var indexPath: IndexPath?
    
    
    
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
    
}

