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
    
    var tableViewAdapter:CHGTableViewAdapter? {
        get {
            return objc_getAssociatedObject(self, &tableViewAdapterKey) as? CHGTableViewAdapter
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewAdapterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.delegate = newValue
            self.dataSource = newValue
        }
    }
    
    var eventTransmissionBlock:CHGEventTransmissionBlock? {
        get {
            return objc_getAssociatedObject(self, &eventTransmissionBlockKey) as? CHGEventTransmissionBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &eventTransmissionBlockKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setEventTransmissionBlock(eventTransmissionBlock:@escaping CHGEventTransmissionBlock) -> Void {
        self.eventTransmissionBlock = eventTransmissionBlock
    }
    
    var tableViewDidSelectRowBlock:CHGTableViewDidSelectRowBlock? {
        get {
            return objc_getAssociatedObject(self, &tableViewDidSelectRowBlockKey) as? CHGTableViewDidSelectRowBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewDidSelectRowBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    var tableViewEmptyDataShow:CHGTableViewEmptyDataShow? {
        get {
            return objc_getAssociatedObject(self, &tableViewEmptyDataShowKey) as? CHGTableViewEmptyDataShow
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewEmptyDataShowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setEmptyDataShow(_ title:NSString?,imageName:NSString?) -> Void {
        
    }
    
    func hiddHeadView() -> Void {
        
    }
    
    func hiddenFooterView() -> Void {
        
    }
    
    func autoHeight() -> Void {
        
    }
    
}
