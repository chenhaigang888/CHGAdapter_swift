//
//  CHGBaseView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/5/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

open class CHGBaseView : UIView, CHGViewLifeCycleProtocol, CHGTableViewHeaderFooterLifeCycleProtocol, CHGCollectionReusableViewLifeCycleProtocol {
    
    open var protocols: [Any]? = [Any]()
    
    open var indexPath: IndexPath?
    
    open func cellForRowAt(indexPath: IndexPath, targetView: UIView, model: Any, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        self.indexPath = indexPath;
        self.targetView = targetView;
        self.model = model;
        self.eventTransmissionBlock = eventTransmissionBlock
        
        guard let protocols:[CHGViewLifeCycleProtocol] = protocols as? [CHGViewLifeCycleProtocol] else { return }
        for item in protocols {
            item.cellForRowAt(indexPath: indexPath, targetView: targetView, model: model, eventTransmissionBlock: eventTransmissionBlock)
        }
    }
    
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
    
    open var kind: String?
    
    open func reusableView(for collectionView: UICollectionView, indexPath: IndexPath, kind: String, model: Any,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        self.targetView = collectionView;
        self.indexPath = indexPath;
        self.kind = kind;
        self.model = model;
        
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
    
    
    private var _eventTransmissionBlock: CHGEventTransmissionBlock?
    open var eventTransmissionBlock: CHGEventTransmissionBlock?{
        get {
            return _eventTransmissionBlock
            
        }
        set(newValue) {
            _eventTransmissionBlock = newValue
            guard let protocols:[CHGViewLifeCycleProtocol] = protocols as? [CHGViewLifeCycleProtocol] else { return }
            for var item in protocols {
                item.eventTransmissionBlock = newValue
            }
        }
    }
    
    
    
    weak open var targetView: UIView?
    
    open var model: Any?

}
