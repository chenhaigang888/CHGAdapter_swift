//
//  CHGTableView+CHGTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import Foundation
import UIKit

private var tableViewAdapterKey: Void?
private var eventTransmissionBlockKey: Void?
private var tableViewDidSelectRowBlockKey: Void?
private var tableViewEmptyDataShowKey: Void?

extension UITableView {
    
    open var tableViewAdapter:CHGTableViewAdapter? {
        get {
            return objc_getAssociatedObject(self, &tableViewAdapterKey) as? CHGTableViewAdapter
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewAdapterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.delegate = newValue
            self.dataSource = newValue
        }
    }
    
    open var eventTransmissionBlock:CHGEventTransmissionBlock? {
        get {
            return objc_getAssociatedObject(self, &eventTransmissionBlockKey) as? CHGEventTransmissionBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &eventTransmissionBlockKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open func setEventTransmissionBlock(eventTransmissionBlock:@escaping CHGEventTransmissionBlock) -> Void {
        self.eventTransmissionBlock = eventTransmissionBlock
    }
    
    open var tableViewDidSelectRowBlock:CHGTableViewDidSelectRowBlock? {
        get {
            return objc_getAssociatedObject(self, &tableViewDidSelectRowBlockKey) as? CHGTableViewDidSelectRowBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewDidSelectRowBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    open func setTableViewDidSelectRowBlock(tableViewDidSelectRowBlock:@escaping CHGTableViewDidSelectRowBlock) -> Void {
        self.tableViewDidSelectRowBlock = tableViewDidSelectRowBlock
    }
    
    open var tableViewEmptyDataShow:CHGTableViewEmptyDataShow? {
        get {
            return objc_getAssociatedObject(self, &tableViewEmptyDataShowKey) as? CHGTableViewEmptyDataShow
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewEmptyDataShowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    

    
    open func setEmptyDataShow(_ title:NSString?,imageName:NSString?) -> Void {
        
    }
    
    open func hiddHeadView() -> Void {
        
    }
    
    open func hiddenFooterView() -> Void {
        
    }
    
    open func autoHeight() -> Void {
        
    }
    
}
